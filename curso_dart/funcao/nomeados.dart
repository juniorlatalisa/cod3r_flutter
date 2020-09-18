main(List<String> args) {
  saudarPessoa(nome: "João", idade: 33);
  saudarPessoa(idade: 47, nome: "Maria");

  // imprimirData(10);
  imprimirData(7);
  imprimirData(7, ano: 2020);
  imprimirData(7, ano: 2020, mes: 12);
}

saudarPessoa({String nome, int idade}) {
  print("Olá $nome nem parece que vc tem $idade anos.");
}

imprimirData(int dia, {int mes = 1, int ano = 1970}) {
  print('$dia/$mes/$ano');
}
