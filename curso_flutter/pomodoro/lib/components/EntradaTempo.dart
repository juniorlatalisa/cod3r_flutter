import 'package:flutter/material.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;

  const EntradaTempo({
    Key? key,
    required this.titulo,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.titulo),
        Text('${this.valor}'),
      ],
    );
  }
}
