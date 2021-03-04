import 'package:flutter/material.dart';
import 'package:person_money/model/Transaction.dart';
import 'package:intl/intl.dart';
import 'package:person_money/widgets/ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      
      double totalSum = 0.0;
      for(var i = 0; i < recentTransaction.length; i++){
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;
        if(sameDay && sameMonth && sameYear){
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0], 
        'value': totalSum
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, transaction) {
      return sum + transaction['value'];
    });
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child:ChartBar(
                label: transaction['day'],
                value: transaction['value'],
                percentage: 0 >= transaction['value'] ? 00 : (transaction['value'] as double) / _weekTotalValue,
              )
            );
          }).toList(),
        ),
      ),
    );
  }
}