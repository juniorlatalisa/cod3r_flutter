class Carro {
  final int velocidadeMaxima;

  /*
    O "_" transforma em "privado" para outros arquivos.
    No mesmo arquivo ainda é "visível".
  */
  int _velocidadeAtual;

  Carro(this.velocidadeMaxima) {
    this._velocidadeAtual = 0;
  }

  /*
    Getter
  */
  int get velocidadeAtual => this._velocidadeAtual;

  /*
    Setter
  */
  void set velocidadeAtual(int velocidade) {
    if (velocidade >= 0 && velocidade <= velocidadeMaxima) {
      this._velocidadeAtual = velocidade;
    }
  }

  int acelerar() {
    final aceleracao = _velocidadeAtual + 5;
    return _velocidadeAtual =
        (aceleracao > velocidadeMaxima) ? velocidadeMaxima : aceleracao;
  }

  int frear() {
    final desaceleracao = _velocidadeAtual - 5;
    return _velocidadeAtual = (desaceleracao < 0) ? 0 : desaceleracao;
  }

  bool estaNoLimite() {
    return _velocidadeAtual == velocidadeMaxima;
  }

  bool estaParado() {
    return _velocidadeAtual == 0;
  }
}
