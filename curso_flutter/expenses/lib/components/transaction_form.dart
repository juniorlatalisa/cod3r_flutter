import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  // String title;
  // String value;
  final title = TextEditingController();
  final value = TextEditingController();

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
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              FlatButton(
                child: Text('Nova Transação'),
                textColor: Colors.purple,
                onPressed: () =>
                    // print('\nTítulo: $title \nValor: $value'),
                    print('\nTítulo: ${title.text} \nValor: ${value.text}'),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
