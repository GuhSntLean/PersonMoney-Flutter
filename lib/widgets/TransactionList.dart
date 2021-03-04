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
        child: _transaction.isEmpty ? Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Nenhuma transação cadastrada !',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ) : ListView.builder(
          itemCount: _transaction.length,
          itemBuilder: (cxt, index) {
            final transaction = _transaction[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5,),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('R\$${transaction.value}'),
                    ),
                  ),
                ),
                title: Text(
                  transaction.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(transaction.date),
                ),
              ),
            );
          },
        ));
  }
}
