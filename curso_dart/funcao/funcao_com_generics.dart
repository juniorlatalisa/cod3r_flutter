//Object segundoElementoV1(List lista) {
segundoElementoV1(List lista) {
  return (lista == null || lista.length < 2) ? null : lista[1];
}

E segundoElementoV2<E>(List<E> lista) {
  return (lista == null || lista.length < 2) ? null : lista[1];
}

main() {
  var lista = [3, 6, 7, 12, 45, 78, 1];

  print(segundoElementoV1(lista));

  int segundoElemento = segundoElementoV2<int>(lista);
  print(segundoElemento);

  var segundoElementoInducao = segundoElementoV2(lista);
  print(segundoElementoInducao);
}
