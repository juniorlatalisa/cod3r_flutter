import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final Map<String, Object> resposta;
  final void Function(int) quandoSelecionado;

  Resposta(this.resposta, this.quandoSelecionado);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        child: Text(resposta['texto']),
        onPressed: () => quandoSelecionado(resposta['nota']),
      ),
    );
  }
}
