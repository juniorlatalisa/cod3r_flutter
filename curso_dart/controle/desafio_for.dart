/*
#
##
###
####
#####
######
Use o laço FOR, mas não pode controlar o laço usando valor númerico
*/
main() {
  print('Solução 01');
  for (var value = '#'; value != '#######'; value += '#') {
    print(value);
  }
  print('Solução 02');
  for (var value = '';;) {
    print(value += '#');
    if (value == '######') {
      break;
    }
  }
  print('Solução Curso');
  for (var valor = '#'; valor != '#######'; valor += '#') {
    print(valor);
  }
}
