import '../models/level_local.dart';

final Map<int, LocalLevel> fundamentosLevels = {
  1: LocalLevel(
    backendId: 1,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué es un sistema operativo?",
        "options": [
          "Software que administra el hardware",
          "Un tipo de procesador",
          "Un lenguaje de programación",
        ],
        "correctAnswer": "Software que administra el hardware",
      },
    ],
  ),
  2: LocalLevel(
    backendId: 2,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Cuál es un ejemplo de sistema operativo?",
        "options": [
          "Windows",
          "Google Chrome",
          "Microsoft Word",
        ],
        "correctAnswer": "Windows",
      },
    ],
  ),
  3: LocalLevel(
    backendId: 3,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué componente del S.O gestiona la memoria?",
        "options": [
          "El kernel",
          "El navegador",
          "El antivirus",
        ],
        "correctAnswer": "El kernel",
      },
    ],
  ),
};

final Map<int, LocalLevel> direccionamientoLevels = {
  1: LocalLevel(
    backendId: 1,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué organiza el modelo en capas?",
        "options": [
          "El software en niveles lógicos",
          "Los archivos del disco",
          "La velocidad del CPU",
        ],
        "correctAnswer": "El software en niveles lógicos",
      },
    ],
  ),
  2: LocalLevel(
    backendId: 2,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué ventaja tiene separar el software en capas?",
        "options": [
          "Mejor modularidad y mantenimiento",
          "Mayor consumo de memoria",
          "Menor velocidad de procesamiento",
        ],
        "correctAnswer": "Mejor modularidad y mantenimiento",
      },
    ],
  ),
  3: LocalLevel(
    backendId: 3,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Cómo se comunican las capas entre sí?",
        "options": [
          "Cada capa usa los servicios de la inferior",
          "Todas las capas funcionan independientemente",
          "Solo la capa superior tiene acceso al hardware",
        ],
        "correctAnswer": "Cada capa usa los servicios de la inferior",
      },
    ],
  ),
};

final Map<int, LocalLevel> infraestructuraLevels = {
  1: LocalLevel(
    backendId: 1,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué es una aplicación de software?",
        "options": [
          "Un programa para el usuario final",
          "Un componente del hardware",
          "Un tipo de memoria RAM",
        ],
        "correctAnswer": "Un programa para el usuario final",
      },
    ],
  ),
  2: LocalLevel(
    backendId: 2,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Cuál es un ejemplo de aplicación?",
        "options": [
          "Un navegador web",
          "El kernel del sistema",
          "Un controlador de dispositivo",
        ],
        "correctAnswer": "Un navegador web",
      },
    ],
  ),
  3: LocalLevel(
    backendId: 3,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿De qué dependen las aplicaciones para funcionar?",
        "options": [
          "De las capas inferiores del software",
          "Solo del hardware",
          "De internet exclusivamente",
        ],
        "correctAnswer": "De las capas inferiores del software",
      },
    ],
  ),
};

final Map<int, LocalLevel> administracionLevels = {
  1: LocalLevel(
    backendId: 1,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué es la programación?",
        "options": [
          "Escribir instrucciones para la computadora",
          "Configurar el hardware",
          "Instalar aplicaciones",
        ],
        "correctAnswer": "Escribir instrucciones para la computadora",
      },
    ],
  ),
  2: LocalLevel(
    backendId: 2,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Cuál es un lenguaje de programación?",
        "options": [
          "Python",
          "Windows",
          "Google Chrome",
        ],
        "correctAnswer": "Python",
      },
    ],
  ),
  3: LocalLevel(
    backendId: 3,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué transforma un compilador?",
        "options": [
          "Código fuente en código ejecutable",
          "Imágenes en texto",
          "Hardware en software",
        ],
        "correctAnswer": "Código fuente en código ejecutable",
      },
    ],
  ),
};

final Map<int, LocalLevel> seguridadLevels = {
  1: LocalLevel(
    backendId: 1,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué estudia la programación avanzada?",
        "options": [
          "Técnicas para crear software eficiente",
          "Cómo usar el ratón",
          "Configuración de redes",
        ],
        "correctAnswer": "Técnicas para crear software eficiente",
      },
    ],
  ),
  2: LocalLevel(
    backendId: 2,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué es un patrón de diseño?",
        "options": [
          "Una solución reutilizable a un problema común",
          "Un tipo de interfaz gráfica",
          "Un lenguaje de marcado",
        ],
        "correctAnswer": "Una solución reutilizable a un problema común",
      },
    ],
  ),
  3: LocalLevel(
    backendId: 3,
    contenido: [
      {"type": "video", "path": "assets/videos/test_video2.mp4"},
      {
        "type": "quiz",
        "question": "¿Qué herramienta usa la programación avanzada para despliegue?",
        "options": [
          "Docker",
          "Paint",
          "Bloc de notas",
        ],
        "correctAnswer": "Docker",
      },
    ],
  ),
};
