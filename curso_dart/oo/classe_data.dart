class Data {
  int dia;
  int mes;
  int ano;

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
  var dataAniversario = new Data();
  dataAniversario.dia = 3;
  dataAniversario.mes = 10;
  dataAniversario.ano = 2020;
  // print("${dataAniversario.dia}/${dataAniversario.mes}/${dataAniversario.ano}");
  print(dataAniversario.obterFormatado());

  Data dataCompra = Data();
  dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;
  // print("${dataCompra.dia}/${dataCompra.mes}/${dataCompra.ano}");
  print(dataCompra);

  print(Data().toString());
}
