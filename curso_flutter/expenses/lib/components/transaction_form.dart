import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  // String title;
  // String value;
  final title = TextEditingController();
  final value = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  _submitForm() {
    final title = this.title.text;
    final value = double.tryParse(this.value.text) ?? 0.0;
    if (title.isEmpty || value < 0.01) {
      return;
    }
    onSubmit(title, value);
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
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              FlatButton(
                child: Text('Nova Transação'),
                textColor: Colors.purple,
                onPressed: () => _submitForm(),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
