import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_datepicker.dart';
import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _title = TextEditingController();
  final _value = TextEditingController();

  var _selectedDate = DateTime.now();

  @override
  void initState() {
    //Chamado uma unica vez na inicialização do estado
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TransactionForm oldWidget) {
    //Chamado na mudança do componente
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //Chamado quando o componente deixa de estar visivel.
    super.dispose();
  }

  _submitForm() {
    final title = this._title.text;
    final value = double.tryParse(this._value.text) ?? 0.0;
    if (title.isEmpty || value < 0.01 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
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
              AdaptativeTextField(
                controller: _title,
                label: 'Título',
              ),
              AdaptativeTextField(
                controller: _value,
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true, //Permitir decimal no ios
                ),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                initialDateTime: _selectedDate,
                onChange: (datePicker) =>
                    setState(() => _selectedDate = datePicker),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                AdaptativeButton(
                  label: 'Nova Transação',
                  onPresed: _submitForm,
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
