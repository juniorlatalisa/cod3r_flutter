import 'dart:math';

main(List<String> args) {
  int n1 = numeroAleatorio(100);
  print(n1);

  int n2 = numeroAleatorio();
  print(n2);

  imprimirData(10, 12, 2020);
  imprimirData(10, 12);
  imprimirData(10);
  // imprimirData();
}

/*
  O parametro opcional fica entre colchetes
  Exemplo: [int maximo]
  Não é obrigatório ter valor padrão, mas se necessário este poderá ser 
  informado.
  Exemplo: [int maximo = 11]
*/
int numeroAleatorio([int maximo = 11]) {
  return Random().nextInt(maximo);
}

imprimirData(int dia, [int mes = 1, int ano = 1970]) {
  print('$dia/$mes/$ano');
}
