import 'package:expense/widgets/chartbar.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> list;
  const Chart({required this.list, Key? key}) : super(key: key);

  List<Map<String, Object>> get groupTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var i = 0; i < list.length; i++) {
        if (list[i].date.day == weekDay.day &&
            list[i].date.month == weekDay.month &&
            list[i].date.year == weekDay.year) {
          totalAmount += list[i].amount;
        }
      }
     
      return {"date": DateFormat.E().format(weekDay), "amount": totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransaction.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  SizedBox(height: 5,),
                  Text('Chart',style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 5,),
                  Expanded(
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: groupTransaction.map((e) {
                            return Flexible(
                              fit: FlexFit.tight,
                              child: ChartBar(
                                  title: e['date'] as String,
                                  amount: e['amount'] as double,
                                  amountPer: totalSpending == 0.0 ? 0.0 : (e['amount'] as double) / totalSpending),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
        ],
      
      ),
    );
  }
}
