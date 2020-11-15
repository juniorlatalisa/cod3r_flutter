import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final title = TextEditingController();
  final value = TextEditingController();

  _submitForm() {
    final title = this.title.text;
    final value = double.tryParse(this.value.text) ?? 0.0;
    if (title.isEmpty || value < 0.01) {
      return;
    }
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              // onChanged: (newValue) => title = newValue,
              controller: title,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              // onChanged: (newValue) => value = newValue,
              controller: value,
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
                  Text('Nenhuma data selecionada!'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
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
    );
  }
}
