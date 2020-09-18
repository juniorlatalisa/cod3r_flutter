main() {
  var notas = [8.2, 7.1, 6.2, 4.4, 3.9, 9.8, 9.1, 5.1];

  // bool Function(double) notasBoasFn = (double nota) => nota >= 7;
  // var notasBoas = notas.where(notasBoasFn);

  // var notasBoas = notas.where((nota) => nota >= 7);

  const notasBoasValor = 7;
  const notasMuitoBoasValor = 8.8;

  var notasBoas = notas.where((nota) => nota >= notasBoasValor);
  var notasMuitoBoas = notas.where((nota) => nota >= notasMuitoBoasValor);

  print(notas);
  print(notasBoas);
  print(notasMuitoBoas);
}
