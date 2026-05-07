import 'dart:io';
    int find_max(List<int> Nums){
        int maxNumber = 0;
        for (var i in Nums) {
            if(Nums[i] > maxNumber){
                maxNumber = i;
            }
        }
        return maxNumber;
        
    }
/*void saludar(String name) { // Función que recibe un nombre y lo saluda
    print("Hola, $name");
}
int age(int age) {
    if (age >= 18) {
        print("Eres mayor de edad");
        return age; // Devuelve la edad aunque no se use, para cumplir con el tipo de retorno
    } else {
        print("Eres menor de edad");
        return age; // Devuelve la edad aunque no se use, para cumplir con el tipo de retorno
    }
}

void main() {
    print('Hello, World!');
    String nombre = "norpo";
    print(nombre);
    int edad = int.parse("15"); // Convierte la cadena "15" a un entero
    print(edad);
    saludar(nombre);
    age(edad);
}*/
/*void main() {
    double pi = 3.1419;
    print(pi);
    if (pi == 3.1415) {
        print("Pi es igual a 3.1415");
    } else {
        print("Pi no es igual a 3.1415");
    }
}*/
/*void main() {
    for (int i=1; i<=10; i++) {
        print(i);
        if (i == 5) {
            print("Llegamos a la mitad");
        }
        if (i == 4) {
            print("el culo te parto");
        }
    }
    }*/
/*
int dividir(int a, int b) {
  if (b == 0) {
    print("No se puede dividir por cero");
    return 0; // Devuelve 0 para evitar la división por cero
  } else {
    return a ~/ b; // Utiliza la división entera para devolver un resultado entero
  }
}

int multiplicar(int a, int b) {
  return a * b;
}

void main() {
  int resultado = multiplicar(4, 5);
  print(resultado);
  int resultado2 = dividir(10, 2);
  print(resultado2);
  int resultado3 = dividir(10, 0);
  print(resultado3);

}*/
/*
void main() {
    List<String> names = ["tiza", "pizarra", "borrador"];
    print(names[0]); // Imprime "tiza"
    print(names[1]); // Imprime "pizarra"   
    for (int i = 0; i < names.length; i++) {
        print(names[i]);}
    for (var name in names) {
        print(name);}
    
    List<int> age = [15, 20, 25];
    for (int i = 0; i < age.length; i++) {
        if (age[i] >= 18) {
            print("Eres mayor de edad");
        } else {
            print("Eres menor de edad");
        }
        print(age[i]);}
    age.add(30); // Agrega un nuevo elemento a la lista
    print(age); // Imprime la lista actualizada
    age.add(int.parse("30")); // Agrega un nuevo elemento de tipo String a la lista
    print(age); // Imprime la lista actualizada con el nuevo elemento de tipo String    
    age.removeAt(0); // Elimina el elemento en el índice 0 de la lista
    print(age); // Imprime la lista actualizada con el nuevo elemento
}*/

void main() {
    print("Aprendiendo Dart, el lenguaje de programación de Google");
    // Nivel 1: Crear lista de números y devolverlos. 
    List<int> numbers = [5, 6, 7, 2, 1];
    print(numbers);
    // Nivel 2: Pedir 5 números al usuario, guardarlos en una lista y devolver el mayor número.
    List<int> userNumbers = [];
    int maxNumber = 0;
    print("Ahora ingresa 5 números:");
    for (var i = 0; i < 5; i++){
        int number = int.parse(stdin.readLineSync()!);
        userNumbers.add(number);
    }
    for (var i = 0; i < userNumbers.length; i++){
        if(userNumbers[i] > maxNumber){
            maxNumber = userNumbers[i];
        }
    }
    print("El mayor número es: $maxNumber");
    print("llega hasta aqui");
    print("El numero mas grande es: ${find_max(userNumbers)}");
    
}
//hola tiza se la come

    // Nivel 3: Del nivel anterior, crear una función que diga cuál es el número más grande de la lista.