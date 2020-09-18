main() {
  var notas = [7.3, 5.4, 7.7, 8.1, 5.5, 4.9, 9.1, 10.0];
  var total = notas.reduce(somar);
  print("Total: $total");

  print(notas.map((nota) => nota.toString()).reduce(concatenar));
}

double somar(double a, double b) {
  print("valor de a: $a valor de b $b");
  return a + b;
}

String concatenar(String a, String b) {
  // print("valor de a: $a valor de b $b");
  return "$a -> $b";
}
