import 'package:flutter/material.dart';

class NoBackScrollPhysics extends ScrollPhysics {
// usar extends es usar una herencia, es decir una clase de flutter ya existente
/*ScrollPhysics
Es una clase interna de Flutter que controla:
movimiento
velocidad
rebote
fricción
límites
comportamiento del scroll*/

  const NoBackScrollPhysics({
    super.parent, //Esto es un constructor para combinar todas las fisicas que programamos
  });
// @override aclara que vas a usar una clase ya existente de flutter
  @override
  NoBackScrollPhysics applyTo(
    ScrollPhysics? ancestor,
  ) {
    return NoBackScrollPhysics(
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(
    ScrollMetrics position,
    double offset,
  ) {

    /* cuando el usuario intenta volver
    offset se representa como el movimiento y coordenadas
    que hace tu dedo al deslizar, si ve que es menor a 0, es decir
    que comenzó por deslizar hacia arriba, obliga a que ese movimiento sea 0.*/

    if (offset > 0) {

      return 0;

    }

    return offset;
  }
}

/*RESUMEN MENTAL
ScrollPhysics

controla movimiento.

applyTo()

conecta tu física al sistema Flutter.

applyPhysicsToUserOffset()

decide cuánto puede moverse el scroll.*/