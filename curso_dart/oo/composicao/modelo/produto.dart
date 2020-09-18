class Produto {
  int codigo;
  String nome;
  double preco;
  double desconto;

  Produto({this.codigo, this.nome, this.preco, this.desconto = 0});

  double get precoComDesconto {
    if (preco == null) {
      return 0;
    }
    if ((desconto == null) || !(desconto > 0)) {
      return preco;
    }
    var valor = preco * desconto / 100.0;
    return preco - valor;
  }
}
