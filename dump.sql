-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Hotel
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contrato_servicio`
--

DROP TABLE IF EXISTS `contrato_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contrato_servicio` (
  `usuario_id` int(11) NOT NULL,
  `servicio_id` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `nombre_titular` varchar(250) NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  PRIMARY KEY (`usuario_id`,`servicio_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `contrato_servicio_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `contrato_servicio_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato_servicio`
--

LOCK TABLES `contrato_servicio` WRITE;
/*!40000 ALTER TABLE `contrato_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `contrato_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitacion`
--

DROP TABLE IF EXISTS `habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `habitacion` (
  `numero` int(11) NOT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_habitacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitacion`
--

LOCK TABLES `habitacion` WRITE;
/*!40000 ALTER TABLE `habitacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paquete`
--

DROP TABLE IF EXISTS `paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paquete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquete`
--

LOCK TABLES `paquete` WRITE;
/*!40000 ALTER TABLE `paquete` DISABLE KEYS */;
/*!40000 ALTER TABLE `paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paquete_incluye`
--

DROP TABLE IF EXISTS `paquete_incluye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paquete_incluye` (
  `paquete_id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `servicio_id` int(11) NOT NULL,
  PRIMARY KEY (`paquete_id`,`tipo_id`,`servicio_id`),
  KEY `tipo_id` (`tipo_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `paquete_incluye_ibfk_1` FOREIGN KEY (`paquete_id`) REFERENCES `paquete` (`id`),
  CONSTRAINT `paquete_incluye_ibfk_2` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_habitacion` (`id`),
  CONSTRAINT `paquete_incluye_ibfk_3` FOREIGN KEY (`servicio_id`) REFERENCES `servicio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquete_incluye`
--

LOCK TABLES `paquete_incluye` WRITE;
/*!40000 ALTER TABLE `paquete_incluye` DISABLE KEYS */;
/*!40000 ALTER TABLE `paquete_incluye` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocion_habitacion`
--

DROP TABLE IF EXISTS `promocion_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promocion_habitacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_id` int(11) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `promocion_habitacion_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_habitacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocion_habitacion`
--

LOCK TABLES `promocion_habitacion` WRITE;
/*!40000 ALTER TABLE `promocion_habitacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promocion_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocion_servicio`
--

DROP TABLE IF EXISTS `promocion_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promocion_servicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servicio_id` int(11) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `promocion_servicio_ibfk_1` FOREIGN KEY (`servicio_id`) REFERENCES `servicio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocion_servicio`
--

LOCK TABLES `promocion_servicio` WRITE;
/*!40000 ALTER TABLE `promocion_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `promocion_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva_habitacion`
--

DROP TABLE IF EXISTS `reserva_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserva_habitacion` (
  `usuario_id` int(11) NOT NULL,
  `numero_habitacion` int(11) NOT NULL,
  `fecha_reservacion` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `nombre_titular` varchar(250) NOT NULL,
  `personas` int(11) NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  PRIMARY KEY (`usuario_id`,`numero_habitacion`,`fecha_reservacion`,`fecha_inicio`),
  KEY `numero_habitacion` (`numero_habitacion`),
  CONSTRAINT `reserva_habitacion_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `reserva_habitacion_ibfk_2` FOREIGN KEY (`numero_habitacion`) REFERENCES `habitacion` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva_habitacion`
--

LOCK TABLES `reserva_habitacion` WRITE;
/*!40000 ALTER TABLE `reserva_habitacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva_paquete`
--

DROP TABLE IF EXISTS `reserva_paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserva_paquete` (
  `usuario_id` int(11) NOT NULL,
  `paquete_id` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  PRIMARY KEY (`usuario_id`,`paquete_id`,`fecha_compra`,`fecha_inicio`),
  KEY `paquete_id` (`paquete_id`),
  CONSTRAINT `reserva_paquete_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `reserva_paquete_ibfk_2` FOREIGN KEY (`paquete_id`) REFERENCES `paquete` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva_paquete`
--

LOCK TABLES `reserva_paquete` WRITE;
/*!40000 ALTER TABLE `reserva_paquete` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva_paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_habitacion`
--

DROP TABLE IF EXISTS `tipo_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_habitacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_habitacion`
--

LOCK TABLES `tipo_habitacion` WRITE;
/*!40000 ALTER TABLE `tipo_habitacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'oscarf17','Oscar Flores','pbkdf2:sha256:600000$nK0X0Jl8JBpM87mW$2e3df3700de4d9a8e8c782f7b7ab550654e90ef5cfa382564f933b03e3d442e9'),(2,'oscar','Oscar flores','pbkdf2:sha256:260000$DiwmrXCUWJuniOep$5779840f6fbde98794f1048dac903e5da42812ac7bf8741bb23a7531d520e259');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-18  0:12:39
USE Hotel;
GRANT ALL PRIVILEGES ON * TO hotelAdmin IDENTIFIED BY '666';