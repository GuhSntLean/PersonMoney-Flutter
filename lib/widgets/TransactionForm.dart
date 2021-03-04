import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2021), 
      lastDate: DateTime.now()
    ).then((picketDate) {
      if(picketDate == null){
        return;
      }      
      setState(() {
        _selectedDate = picketDate;
      });
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Titulo',
                ),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.all(0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _selectedDate == null ? 'Sem data selecionada!' 
                      : DateFormat('dd/MM/y').format(_selectedDate)
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker, 
                      child: Text(
                        'Selecione uma data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start, 
                children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: EdgeInsets.all(10),
                  onPressed: _submitForm,
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: Text('Nova transação'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
