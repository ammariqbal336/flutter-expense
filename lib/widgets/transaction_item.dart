import 'dart:math';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.removetx,
  }) : super(key: key);

  final Transaction transaction;
  final Function removetx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  
  late Color _color;
  @override
  void initState() {
    
    super.initState();

    const list = [Colors.red,Colors.yellow,Colors.orange,Colors.purple];
    _color = list[Random().nextInt(4)];
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                  color: _color, width: 2),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              "\$${widget.transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.transaction.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  DateFormat.yMMMd().format(widget.transaction.date),
                  style:
                      const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          MediaQuery.of(context).size.width > 480
              ? TextButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  label: Text(
                    "Delete",
                    style:
                        TextStyle(color: Theme.of(context).errorColor),
                  ),
                  onPressed: () => widget.removetx(widget.transaction.id))
              : IconButton(
                  onPressed: () => widget.removetx(widget.transaction.id),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ))
        ],
      ),
    );
  }
}
