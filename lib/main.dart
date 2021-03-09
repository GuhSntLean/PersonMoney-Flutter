import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import './model/Transaction.dart';

import './widgets/TransactionForm.dart';
import './widgets/TransactionList.dart';
import 'widgets/Chart.dart';

void main() => runApp(PesonMoney());

class PesonMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: _MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ),  
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  __MyHomePageState createState() => __MyHomePageState();
}

class __MyHomePageState extends State<_MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;
  
  List<Transaction> get _recentTransaction{
    return _transaction.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now()
        .subtract(
          Duration(days: 7),
        )
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id){
    setState(() {
      _transaction.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas pessoais', 
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        if(isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
            onPressed: () => {
              setState(() {
                _showChart = !_showChart;
              })
            },
          ),
      ],
    ); 

    final availableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(_showChart || !isLandscape) 
              Container(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransaction),
              ),
            if(!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transaction, _deleteTransaction)
              ),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS ? Container()
      :FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
