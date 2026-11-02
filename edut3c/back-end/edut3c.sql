-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-10-2026 a las 21:43:25
-- Versión del servidor: 8.0.17
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `edut3c`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `achievements`
--
-- Creación: 05-07-2026 a las 20:08:18
--

CREATE TABLE `achievements` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `xp_required` int(11) NOT NULL,
  `achievement_icon` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `achievements`
--

INSERT INTO `achievements` (`id`, `name`, `xp_required`, `achievement_icon`) VALUES
(1, 'Inicios', 100, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alembic_version`
--
-- Creación: 08-06-2026 a las 14:56:54
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('76366aa65527');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `friends`
--
-- Creación: 02-06-2026 a las 16:01:07
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--
-- Creación: 14-06-2026 a las 17:27:18
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `is_stackable` tinyint(1) DEFAULT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `item`
--

INSERT INTO `item` (`id`, `name`, `price`, `description`, `icon`, `is_stackable`, `type`) VALUES
(1, 'Marco Dorado', 100, 'Marco de perfil dorado', '', 0, 'frame'),
(2, 'Monstec x2', 500, 'Duplica la experiencia', 'assets/images/monstec2.png', 1, 'boost'),
(3, 'Monstec x3', 700, 'Multiplica por 3 la xp', 'assets/images/monstec3.png', 1, 'boost'),
(4, 'Monstec x1,5', 350, 'Multiplica tu XP por 1,5', 'assets/images/monstec.png', 1, 'boost');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `level`
--
-- Creación: 02-06-2026 a las 16:01:07
--

CREATE TABLE `level` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `xp_reward` int(11) NOT NULL,
  `bits_reward` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `level`
--

INSERT INTO `level` (`id`, `name`, `xp_reward`, `bits_reward`) VALUES
(1, 'CPU Basico', 100, 50),
(2, 'CPU Avanzado', 150, 75),
(3, 'RAM Basica', 100, 50),
(4, 'RAM Avanzada', 150, 75),
(5, 'Python Basico', 200, 100),
(6, 'JavaScript Basico', 200, 100),
(7, 'Linux Basico', 200, 100),
(8, 'Topologias Basicas', 250, 125),
(9, 'Protocolos Basicos', 250, 125);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ranks`
--
-- Creación: 02-06-2026 a las 16:01:07
--

CREATE TABLE `ranks` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `xp_required` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--
-- Creación: 13-07-2026 a las 19:20:50
-- Última actualización: 30-10-2026 a las 17:56:45
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `xp` int(11) DEFAULT NULL,
  `bits` int(11) DEFAULT NULL,
  `rank_id` int(11) DEFAULT NULL,
  `equipped_frame_id` int(11) DEFAULT NULL,
  `equipped_avatar_id` int(11) DEFAULT NULL,
  `equipped_title_id` int(11) DEFAULT NULL,
  `xp_multiplier` float DEFAULT NULL,
  `xp_boost_until` datetime DEFAULT NULL,
  `level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `xp`, `bits`, `rank_id`, `equipped_frame_id`, `equipped_avatar_id`, `equipped_title_id`, `xp_multiplier`, `xp_boost_until`, `level`) VALUES
(1, 'Tiza', '1234', 'tiza@gmail.com', 2020, 969950, NULL, 1, NULL, NULL, 1, '2026-06-18 11:56:51', 6),
(2, 'Facundo', 'ñandu', 'facu@gmail.com', 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(3, 'elarmadordepc', 'ñanduuu', 'thepussydistroyer@gmail.com', 330, 50, NULL, NULL, NULL, NULL, 1, NULL, 3),
(5, 'agachateytelodigo', 'concreto', 'rodrigo@gmail.com', 167, 50, NULL, NULL, NULL, NULL, 1, NULL, 2),
(6, 'anashi', '1234', 'tiza@test.com', 100, 50, NULL, NULL, NULL, NULL, 1, NULL, 2),
(7, 'TestUser', '1234', 'test@test.com', 1, 50, NULL, NULL, NULL, NULL, 1, NULL, 1),
(8, 'pitulin', 'porno6767', 'tizianoagustinrojasjunior@gmail.com', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(9, 'pitulin67', 'porno6767', 'santigay@gmail.com', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(10, 'facugay', '67676767', 'santiregay67@gmail.com', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(11, 'si', 'si', 'si', 500, 190, NULL, NULL, NULL, NULL, 1, NULL, 3),
(12, 'lareputamadre', 'contraseñadevrg', 'meestadandoerror', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(13, 'culiao', 'scorpion', 'kunglao', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(14, 'culiao67', 'scorpion', 'kunglao67', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(15, 'test67', '88888888', 'test67', 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 1),
(16, 'santinocrash', '12042026', 'santinojoel07@Gmail.com', 500, 250, NULL, NULL, NULL, NULL, 1, NULL, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_achievement`
--
-- Creación: 05-07-2026 a las 20:08:18
--

CREATE TABLE `user_achievement` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `obtained_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user_achievement`
--

INSERT INTO `user_achievement` (`id`, `user_id`, `achievement_id`, `obtained_at`) VALUES
(1, 3, 1, '2026-07-13 21:14:20'),
(2, 5, 1, '2026-07-13 21:14:44'),
(3, 6, 1, '2026-07-13 21:14:51'),
(4, 1, 1, '2026-10-10 00:17:30'),
(5, 16, 1, '2026-10-30 18:11:13'),
(6, 11, 1, '2026-10-30 19:49:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_items`
--
-- Creación: 09-06-2026 a las 14:36:20
-- Última actualización: 30-10-2026 a las 17:56:45
--

CREATE TABLE `user_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user_items`
--

INSERT INTO `user_items` (`id`, `user_id`, `item_id`, `quantity`) VALUES
(1, 1, 2, 32),
(2, 1, 1, 1),
(3, 1, 3, 45),
(4, 1, 4, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_levels`
--
-- Creación: 29-10-2026 a las 18:15:24
--

CREATE TABLE `user_levels` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `level_id` int(11) NOT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `incorrect_answers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user_levels`
--

INSERT INTO `user_levels` (`id`, `user_id`, `level_id`, `completed`, `incorrect_answers`) VALUES
(1, 1, 1, 1, 0),
(2, 1, 2, 1, 0),
(3, 1, 3, 1, 0),
(4, 1, 4, 1, 0),
(5, 1, 5, 1, 0),
(6, 1, 6, 1, 0),
(7, 3, 1, 1, 0),
(8, 5, 1, 1, 0),
(9, 6, 1, 1, 0),
(10, 7, 1, 1, 0),
(11, 1, 7, 1, 0),
(12, 16, 1, 1, 0),
(13, 16, 7, 1, 0),
(14, 16, 5, 1, 0),
(15, 11, 1, 1, 0),
(16, 11, 2, 1, 0),
(17, 11, 3, 1, 3),
(18, 11, 4, 1, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `xp_required` (`xp_required`),
  ADD UNIQUE KEY `achievement_icon` (`achievement_icon`);

--
-- Indices de la tabla `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indices de la tabla `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rank_id` (`rank_id`),
  ADD KEY `equipped_title_id` (`equipped_title_id`),
  ADD KEY `equipped_frame_id` (`equipped_frame_id`),
  ADD KEY `equipped_avatar_id` (`equipped_avatar_id`);

--
-- Indices de la tabla `user_achievement`
--
ALTER TABLE `user_achievement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `achievement_id` (`achievement_id`);

--
-- Indices de la tabla `user_items`
--
ALTER TABLE `user_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `user_levels`
--
ALTER TABLE `user_levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `level_id` (`level_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `level`
--
ALTER TABLE `level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `user_achievement`
--
ALTER TABLE `user_achievement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `user_items`
--
ALTER TABLE `user_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `user_levels`
--
ALTER TABLE `user_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`equipped_title_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`equipped_frame_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `user_ibfk_4` FOREIGN KEY (`equipped_avatar_id`) REFERENCES `item` (`id`);

--
-- Filtros para la tabla `user_achievement`
--
ALTER TABLE `user_achievement`
  ADD CONSTRAINT `user_achievement_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_achievement_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`id`);

--
-- Filtros para la tabla `user_items`
--
ALTER TABLE `user_items`
  ADD CONSTRAINT `user_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`);

--
-- Filtros para la tabla `user_levels`
--
ALTER TABLE `user_levels`
  ADD CONSTRAINT `user_levels_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_levels_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
