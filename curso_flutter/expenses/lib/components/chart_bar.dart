import 'package:flutter/material.dart';

class ChartBat extends StatelessWidget {
  final String label;
  final double value;
  final double percentege;

  ChartBat(this.label, this.value, this.percentege);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('R\$${value.toStringAsFixed(2)}'),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
