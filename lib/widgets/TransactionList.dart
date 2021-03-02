import 'package:flutter/material.dart';
import '../model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;

  TransactionList(this._transaction);

@override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemCount: _transaction.length,
          itemBuilder: (cxt, index) {
            final transaction = _transaction[index];
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple[400],
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text('R\$${transaction.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple[200],
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        DateFormat('d MMMM y').format(transaction.date),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
