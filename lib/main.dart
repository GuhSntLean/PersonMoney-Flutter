import 'package:flutter/material.dart';

void main() => runApp(PesonMoney());

class _MyPesonMoneyState extends State<PesonMoney> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('O que é isso velhinho ?', textAlign: TextAlign.center),
          ),
        ),
        body: Container(),
      ),
    );
  }
}

class PesonMoney extends StatefulWidget {
  @override
  _MyPesonMoneyState createState() => _MyPesonMoneyState();
}
