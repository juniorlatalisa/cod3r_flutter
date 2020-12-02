import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _title = TextEditingController();
  final _value = TextEditingController();

  var _dataSelecionada = DateTime.now();

  _submitForm() {
    final title = this._title.text;
    final value = double.tryParse(this._value.text) ?? 0.0;
    if (title.isEmpty || value < 0.01 || _dataSelecionada == null) {
      return;
    }
    widget.onSubmit(title, value, _dataSelecionada);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicker) {
      if (datePicker == null) {
        return;
      }
      setState(() => _dataSelecionada = datePicker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                // onChanged: (newValue) => title = newValue,
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                // onChanged: (newValue) => value = newValue,
                controller: _value,
                //onSubmitted: (value) => _submitForm(),
                onSubmitted: (_) => _submitForm(), // _ para ignorar o parametro
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true, //Permitir decimal no ios
                ),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Data selecionada:  ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Selecionar data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                RaisedButton(
                  child: Text('Nova Transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: () => _submitForm(),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
