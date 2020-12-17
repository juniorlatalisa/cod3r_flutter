import 'package:expenses/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onChange;

  const AdaptativeDatePicker({this.initialDateTime, this.onChange});

  @override
  Widget build(BuildContext context) {
    final firstDate = DateTime(2019);
    final lastDate = DateTime.now();
    return isIOSPlatform
        ? Container(
            height: 100,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDateTime,
              minimumDate: firstDate,
              maximumDate: lastDate,
              onDateTimeChanged: onChange,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Data selecionada:  ${DateFormat('dd/MM/y').format(initialDateTime)}',
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: const Text(
                    'Selecionar data',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => showDatePicker(
                    context: context,
                    initialDate: initialDateTime,
                    firstDate: firstDate,
                    lastDate: lastDate,
                  ).then((value) => onChange(value)),
                )
              ],
            ),
          );
  }
}
