import 'dart:math';

import '../modelo/cliente.dart';
import '../modelo/produto.dart';
import '../modelo/venda.dart';
import '../modelo/venda_item.dart';

Venda novaVenda(int quantidade1, int quantidade2) {
  var cliente = Cliente(nome: 'Cliente 01', cpf: '12345678900');
  var produto1 = Produto(codigo: 1, nome: 'Produto 1', preco: 1.99);
  var produto2 =
      Produto(codigo: 2, nome: 'Produto 2', preco: 101.16, desconto: 15.0);

  var compra1 = VendaItem(produto: produto1, quantidade: quantidade1);
  var compra2 = VendaItem(produto: produto2, quantidade: quantidade2);

  return Venda(cliente: cliente, itens: [compra1, compra2]);
}

main() {
  final random = Random();
  var venda = novaVenda(random.nextInt(99), random.nextInt(10));

  print('-------------------------------------------------------');
  print('* * *  CUPOM DE VENDA * * *');
  print('Cliente ....:\t${venda.cliente.nome} - ${venda.cliente.cpf}');
  print('-------------------------------------------------------');
  print('Qtd\tDescrição\tVlr.Unit.\tValor');
  print('-------------------------------------------------------');
  venda.itens.forEach((item) => print(
      '${item.quantidade}\t${item.produto.nome}\t${item.preco}\t\t${item.preco * item.quantidade}'));
  print('-------------------------------------------------------');
  print('Total ......:\t${venda.valorTotal}');
}
