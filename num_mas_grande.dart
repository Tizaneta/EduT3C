import 'dart:io';
void main () {
  print("Ingrese 5 numeros:");
  List<int> numeros = [];
  int i = 0;
  for (i == 0; i < 5; i++){
    int numero = int.parse(stdin.readLineSync()!);
    numeros.add(numero);}
  print("Los numeros ingresados son: $numeros");
  print("Pero el número más grande es: ");
  int maximo = numeros[0];
  for (var i in numeros) {
    if (i > maximo) {
      maximo = i;
    }
  }
  print(maximo);
  
  print("Y el número más pequeño es: ");


}
//tiza se la come /egg 