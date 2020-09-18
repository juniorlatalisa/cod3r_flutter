import 'dart:math';

void executar({Function fnPar, Function fnImpar}) {
  var sorteado = Random().nextInt(10);
  print('O valor sorteado foi $sorteado');
  sorteado % 2 == 0 ? fnPar() : fnImpar();
}

main(List<String> args) {
  var minhaFnPar = () => print('Eita! O valor é par!');
  // var minhaFnImpar = () => print('Legal! O valor é ímpar!');
  executar(fnImpar: () => print('Legal! O valor é ímpar!'), fnPar: minhaFnPar);
}