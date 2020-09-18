import 'dart:math';

import '../modelo/carro.dart';

main() {
  var carro = Carro(Random().nextInt(300));
  print('\t* O carro esta parado: ${carro.estaParado() ? "Sim" : "Não"}\n');
  while (!carro.estaNoLimite()) {
    print('Acelerando....\nVelocidade em ${carro.acelerar()} KM/h\n');
  }
  print(
      '\t* O carro esta no limite: ${carro.estaNoLimite() ? "Sim" : "Não"}\n');
  while (!carro.estaParado()) {
    print('Freando....\nVelocidade em ${carro.frear()} KM/h\n');
  }
  print('\t* O carro esta parado: ${carro.estaParado() ? "Sim" : "Não"}');
}
