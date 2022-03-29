import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

import '../components/resultado_widget.dart';
import '../components/tabuleiro_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  final Tabuleiro _tabuleiro = Tabuleiro(
    linhas: 12,
    colunas: 12,
    qtdeBombas: 3,
  );

  void _reiniciar() {
    print('Reiniciar...');
  }

  void _abrir(Campo campo) {
    print('Abrir...');
  }

  void _alternarMarcacao(Campo campo) {
    print('Alternar marcação...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: TabuleiroWidget(
          tabuleiro: _tabuleiro,
          onAbrir: _abrir,
          onAlternarMarcacao: _alternarMarcacao,
        ),
      ),
    );
  }
}
