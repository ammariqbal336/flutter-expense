import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function callback;
  

  const NewTransaction({required this.callback, Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextController = TextEditingController();
  final amountTextController = TextEditingController();
  DateTime? _selectedDate;
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2011),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  _addTransaction() {
    if(amountTextController.text.isEmpty){
      return;
    }
    String title = titleTextController.text;
    double amount = double.parse(amountTextController.text);

    if (title.isEmpty || amount < 0 || _selectedDate == null) {
      return;
    }

    widget.callback(title, amount,_selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding:  EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleTextController,
                decoration: const InputDecoration(labelText: "Title"),
                onSubmitted: (_) => _addTransaction(),
              ),
              TextField(
                controller: amountTextController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
                onSubmitted: (_) => _addTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: _selectedDate == null
                            ? Text("No date is selected")
                            : Text(DateFormat.yMd().format(_selectedDate!))),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Choose Date",
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: _addTransaction,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    "Add transaction",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
