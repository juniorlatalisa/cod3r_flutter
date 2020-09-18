import 'dart:math';

import '../modelo/carro.dart';

main() {
  var carro = Carro(Random().nextInt(300));
  print('\n\t* O carro esta parado: ${carro.estaParado() ? "Sim" : "Não"}\n');
  while (!carro.estaNoLimite()) {
    print('Acelerando.... Velocidade em ${carro.acelerar()} Km/h');
  }
  print(
      '\n\t* O carro esta no limite: ${carro.estaNoLimite() ? "Sim" : "Não"}\n');
  while (!carro.estaParado()) {
    print('Freando.... Velocidade em ${carro.frear()} Km/h');
  }
  print('\n\t* O carro esta parado: ${carro.estaParado() ? "Sim" : "Não"}');

  carro.velocidadeAtual = 500;
  print("\nO carro parou com a velocidade ${carro.velocidadeAtual} Km/h");
}
