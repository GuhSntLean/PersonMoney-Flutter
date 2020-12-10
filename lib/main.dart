import 'package:flutter/material.dart';
import 'model/Transaction.dart';

void main() => runApp(PesonMoney());

class PesonMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _MyHomePage());
  }
}

class _MyHomePage extends StatelessWidget {
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
    Transaction(
      id: 't3',
      title: 'Calça nova',
      value: 80.00,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App despesas'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Grafico'),
                elevation: 5,
              ),
            ),
            Column(
              children: _transaction.map((transaction) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(transaction.value.toString(),
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
                            transaction.date.toString(),
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
              }).toList(),
            ),
          ],
        ));
  }
}
