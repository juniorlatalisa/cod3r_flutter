import 'package:flutter/material.dart';
import 'package:projeto_perguntas/resposta.dart';
import 'package:projeto_perguntas/questao.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.responder,
  });

  bool get temPerguntaSelecionada => perguntaSelecionada < perguntas.length;

  @override
  Widget build(BuildContext context) {
    final _pergunta = perguntas[perguntaSelecionada];
    final List<Map<String, Object>> _respostas =
        temPerguntaSelecionada ? _pergunta['respostas'] : null;
    return Column(
      children: <Widget>[
        Questao(_pergunta['texto']),
        ..._respostas.map((resp) => Resposta(resp, responder))
      ],
    );
  }
}
