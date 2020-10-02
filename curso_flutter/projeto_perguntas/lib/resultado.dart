import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Center(
          child: Text(
            'Parabéns',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ));
  }
}
