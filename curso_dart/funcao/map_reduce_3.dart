main() {
  var alunos = [
    {'nome': 'Alfredo', 'nota': 9.9},
    {'nome': 'Wilson', 'nota': 9.3},
    {'nome': 'Mariana', 'nota': 8.7},
    {'nome': 'Guilherme', 'nota': 8.1},
    {'nome': 'Ana', 'nota': 7.6},
    {'nome': 'Ricardo', 'nota': 6.8},
  ];

  var total = alunos //
      // .map((aluno) => aluno['nota'])
      // .map((nota) => (nota as double))
      .map((aluno) => (aluno['nota'] as double))
      .where((nota) => nota > 0.1)
      .reduce((t, a) => t + a);

  print("O valor da média é ${total / alunos.length}");
}
