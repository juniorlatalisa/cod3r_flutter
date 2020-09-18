class Data {
  int dia;
  int mes;
  int ano;

  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

  Data.com({this.dia = 1, this.mes = 1, this.ano = 1970});

  Data.ultimoDiaDoAno(this.ano) {
    // Data.ultimoDiaDoAno(int ano) {
    this.dia = 31;
    this.mes = 12;
    // this.ano = ano;
  }

  String obterFormatado() {
    return "$dia/$mes/$ano";
  }

  String toString() {
    return (dia == null || mes == null || ano == null)
        ? super.toString()
        : obterFormatado();
  }
}

main() {
  var dataAniversario = new Data(3, 10, 2020);
  print(dataAniversario.obterFormatado());

  Data dataCompra = Data();
  dataCompra.mes = 12;
  dataCompra.ano = 1999;
  print(dataCompra);

  print(Data().toString());
  print(Data(31).toString());
  print(Data(31, 12).toString());
  print(Data(31, 12, 2021).toString());

  print(Data.com(ano: 2022));

  var dataMickey = Data.com(ano: 2024, mes: 7, dia: 12);
  print("O Mickey será público em $dataMickey");

  print(Data.ultimoDiaDoAno(2023));
}
