import 'dart:math';

import 'package:flutter/material.dart';
import 'TransactionForm.dart';
import 'TransactionList.dart';
import '../model/Transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 't1',
      title: 'Curso novo',
      value: 21.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cueca nova',
      value: 50.00,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transaction.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transaction),
      ],
    );
  }
}
