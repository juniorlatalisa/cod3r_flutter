class Data {
  int dia;
  int mes;
  int ano;

  // Data(int dia, int mes, int ano) {
  //   this.dia = dia;
  //   this.mes = mes;
  //   this.ano = ano;
  // }

  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

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
  // dataAniversario.dia = 3;
  // dataAniversario.mes = 10;
  // dataAniversario.ano = 2020;
  // print("${dataAniversario.dia}/${dataAniversario.mes}/${dataAniversario.ano}");
  print(dataAniversario.obterFormatado());

  // Data dataCompra = Data(1, 1, 1970);
  Data dataCompra = Data();
  // dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 1999;
  // print("${dataCompra.dia}/${dataCompra.mes}/${dataCompra.ano}");
  print(dataCompra);

  print(Data().toString());
  print(Data(31).toString());
  print(Data(31, 12).toString());
  print(Data(31, 12, 2021).toString());
}
