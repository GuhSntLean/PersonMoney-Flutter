import 'package:flutter/material.dart';
import '../model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  final void Function(String) onRemove;

  TransactionList(this._transaction, this.onRemove);

@override
  Widget build(BuildContext context) {
    return _transaction.isEmpty ? 
      LayoutBuilder(builder: (context, constraints) {
        return Column(
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.01
                    ),
                    Text(
                      'Nenhuma transação cadastrada !',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
      },
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
            trailing: MediaQuery.of(context).size.width > 470 ? 
            // ignore: deprecated_member_use
            FlatButton.icon(
              onPressed: () => onRemove(transaction.id), 
              icon: Icon(Icons.delete),
              label: Text('Excluir'),
              textColor: Theme.of(context).errorColor,
            )
            :IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => onRemove(transaction.id),
            ),
          ),
        );
      },
    );
  }
}
