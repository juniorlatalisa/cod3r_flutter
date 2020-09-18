main() {
  int Function(int, int) soma1 = somaFn;
  print(soma1(20, 313));

  int Function(int, int) soma2 = (x, y) {
    return x + y;
  };
  print(soma2(20, 313));

  var soma3 = (int x, int y) {
    return x + y;
  };
  print(soma3(20, 313));
}

int somaFn(int a, int b) {
  return a + b;
}
