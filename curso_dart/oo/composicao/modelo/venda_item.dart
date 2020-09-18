import 'produto.dart';

class VendaItem {
  Produto produto;
  int quantidade;
  double _preco;

  VendaItem({this.produto, this.quantidade = 1});

  double get preco {
    if (_preco == null && produto != null) {
      _preco = produto.precoComDesconto;
    }
    return (_preco == null) ? 0 : _preco;
  }

  void set preco(double valor) {
    if (valor > 0) {
      _preco = valor;
    }
  }
}
