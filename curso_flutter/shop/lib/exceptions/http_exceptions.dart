class HttpException implements Exception {
  final String mensagem;

  const HttpException(this.mensagem);

  @override
  String toString() {
    return mensagem;
  }
}
