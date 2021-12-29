import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  final Function removetx;
  const TransactionList({required this.list, required this.removetx, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: list.map((e) => TransactionItem(transaction: e, removetx: removetx,key: ValueKey(e.id),)).toList(),
      )
    );
  }
}

