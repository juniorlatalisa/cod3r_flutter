int Function(int) somaParcial(int a) {
  const c = 0;
  return (int b) => a + b + c;
}

main() {
  print(somaParcial(2)(10));

  var somaCom10 = somaParcial(10);

  for (var i = 0; i < 10; i++) {
    print(somaCom10(i));
  }
}
