import 'package:flutter/material.dart';

class ChartBat extends StatelessWidget {
  final String label;
  final double value;

  ChartBat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Text('$label: $value');
  }
}
