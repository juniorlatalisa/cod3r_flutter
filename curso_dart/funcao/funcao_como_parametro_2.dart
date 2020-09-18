int executarPor(int qtde, String Function(String, int) fn, String valor) {
  String textoCompleto = '';
  for (var i = 0; i < qtde; i++) {
    textoCompleto += fn(valor, i);
  }
  return textoCompleto.length;
}

main() {
  String retorno;
  print(retorno = 'Teste');

  var meuPrint = (String valor, int indice) {
    print(retorno = valor + indice.toString());
    return retorno;
  };

  int tamanho = executarPor(10, meuPrint, 'Muito legal ');

  print('O ultimo retorno foi: "$retorno" e o tamanho total é $tamanho');
}
