import '../models/level_local.dart';
// ════════════════════════════════════════════════════════════
//  HardwareData.dart
//  Cada nivel de cada componente tiene 3 (o más) pares (video, quiz).
//  Todos los quizzes tienen "correctAnswer" para que LevelScreen
//  pueda validar la respuesta correctamente. Las opciones están
//  en orden variado: la respuesta correcta NO siempre es la primera.
// ════════════════════════════════════════════════════════════

final cpuLevels = {
  // Nivel 1 — ¿Qué es el microprocesador?
  1: 
    LocalLevel(
    backendId: 1,
    contenido: [
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué hace el microprocesador?",
      "options": ["Guarda imágenes", "Procesa instrucciones", "Controla internet"],
      "correctAnswer": "Procesa instrucciones",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Con qué otro nombre se conoce al microprocesador?",
      "options": ["GPU", "RAM", "CPU"],
      "correctAnswer": "CPU",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Dónde se ubica físicamente el CPU en la placa madre?",
      "options": ["Dentro de la fuente de poder", "En el zócalo (socket) central", "En el disco duro"],
      "correctAnswer": "En el zócalo (socket) central",
    },
  ],
    ),
  // Nivel 2 — Núcleos (cores) del CPU
  2: LocalLevel(
    backendId: 2,
    contenido: [
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es un núcleo (core) dentro del CPU?",
      "options": ["Un tipo de memoria RAM", "Un puerto de conexión", "Una unidad de procesamiento independiente"],
      "correctAnswer": "Una unidad de procesamiento independiente",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué ventaja principal tiene un procesador con varios núcleos?",
      "options": ["Consume menos espacio en disco", "Puede ejecutar varias tareas en paralelo", "Aumenta la resolución de pantalla"],
      "correctAnswer": "Puede ejecutar varias tareas en paralelo",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "Un procesador 'Quad-Core' tiene:",
      "options": ["2 núcleos", "8 núcleos", "4 núcleos"],
      "correctAnswer": "4 núcleos",
    },
  ],
  ),
  // Nivel 3 — Frecuencia y velocidad de reloj
  3: [
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué mide la frecuencia de reloj de un CPU?",
      "options": ["La temperatura del procesador", "Cuántos ciclos por segundo puede procesar", "El tamaño físico del chip"],
      "correctAnswer": "Cuántos ciclos por segundo puede procesar",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿En qué unidad se mide la velocidad de reloj?",
      "options": ["GB (gigabytes)", "Watts", "GHz (gigahertz)"],
      "correctAnswer": "GHz (gigahertz)",
    },
    {"type": "video", "path": "assets/videos/test_video2.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es el 'overclocking'?",
      "options": ["Reducir el consumo de energía", "Instalar más memoria RAM", "Aumentar la velocidad de reloj por encima del valor de fábrica"],
      "correctAnswer": "Aumentar la velocidad de reloj por encima del valor de fábrica",
    },
  ],

  // Nivel 4 — Caché del procesador
  4: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué sirve la memoria caché del CPU?",
      "options": ["Enfriar el procesador", "Guardar datos de uso frecuente para acceder más rápido", "Almacenar el sistema operativo completo"],
      "correctAnswer": "Guardar datos de uso frecuente para acceder más rápido",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál caché suele ser la más rápida pero más pequeña?",
      "options": ["Caché L3", "Disco duro", "Caché L1"],
      "correctAnswer": "Caché L1",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Por qué la caché es más rápida que la RAM?",
      "options": ["Porque usa menos electricidad", "Porque es más grande", "Está integrada dentro del propio chip del CPU"],
      "correctAnswer": "Está integrada dentro del propio chip del CPU",
    },
  ],

  // Nivel 5 — Arquitecturas (32 / 64 bits)
  5: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué indica la arquitectura de 64 bits de un procesador?",
      "options": ["La cantidad de núcleos", "La velocidad del ventilador", "La cantidad de datos que puede procesar por ciclo"],
      "correctAnswer": "La cantidad de datos que puede procesar por ciclo",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Comparado con 32 bits, un CPU de 64 bits puede:",
      "options": ["Consumir menos espacio en disco", "Manejar mucha más memoria RAM", "Reproducir video en mayor resolución"],
      "correctAnswer": "Manejar mucha más memoria RAM",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Hoy en día, ¿qué arquitectura es la estándar en computadoras nuevas?",
      "options": ["32 bits", "8 bits", "64 bits"],
      "correctAnswer": "64 bits",
    },
  ],

  // Nivel 6 — Hilos (threads) y multihilo
  6: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es un 'hilo' (thread) en un procesador?",
      "options": ["Un cable físico dentro del chip", "Una secuencia de instrucciones que el CPU puede ejecutar", "Un tipo de memoria externa"],
      "correctAnswer": "Una secuencia de instrucciones que el CPU puede ejecutar",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué permite la tecnología de 'multihilo' (ej. Hyper-Threading)?",
      "options": ["Que el CPU use menos energía", "Que la pantalla se vea más nítida", "Que un núcleo procese más de un hilo a la vez"],
      "correctAnswer": "Que un núcleo procese más de un hilo a la vez",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Un CPU 'Quad-Core' con Hyper-Threading puede manejar:",
      "options": ["4 hilos", "2 hilos", "8 hilos"],
      "correctAnswer": "8 hilos",
    },
  ],

  // Nivel 7 — Fabricantes y modelos
  7: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuáles son los dos fabricantes principales de CPUs para PC?",
      "options": ["NVIDIA y Samsung", "Intel y AMD", "Sony y LG"],
      "correctAnswer": "Intel y AMD",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál es una línea de procesadores de Intel orientada a consumo general?",
      "options": ["Radeon", "GeForce", "Core i5 / i7"],
      "correctAnswer": "Core i5 / i7",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál es una línea de procesadores de AMD?",
      "options": ["Snapdragon", "Ryzen", "Xeon Phi"],
      "correctAnswer": "Ryzen",
    },
  ],
};

final gpuLevels = {
  // Nivel 1 — ¿Qué es una GPU?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué hace principalmente una GPU?",
      "options": ["Guarda archivos permanentemente", "Procesa gráficos e imágenes", "Controla la conexión a internet"],
      "correctAnswer": "Procesa gráficos e imágenes",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa la sigla GPU?",
      "options": ["Unidad de memoria principal", "Sistema de almacenamiento", "Unidad de procesamiento gráfico"],
      "correctAnswer": "Unidad de procesamiento gráfico",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué actividad se beneficia más de una buena GPU?",
      "options": ["Escribir documentos de texto", "Escuchar música", "Jugar videojuegos con gráficos exigentes"],
      "correctAnswer": "Jugar videojuegos con gráficos exigentes",
    },
  ],

  // Nivel 2 — VRAM y memoria de video
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué tipo de memoria usa principalmente una tarjeta gráfica?",
      "options": ["ROM", "Memoria USB", "VRAM"],
      "correctAnswer": "VRAM",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué se usa la VRAM en una GPU?",
      "options": ["Guardar el sistema operativo", "Guardar texturas e imágenes mientras se renderizan", "Enfriar la tarjeta gráfica"],
      "correctAnswer": "Guardar texturas e imágenes mientras se renderizan",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Si un juego exige gráficos en 4K, ¿qué necesita la GPU?",
      "options": ["Menor cantidad de VRAM", "No necesita VRAM", "Mayor cantidad de VRAM"],
      "correctAnswer": "Mayor cantidad de VRAM",
    },
  ],

  // Nivel 3 — Renderizado y gráficos 3D
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué componente mejora especialmente el rendimiento en videojuegos 3D?",
      "options": ["Fuente de poder", "Gabinete", "GPU"],
      "correctAnswer": "GPU",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es 'renderizar' una imagen?",
      "options": ["Comprimir un archivo de video", "Generar la imagen final a partir de datos 3D", "Conectar la PC a internet"],
      "correctAnswer": "Generar la imagen final a partir de datos 3D",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué tecnología permite iluminación más realista en juegos modernos?",
      "options": ["Bluetooth", "USB 3.0", "Ray Tracing"],
      "correctAnswer": "Ray Tracing",
    },
  ],

  // Nivel 4 — GPU integrada vs dedicada
  4: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué tipo de tareas realiza una GPU moderna?",
      "options": ["Impresión de documentos", "Refrigeración del equipo", "Renderizado y procesamiento de gráficos"],
      "correctAnswer": "Renderizado y procesamiento de gráficos",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué característica tiene una GPU integrada?",
      "options": ["Se conecta por un cable HDMI aparte", "Solo funciona con discos SSD", "Viene incorporada en el mismo chip del CPU"],
      "correctAnswer": "Viene incorporada en el mismo chip del CPU",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué ventaja tiene una GPU dedicada frente a una integrada?",
      "options": ["Consume menos espacio en la placa", "No necesita energía eléctrica", "Mayor rendimiento gráfico gracias a su propia VRAM"],
      "correctAnswer": "Mayor rendimiento gráfico gracias a su propia VRAM",
    },
  ],

  // Nivel 5 — Fabricantes y modelos
  5: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuáles son los dos fabricantes principales de GPUs dedicadas?",
      "options": ["Intel y Samsung", "Sony y LG", "NVIDIA y AMD"],
      "correctAnswer": "NVIDIA y AMD",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál es una línea de tarjetas gráficas de NVIDIA?",
      "options": ["Ryzen", "Core i7", "GeForce RTX"],
      "correctAnswer": "GeForce RTX",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál es una línea de tarjetas gráficas de AMD?",
      "options": ["Snapdragon", "GeForce", "Radeon"],
      "correctAnswer": "Radeon",
    },
  ],
};

final ssdhddLevels = {
  // Nivel 1 — Conceptos básicos: HDD vs SSD
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué dispositivo almacena datos de manera permanente?",
      "options": ["Procesador", "Disco duro", "Tarjeta gráfica"],
      "correctAnswer": "Disco duro",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa HDD?",
      "options": ["Memoria RAM", "Unidad de video", "Disco duro tradicional (con partes mecánicas)"],
      "correctAnswer": "Disco duro tradicional (con partes mecánicas)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa SSD?",
      "options": ["Sistema de seguridad digital", "Unidad de estado sólido, sin partes móviles", "Servidor de datos secundario"],
      "correctAnswer": "Unidad de estado sólido, sin partes móviles",
    },
  ],

  // Nivel 2 — Velocidad y rendimiento
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué ventaja tiene un SSD frente a un HDD?",
      "options": ["Más ruido al funcionar", "Mayor tamaño físico", "Mayor velocidad de lectura y escritura"],
      "correctAnswer": "Mayor velocidad de lectura y escritura",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Por qué un HDD es más lento que un SSD?",
      "options": ["Usa más electricidad", "Tiene menos capacidad de almacenamiento", "Usa discos giratorios y un brazo mecánico para leer datos"],
      "correctAnswer": "Usa discos giratorios y un brazo mecánico para leer datos",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué efecto tiene un SSD en el tiempo de arranque del sistema operativo?",
      "options": ["Lo aumenta", "No tiene ningún efecto", "Lo reduce notablemente"],
      "correctAnswer": "Lo reduce notablemente",
    },
  ],

  // Nivel 3 — Tipos de conexión (SATA, NVMe, M.2)
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué componente suele usarse para instalar el sistema operativo por su rapidez?",
      "options": ["GPU", "Fuente de poder", "SSD"],
      "correctAnswer": "SSD",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué interfaz de conexión es más rápida para un SSD?",
      "options": ["SATA", "USB 2.0", "NVMe (por M.2)"],
      "correctAnswer": "NVMe (por M.2)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es M.2?",
      "options": ["Un tipo de procesador", "Un cable de video", "Un formato físico compacto para conectar SSDs a la placa madre"],
      "correctAnswer": "Un formato físico compacto para conectar SSDs a la placa madre",
    },
  ],
};

// ════════════════════════════════════════════════════════════
//  COMPONENTES NUEVOS
// ════════════════════════════════════════════════════════════

final psuLevels = {
  // Nivel 1 — ¿Qué es la fuente de poder?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué función cumple la fuente de alimentación (PSU)?",
      "options": ["Enfría el procesador", "Convierte la corriente eléctrica para alimentar los componentes", "Guarda archivos"],
      "correctAnswer": "Convierte la corriente eléctrica para alimentar los componentes",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué tipo de corriente entrega la PSU a los componentes internos?",
      "options": ["Corriente alterna (AC)", "Corriente continua (DC)", "Ninguna, solo la distribuye"],
      "correctAnswer": "Corriente continua (DC)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué pasa si la fuente de poder es insuficiente para los componentes instalados?",
      "options": ["No pasa nada", "La PC puede apagarse o no encender bien", "La PC anda más rápido"],
      "correctAnswer": "La PC puede apagarse o no encender bien",
    },
  ],

  // Nivel 2 — Certificación y eficiencia (80 Plus)
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué indica la certificación '80 Plus' en una fuente?",
      "options": ["Su color", "Su nivel de eficiencia energética", "Su tamaño físico"],
      "correctAnswer": "Su nivel de eficiencia energética",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál de estas es una categoría de certificación 80 Plus (de menor a mayor eficiencia)?",
      "options": ["Rojo, Verde, Azul", "Bronze, Gold, Platinum", "Nivel 1, Nivel 2, Nivel 3"],
      "correctAnswer": "Bronze, Gold, Platinum",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿En qué unidad se mide la potencia máxima que entrega una fuente?",
      "options": ["GHz", "Vatios (W)", "GB"],
      "correctAnswer": "Vatios (W)",
    },
  ],

  // Nivel 3 — Conectores y modularidad
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué conector alimenta principalmente a la placa madre?",
      "options": ["El conector HDMI", "El conector ATX de 24 pines", "El conector USB"],
      "correctAnswer": "El conector ATX de 24 pines",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa que una fuente sea 'modular'?",
      "options": ["Que no necesita cables", "Que sus cables se pueden conectar y desconectar según necesites", "Que viene con módulos de RAM incluidos"],
      "correctAnswer": "Que sus cables se pueden conectar y desconectar según necesites",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué conector alimenta especialmente a una tarjeta gráfica exigente?",
      "options": ["El conector SATA de datos", "El conector PCIe de 6/8 pines", "El conector de audio"],
      "correctAnswer": "El conector PCIe de 6/8 pines",
    },
  ],
};

final hddLevels = {
  // Nivel 1 — Partes internas del disco duro mecánico
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cómo se llaman los discos giratorios donde se graban los datos en un HDD?",
      "options": ["Chips", "Platos", "Núcleos"],
      "correctAnswer": "Platos",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué parte del HDD lee y escribe los datos sobre los platos?",
      "options": ["El ventilador", "El cabezal de lectura/escritura", "El zócalo"],
      "correctAnswer": "El cabezal de lectura/escritura",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Por qué un HDD hace ruido y vibra un poco al funcionar?",
      "options": ["Usa electricidad de más", "Tiene partes mecánicas en movimiento", "Se está por romper siempre"],
      "correctAnswer": "Tiene partes mecánicas en movimiento",
    },
  ],

  // Nivel 2 — Velocidad de rotación (RPM)
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué mide las RPM de un disco duro?",
      "options": ["La cantidad de datos guardados", "Las vueltas por minuto que da el plato", "La temperatura del disco"],
      "correctAnswer": "Las vueltas por minuto que da el plato",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué velocidad de rotación es común en discos para PC de escritorio?",
      "options": ["700 RPM", "7200 RPM", "72000 RPM"],
      "correctAnswer": "7200 RPM",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "A mayor cantidad de RPM, generalmente el disco es:",
      "options": ["Más lento", "Más rápido", "Más liviano"],
      "correctAnswer": "Más rápido",
    },
  ],

  // Nivel 3 — Capacidad y uso típico
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué se sigue usando un HDD hoy en día, a pesar de ser más lento que un SSD?",
      "options": ["Para procesar gráficos", "Para almacenar grandes volúmenes de datos a bajo costo", "Para conectar la PC a internet"],
      "correctAnswer": "Para almacenar grandes volúmenes de datos a bajo costo",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué interfaz suele usar un HDD para conectarse a la placa madre?",
      "options": ["HDMI", "SATA", "PCIe x16"],
      "correctAnswer": "SATA",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué puede pasar si un HDD recibe un golpe fuerte mientras funciona?",
      "options": ["Nada, es resistente a golpes", "Puede dañarse porque tiene partes mecánicas en movimiento", "Se apaga la PC entera"],
      "correctAnswer": "Puede dañarse porque tiene partes mecánicas en movimiento",
    },
  ],
};

final ramLevels = {
  // Nivel 1 — ¿Qué es la memoria RAM?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué se usa la memoria RAM?",
      "options": ["Guardar archivos permanentemente", "Almacenar temporalmente los datos que la PC está usando en ese momento", "Procesar gráficos 3D"],
      "correctAnswer": "Almacenar temporalmente los datos que la PC está usando en ese momento",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué pasa con los datos en la RAM cuando apagás la PC?",
      "options": ["Se guardan para siempre", "Se pierden, porque es memoria volátil", "Se mandan al disco duro automáticamente"],
      "correctAnswer": "Se pierden, porque es memoria volátil",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué efecto tiene tener poca RAM al usar muchos programas a la vez?",
      "options": ["La PC funciona más rápido", "La PC puede volverse lenta o trabarse", "No tiene ningún efecto"],
      "correctAnswer": "La PC puede volverse lenta o trabarse",
    },
  ],

  // Nivel 2 — Tipos (DDR3 / DDR4 / DDR5)
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa la sigla DDR en los módulos de RAM?",
      "options": ["Direct Data Read", "Double Data Rate (doble tasa de datos)", "Digital Disk Ram"],
      "correctAnswer": "Double Data Rate (doble tasa de datos)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuál de estas es una generación más reciente de memoria RAM?",
      "options": ["DDR3", "DDR5", "DDR2"],
      "correctAnswer": "DDR5",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Podés combinar un módulo DDR4 con un módulo DDR3 en la misma placa?",
      "options": ["Sí, sin problema", "No, no son compatibles entre sí", "Solo si tienen la misma capacidad"],
      "correctAnswer": "No, no son compatibles entre sí",
    },
  ],

  // Nivel 3 — Capacidad y velocidad (MHz)
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿En qué unidad se mide la capacidad de un módulo de RAM?",
      "options": ["GHz", "GB (gigabytes)", "Vatios"],
      "correctAnswer": "GB (gigabytes)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué indica la velocidad en MHz de una RAM?",
      "options": ["Su temperatura máxima", "Qué tan rápido transfiere datos", "Su tamaño físico"],
      "correctAnswer": "Qué tan rápido transfiere datos",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Para tareas exigentes (edición de video, juegos actuales), ¿qué suele convenir?",
      "options": ["Tener menos capacidad de RAM", "Tener más capacidad de RAM disponible", "La capacidad de RAM no influye"],
      "correctAnswer": "Tener más capacidad de RAM disponible",
    },
  ],

  // Nivel 4 — Dual channel
  4: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es el 'dual channel' en memoria RAM?",
      "options": ["Un tipo de disco duro", "Usar dos módulos de RAM juntos para mejorar el ancho de banda", "Una conexión de red doble"],
      "correctAnswer": "Usar dos módulos de RAM juntos para mejorar el ancho de banda",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Para aprovechar el dual channel, ¿qué conviene hacer al comprar RAM?",
      "options": ["Comprar un solo módulo grande", "Comprar dos módulos iguales en un kit", "Da igual cómo se compre"],
      "correctAnswer": "Comprar dos módulos iguales en un kit",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Dónde se insertan físicamente los módulos de RAM?",
      "options": ["En el zócalo del CPU", "En los slots DIMM de la placa madre", "En la fuente de poder"],
      "correctAnswer": "En los slots DIMM de la placa madre",
    },
  ],
};

final coolerLevels = {
  // Nivel 1 — ¿Qué es el cooler/disipador?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué sirve el cooler del CPU?",
      "options": ["Aumentar la velocidad del procesador", "Disipar el calor que genera el procesador", "Guardar archivos temporales"],
      "correctAnswer": "Disipar el calor que genera el procesador",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué pasa si el CPU se sobrecalienta?",
      "options": ["Nada importante", "Puede bajar su rendimiento o apagarse para protegerse", "Aumenta su velocidad automáticamente"],
      "correctAnswer": "Puede bajar su rendimiento o apagarse para protegerse",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué parte del cooler mueve el aire para enfriar?",
      "options": ["El disipador metálico", "El ventilador (fan)", "El zócalo"],
      "correctAnswer": "El ventilador (fan)",
    },
  ],

  // Nivel 2 — Aire vs líquido
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Cuáles son los dos tipos principales de refrigeración para CPU?",
      "options": ["Refrigeración por gas y por sólido", "Refrigeración por aire y por líquido", "Refrigeración activa y pasiva solamente"],
      "correctAnswer": "Refrigeración por aire y por líquido",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué ventaja suele tener la refrigeración líquida frente a la de aire en CPUs exigentes?",
      "options": ["Es más barata siempre", "Suele enfriar mejor bajo cargas altas", "No necesita mantenimiento nunca"],
      "correctAnswer": "Suele enfriar mejor bajo cargas altas",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es un 'AIO' (All In One) en refrigeración?",
      "options": ["Un disipador de aire simple", "Un kit de refrigeración líquida cerrado y listo para instalar", "Un tipo de ventilador de gabinete"],
      "correctAnswer": "Un kit de refrigeración líquida cerrado y listo para instalar",
    },
  ],

  // Nivel 3 — Pasta térmica y TDP
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué se usa la pasta térmica entre el CPU y el cooler?",
      "options": ["Para pegar el cooler de forma permanente", "Para mejorar la transferencia de calor entre ambas superficies", "Para aislar el CPU eléctricamente"],
      "correctAnswer": "Para mejorar la transferencia de calor entre ambas superficies",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué indica el TDP (Thermal Design Power) de un procesador?",
      "options": ["Su velocidad máxima en GHz", "Aproximadamente cuánto calor hay que disipar", "Su precio de fábrica"],
      "correctAnswer": "Aproximadamente cuánto calor hay que disipar",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "Si un cooler tiene un TDP soportado menor al del CPU, ¿qué puede pasar?",
      "options": ["No hay ningún problema", "El CPU puede sobrecalentarse o limitar su rendimiento", "El cooler se rompe al instante"],
      "correctAnswer": "El CPU puede sobrecalentarse o limitar su rendimiento",
    },
  ],
};

final motherboardLevels = {
  // Nivel 1 — ¿Qué es la placa madre?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué función cumple la placa madre (motherboard)?",
      "options": ["Guarda archivos permanentemente", "Conecta y comunica a todos los componentes de la PC", "Genera las imágenes en pantalla"],
      "correctAnswer": "Conecta y comunica a todos los componentes de la PC",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué componente se instala directamente en el zócalo (socket) de la placa madre?",
      "options": ["El disco duro", "El CPU", "La fuente de poder"],
      "correctAnswer": "El CPU",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Por qué es importante elegir una placa madre compatible con el CPU?",
      "options": ["No es importante, todas son iguales", "El zócalo y el chipset deben coincidir con el procesador", "Solo afecta el color de la placa"],
      "correctAnswer": "El zócalo y el chipset deben coincidir con el procesador",
    },
  ],

  // Nivel 2 — Chipset
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es el chipset de una placa madre?",
      "options": ["Un tipo de memoria RAM", "Un conjunto de chips que gestiona la comunicación entre componentes", "El ventilador principal de la placa"],
      "correctAnswer": "Un conjunto de chips que gestiona la comunicación entre componentes",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué puede determinar el chipset de una placa madre?",
      "options": ["El color del gabinete", "Qué funciones y expansiones soporta la placa", "La temperatura ambiente"],
      "correctAnswer": "Qué funciones y expansiones soporta la placa",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Los chipsets de gama alta suelen permitir, entre otras cosas?",
      "options": ["Menor capacidad de almacenamiento siempre", "Overclocking y más opciones de expansión", "Menos puertos USB obligatoriamente"],
      "correctAnswer": "Overclocking y más opciones de expansión",
    },
  ],

  // Nivel 3 — Slots de expansión (PCIe)
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué se usa un slot PCIe x16 en la placa madre?",
      "options": ["Para conectar la fuente de poder", "Para instalar la tarjeta gráfica", "Para conectar el teclado"],
      "correctAnswer": "Para instalar la tarjeta gráfica",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué tipo de slot se usa comúnmente para instalar un SSD M.2?",
      "options": ["Slot PCIe x16", "Slot M.2", "Zócalo de CPU"],
      "correctAnswer": "Slot M.2",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué significa que una placa tenga varios slots de expansión?",
      "options": ["Que consume más energía obligatoriamente", "Que podés agregar más componentes o tarjetas", "Que es más lenta"],
      "correctAnswer": "Que podés agregar más componentes o tarjetas",
    },
  ],

  // Nivel 4 — BIOS / UEFI
  4: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es la BIOS/UEFI de una placa madre?",
      "options": ["Un antivirus integrado", "Un programa básico que arranca la PC y configura el hardware", "Un tipo de memoria RAM"],
      "correctAnswer": "Un programa básico que arranca la PC y configura el hardware",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿En qué se diferencia UEFI de la BIOS tradicional?",
      "options": ["UEFI es más vieja que la BIOS", "UEFI es más moderna y con interfaz más amigable", "No hay ninguna diferencia real"],
      "correctAnswer": "UEFI es más moderna y con interfaz más amigable",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Para qué podés entrar a la BIOS/UEFI al encender la PC?",
      "options": ["Para editar documentos de texto", "Para configurar el orden de arranque y otros ajustes de hardware", "Para instalar videojuegos"],
      "correctAnswer": "Para configurar el orden de arranque y otros ajustes de hardware",
    },
  ],
};

final m2Levels = {
  // Nivel 1 — ¿Qué es la ranura M.2?
  1: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es una ranura M.2 en la placa madre?",
      "options": ["Un puerto para conectar el mouse", "Un conector compacto para instalar SSDs pequeños directamente en la placa", "Un slot exclusivo para RAM"],
      "correctAnswer": "Un conector compacto para instalar SSDs pequeños directamente en la placa",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué ventaja tiene un SSD M.2 en cuanto a espacio físico?",
      "options": ["Ocupa el doble de espacio", "Es mucho más pequeño que un disco tradicional de 3.5 pulgadas", "No cambia nada respecto a un HDD"],
      "correctAnswer": "Es mucho más pequeño que un disco tradicional de 3.5 pulgadas",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Un SSD M.2 necesita cables SATA de datos para conectarse?",
      "options": ["Sí, siempre necesita cable SATA", "No, se conecta directo a la ranura de la placa", "Sí, necesita dos cables"],
      "correctAnswer": "No, se conecta directo a la ranura de la placa",
    },
  ],

  // Nivel 2 — Tipos de conexión (SATA M.2 vs NVMe)
  2: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué protocolo aprovecha al máximo la velocidad de un SSD M.2 moderno?",
      "options": ["USB 2.0", "NVMe", "PS/2"],
      "correctAnswer": "NVMe",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Todos los SSD M.2 usan el protocolo NVMe?",
      "options": ["Sí, todos son NVMe obligatoriamente", "No, algunos usan el protocolo SATA aunque tengan formato M.2", "No, todos usan USB"],
      "correctAnswer": "No, algunos usan el protocolo SATA aunque tengan formato M.2",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "En términos generales, ¿qué opción suele ser más rápida?",
      "options": ["Un M.2 SATA", "Un M.2 NVMe", "Ambos son igual de rápidos siempre"],
      "correctAnswer": "Un M.2 NVMe",
    },
  ],

  // Nivel 3 — Longitudes y keys (formato físico)
  3: [
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué indica un número como '2280' impreso en un SSD M.2?",
      "options": ["Su capacidad en GB", "Su ancho y largo físico en milímetros (22mm x 80mm)", "Su año de fabricación"],
      "correctAnswer": "Su ancho y largo físico en milímetros (22mm x 80mm)",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Por qué importa la longitud física del M.2 al comprarlo?",
      "options": ["No importa, todos entran en cualquier placa", "Tiene que coincidir con lo que soporta la ranura de tu placa madre", "Solo afecta el color"],
      "correctAnswer": "Tiene que coincidir con lo que soporta la ranura de tu placa madre",
    },
    {"type": "video", "path": "assets/videos/test.mp4"},
    {
      "type": "quiz",
      "question": "¿Qué es el 'key' (muesca) en el conector de un M.2?",
      "options": ["Una contraseña de seguridad", "Una marca física que define qué tipo de conexión soporta el módulo", "Un accesorio decorativo"],
      "correctAnswer": "Una marca física que define qué tipo de conexión soporta el módulo",
    },
  ],
};

// Nombres visibles de cada componente, usados por HardwareScreen.dart
// para mostrar el nombre del componente en pantalla a partir de su "route".
final Map<String, String> hardwareComponentNames = {
  "psu": "Fuente de Alimentación",
  "ssd": "Disco Duro / SSD",
  "hdd": "Disco Duro (HDD)",
  "ram": "Memoria RAM",
  "cpu": "Microprocesador (CPU)",
  "cooler": "Cooler / Ventilador CPU",
  "gpu": "Tarjeta Gráfica (GPU)",
  "motherboard": "Placa Madre",
  "m2": "Almacenamiento M.2",
};

// Relaciona el nombre del componente del mapa con el conjunto de niveles correspondiente.
final hardwareComponents = {
  "cpu": cpuLevels,
  "gpu": gpuLevels,
  "ssd": ssdhddLevels,
  "psu": psuLevels,
  "hdd": hddLevels,
  "ram": ramLevels,
  "cooler": coolerLevels,
  "motherboard": motherboardLevels,
  "m2": m2Levels,
};