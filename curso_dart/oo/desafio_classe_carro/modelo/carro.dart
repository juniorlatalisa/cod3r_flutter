class Carro {
  final int velocidadeMaxima;
  int velocidadeAtual;

  Carro(this.velocidadeMaxima) {
    this.velocidadeAtual = 0;
  }

  int acelerar() {
    velocidadeAtual += 5;
    if (velocidadeAtual > velocidadeMaxima) {
      velocidadeAtual = velocidadeMaxima;
    }
    return velocidadeAtual;
  }

  int frear() {
    velocidadeAtual -= 5;
    if (velocidadeAtual < 0) {
      velocidadeAtual = 0;
    }
    return velocidadeAtual;
  }

  bool estaNoLimite() {
    return velocidadeAtual == velocidadeMaxima;
  }

  bool estaParado() {
    return velocidadeAtual == 0;
  }
}
