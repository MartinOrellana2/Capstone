-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: capstone_db
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_agendamiento`
--

DROP TABLE IF EXISTS `accounts_agendamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_agendamiento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_hora_programada` datetime(6) NOT NULL,
  `duracion_estimada_minutos` int unsigned NOT NULL,
  `motivo_ingreso` longtext NOT NULL,
  `estado` varchar(50) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `chofer_asociado_id` bigint DEFAULT NULL,
  `creado_por_id` bigint NOT NULL,
  `vehiculo_id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_agendamiento_vehiculo_id_fecha_hora_p_de9fadc6_uniq` (`vehiculo_id`,`fecha_hora_programada`),
  KEY `accounts_agendamient_chofer_asociado_id_6717c13a_fk_accounts_` (`chofer_asociado_id`),
  KEY `accounts_agendamient_creado_por_id_84242593_fk_accounts_` (`creado_por_id`),
  CONSTRAINT `accounts_agendamient_chofer_asociado_id_6717c13a_fk_accounts_` FOREIGN KEY (`chofer_asociado_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `accounts_agendamient_creado_por_id_84242593_fk_accounts_` FOREIGN KEY (`creado_por_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `accounts_agendamient_vehiculo_id_0bc6cf51_fk_accounts_` FOREIGN KEY (`vehiculo_id`) REFERENCES `accounts_vehiculo` (`patente`),
  CONSTRAINT `accounts_agendamiento_chk_1` CHECK ((`duracion_estimada_minutos` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_agendamiento`
--

LOCK TABLES `accounts_agendamiento` WRITE;
/*!40000 ALTER TABLE `accounts_agendamiento` DISABLE KEYS */;
INSERT INTO `accounts_agendamiento` VALUES (21,'2025-10-08 10:34:11.000000',60,'Vel voluptates sunt doloremque ex sed.','Programado','2025-09-09 20:25:22.760083',44,44,'AGAU08'),(22,'2025-09-12 19:16:51.000000',60,'Maiores unde culpa maxime.','Programado','2025-09-09 20:25:22.779907',41,41,'PW3774'),(23,'2025-09-27 08:03:59.000000',60,'Consectetur laudantium id aut eum.','Programado','2025-09-09 20:25:22.801068',44,44,'XLIL63'),(24,'2025-10-07 01:22:39.000000',60,'Esse amet adipisci omnis eos reprehenderit.','Programado','2025-09-09 20:25:22.820566',44,44,'QSFO22'),(25,'2025-09-26 11:48:18.000000',60,'Ea tempore magnam id nesciunt dolore.','Programado','2025-09-09 20:25:22.844275',43,43,'XLIL63'),(26,'2025-10-05 22:10:47.000000',60,'Sed est enim consequuntur unde.','Programado','2025-09-09 20:25:22.867936',43,43,'WXMY87'),(27,'2025-10-01 05:18:52.000000',60,'Libero commodi non. Esse ab voluptatum totam.','Programado','2025-09-09 20:25:22.881569',43,43,'XLIL63'),(28,'2025-10-04 06:59:35.000000',60,'Maiores illo iusto rerum.','Programado','2025-09-09 20:25:22.900051',44,44,'XLIL63'),(29,'2025-09-21 12:32:21.000000',60,'Dolorem quae totam et.','Programado','2025-09-09 20:25:22.918542',41,41,'QSFO22'),(30,'2025-09-17 16:12:20.000000',60,'Architecto hic laudantium accusantium cum.','Programado','2025-09-09 20:25:22.941222',44,44,'XQ6097'),(31,'2025-09-09 20:37:09.000000',60,'pinchao','Programado','2025-09-09 20:37:29.833470',43,44,'QQ5436'),(32,'2025-09-09 20:39:21.000000',60,'hgjg','Programado','2025-09-09 20:39:30.521831',41,41,'AGAU08'),(33,'2025-09-09 20:45:32.000000',60,'asdasdas','Confirmado','2025-09-09 20:45:42.574667',44,46,'TO1244'),(34,'2025-09-10 13:00:00.000000',60,'falla en el motor','Programado','2025-09-10 18:24:18.294742',NULL,47,'EPMC93'),(35,'2025-09-10 13:00:00.000000',60,'sad','Programado','2025-09-10 18:42:58.586217',NULL,43,'WXMY87'),(36,'2025-09-10 12:00:00.000000',60,'sfd','Programado','2025-09-10 18:43:10.184220',NULL,43,'WXMY87'),(37,'2025-09-10 14:00:00.000000',60,'sdf','Programado','2025-09-10 18:43:20.821301',NULL,43,'XLIL63'),(38,'2025-09-10 15:00:00.000000',60,'asd','Programado','2025-09-10 19:14:47.549299',NULL,43,'WJKP91'),(39,'2025-09-24 15:00:00.000000',60,'sdfsd','Programado','2025-09-10 19:38:46.605176',NULL,47,'DU4933');
/*!40000 ALTER TABLE `accounts_agendamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_orden`
--

DROP TABLE IF EXISTS `accounts_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_orden` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_ingreso` datetime(6) NOT NULL,
  `fecha_entrega_estimada` date DEFAULT NULL,
  `fecha_entrega_real` datetime(6) DEFAULT NULL,
  `estado` varchar(50) NOT NULL,
  `descripcion_falla` longtext NOT NULL,
  `diagnostico_tecnico` longtext,
  `agendamiento_origen_id` bigint DEFAULT NULL,
  `usuario_asignado_id` bigint DEFAULT NULL,
  `vehiculo_id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agendamiento_origen_id` (`agendamiento_origen_id`),
  KEY `accounts_orden_usuario_asignado_id_7f76c368_fk_accounts_` (`usuario_asignado_id`),
  KEY `accounts_orden_vehiculo_id_1f020d18_fk_accounts_vehiculo_patente` (`vehiculo_id`),
  CONSTRAINT `accounts_orden_agendamiento_origen__148dbfc4_fk_accounts_` FOREIGN KEY (`agendamiento_origen_id`) REFERENCES `accounts_agendamiento` (`id`),
  CONSTRAINT `accounts_orden_usuario_asignado_id_7f76c368_fk_accounts_` FOREIGN KEY (`usuario_asignado_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `accounts_orden_vehiculo_id_1f020d18_fk_accounts_vehiculo_patente` FOREIGN KEY (`vehiculo_id`) REFERENCES `accounts_vehiculo` (`patente`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_orden`
--

LOCK TABLES `accounts_orden` WRITE;
/*!40000 ALTER TABLE `accounts_orden` DISABLE KEYS */;
INSERT INTO `accounts_orden` VALUES (21,'2025-09-09 20:25:22.764899',NULL,NULL,'Ingresado','Commodi voluptatibus in atque cumque excepturi labore.',NULL,21,NULL,'AGAU08'),(22,'2025-09-09 20:25:22.787110',NULL,NULL,'Finalizado','Quo modi ullam voluptates.',NULL,22,NULL,'PW3774'),(23,'2025-09-09 20:25:22.806179',NULL,NULL,'Pausado','Nulla necessitatibus distinctio eaque harum.',NULL,23,NULL,'XLIL63'),(24,'2025-09-09 20:25:22.825630',NULL,NULL,'En Proceso','Temporibus atque optio hic officia aliquid.',NULL,24,NULL,'QSFO22'),(25,'2025-09-09 20:25:22.849227',NULL,NULL,'Ingresado','Aperiam corporis perspiciatis molestias aliquam itaque cupiditate.',NULL,25,NULL,'XLIL63'),(26,'2025-09-09 20:25:22.872138',NULL,NULL,'Pausado','Nostrum ratione fugiat delectus illum voluptate sunt.',NULL,26,NULL,'WXMY87'),(27,'2025-09-09 20:25:22.886046',NULL,NULL,'En Proceso','Hic aliquid voluptatum hic velit.',NULL,27,NULL,'XLIL63'),(28,'2025-09-09 20:25:22.904563',NULL,NULL,'Finalizado','Debitis exercitationem asperiores nihil est.',NULL,28,NULL,'XLIL63'),(29,'2025-09-09 20:25:22.922994',NULL,NULL,'En Diagnostico','Porro numquam occaecati incidunt placeat recusandae.',NULL,29,NULL,'QSFO22'),(30,'2025-09-09 20:25:22.945308',NULL,NULL,'Finalizado','Impedit facilis magnam rem.',NULL,30,NULL,'XQ6097'),(31,'2025-09-09 20:43:40.646794','2025-09-09','2025-09-09 20:42:03.000000','En Proceso','pinchazo','solo le faltaba aire',31,37,'BLHS48');
/*!40000 ALTER TABLE `accounts_orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_ordendocumento`
--

DROP TABLE IF EXISTS `accounts_ordendocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_ordendocumento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `orden_id` bigint NOT NULL,
  `subido_por_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_ordendocumento_orden_id_2dc7fdf3_fk_accounts_orden_id` (`orden_id`),
  KEY `accounts_ordendocume_subido_por_id_f9428e97_fk_accounts_` (`subido_por_id`),
  CONSTRAINT `accounts_ordendocume_subido_por_id_f9428e97_fk_accounts_` FOREIGN KEY (`subido_por_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `accounts_ordendocumento_orden_id_2dc7fdf3_fk_accounts_orden_id` FOREIGN KEY (`orden_id`) REFERENCES `accounts_orden` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_ordendocumento`
--

LOCK TABLES `accounts_ordendocumento` WRITE;
/*!40000 ALTER TABLE `accounts_ordendocumento` DISABLE KEYS */;
INSERT INTO `accounts_ordendocumento` VALUES (1,'Foto','1232','ordenes_documentos/2025/09/ChatGPT_Image_18_ago_2025_12_33_12.png','2025-09-09 20:43:40.657299',31,46);
/*!40000 ALTER TABLE `accounts_ordendocumento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_ordenhistorialestado`
--

DROP TABLE IF EXISTS `accounts_ordenhistorialestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_ordenhistorialestado` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `orden_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_ordenhistor_orden_id_5d68951f_fk_accounts_` (`orden_id`),
  KEY `accounts_ordenhistor_usuario_id_9505236e_fk_accounts_` (`usuario_id`),
  CONSTRAINT `accounts_ordenhistor_orden_id_5d68951f_fk_accounts_` FOREIGN KEY (`orden_id`) REFERENCES `accounts_orden` (`id`),
  CONSTRAINT `accounts_ordenhistor_usuario_id_9505236e_fk_accounts_` FOREIGN KEY (`usuario_id`) REFERENCES `accounts_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_ordenhistorialestado`
--

LOCK TABLES `accounts_ordenhistorialestado` WRITE;
/*!40000 ALTER TABLE `accounts_ordenhistorialestado` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_ordenhistorialestado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_ordenitem`
--

DROP TABLE IF EXISTS `accounts_ordenitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_ordenitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `orden_id` bigint NOT NULL,
  `producto_id` varchar(50) DEFAULT NULL,
  `servicio_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_ordenitem_orden_id_271eb364_fk_accounts_orden_id` (`orden_id`),
  KEY `accounts_ordenitem_producto_id_7ae69cf6_fk_accounts_producto_sku` (`producto_id`),
  KEY `accounts_ordenitem_servicio_id_481f68b2_fk_accounts_servicio_id` (`servicio_id`),
  CONSTRAINT `accounts_ordenitem_orden_id_271eb364_fk_accounts_orden_id` FOREIGN KEY (`orden_id`) REFERENCES `accounts_orden` (`id`),
  CONSTRAINT `accounts_ordenitem_producto_id_7ae69cf6_fk_accounts_producto_sku` FOREIGN KEY (`producto_id`) REFERENCES `accounts_producto` (`sku`),
  CONSTRAINT `accounts_ordenitem_servicio_id_481f68b2_fk_accounts_servicio_id` FOREIGN KEY (`servicio_id`) REFERENCES `accounts_servicio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_ordenitem`
--

LOCK TABLES `accounts_ordenitem` WRITE;
/*!40000 ALTER TABLE `accounts_ordenitem` DISABLE KEYS */;
INSERT INTO `accounts_ordenitem` VALUES (41,1.00,44706.63,21,'P-11',NULL),(42,1.00,29335.83,21,NULL,15),(43,1.00,29335.83,22,NULL,15),(44,1.00,36650.71,22,NULL,12),(45,2.00,43466.76,23,'P-18',NULL),(46,3.00,34266.44,23,'P-10',NULL),(47,1.00,10813.53,24,'P-14',NULL),(48,2.00,44706.63,24,'P-11',NULL),(49,1.00,43466.76,24,'P-18',NULL),(50,1.00,36650.71,25,NULL,12),(51,1.00,14659.57,25,NULL,13),(52,1.00,17654.58,25,'P-7',NULL),(53,3.00,9387.97,26,'P-8',NULL),(54,1.00,36650.71,27,NULL,12),(55,1.00,29335.83,27,NULL,15),(56,2.00,19379.53,28,'P-17',NULL),(57,1.00,14659.57,28,NULL,13),(58,1.00,19601.03,29,NULL,NULL),(59,3.00,44951.13,29,'P-16',NULL),(60,1.00,30956.84,29,'P-15',NULL),(61,3.00,44706.63,30,'P-11',NULL),(62,1.01,12.00,31,'P-4',NULL);
/*!40000 ALTER TABLE `accounts_ordenitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_producto`
--

DROP TABLE IF EXISTS `accounts_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_producto` (
  `sku` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` longtext,
  `marca` varchar(50) DEFAULT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock` int unsigned NOT NULL,
  PRIMARY KEY (`sku`),
  CONSTRAINT `accounts_producto_chk_1` CHECK ((`stock` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_producto`
--

LOCK TABLES `accounts_producto` WRITE;
/*!40000 ALTER TABLE `accounts_producto` DISABLE KEYS */;
INSERT INTO `accounts_producto` VALUES ('P-0','Fuga','Praesentium velit quidem dolor possimus.','Pinto Limitada',12755.46,76),('P-1','Sunt','Facilis consequuntur deserunt rem.','Holding Medina y Asociados S.p.A.',1976.87,51),('P-10','Fuga','Iusto ex labore iure.','Daniela Antonia Gómez Opazo EIRL',34266.44,97),('P-11','Molestias','Odio totam eligendi placeat explicabo.','Morales y Retamal SPA',44706.63,60),('P-12','Soluta','Corporis velit quidem quia consectetur culpa.','Laboratorio Ávila y Villablanca S.p.A.',11651.37,2),('P-13','Numquam','Ducimus pariatur ipsum mollitia temporibus eligendi unde nostrum.','Despacho Gómez y Vásquez S.p.A.',21790.16,54),('P-14','Quo','Dolor consectetur minus libero vel sapiente nemo.','Garrido y Iturra S.p.A.',10813.53,22),('P-15','Ex','Fugiat modi facere iste voluptate dignissimos.','Fuentes y Vivanco S.p.A.',30956.84,9),('P-16','Vero','Possimus quia saepe aspernatur saepe.','Gutiérrez y Cerda Limitada',44951.13,65),('P-17','Molestiae','Possimus earum culpa ut iste quaerat.','López Ltda.',19379.53,27),('P-18','Totam','Ex commodi odit exercitationem provident occaecati itaque.','Gómez y Castro Limitada',43466.76,92),('P-19','Accusantium','Deleniti placeat excepturi tenetur hic deserunt.','Henríquez, Catalán y Romero Ltda.',8664.36,65),('P-2','Enim','Laudantium dolor temporibus.','Compañía Figueroa, Leyton y Castillo S.p.A.',38576.88,19),('P-3','Non','Ipsam iste voluptatibus nam ipsam.','Lucía María Arriagada Vega EIRL',24721.47,74),('P-4','Esse','Quos dolorem ipsa.','María Flores Sepúlveda EIRL',17880.55,26),('P-5','Nam','Ratione iure repellendus doloremque sed explicabo quam.','Osorio Sociedad Anónima',4076.30,29),('P-6','Odio','Commodi quam dicta aliquam adipisci fugiat.','Muñoz Ltda.',44394.60,56),('P-7','Exercitationem','Illum id magnam aliquid corporis.','María Cárcamo Alvarado E.I.R.L.',17654.58,93),('P-8','Perferendis','Aperiam rem laboriosam ad voluptas minus.','Riquelme y Vera SPA',9387.97,96),('P-9','Quisquam','Quam adipisci voluptas laborum quisquam illum quod.','Grupo Mondaca y Asociados Sociedad Anónima',43782.82,32);
/*!40000 ALTER TABLE `accounts_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_servicio`
--

DROP TABLE IF EXISTS `accounts_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_servicio` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` longtext,
  `precio_base` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_servicio`
--

LOCK TABLES `accounts_servicio` WRITE;
/*!40000 ALTER TABLE `accounts_servicio` DISABLE KEYS */;
INSERT INTO `accounts_servicio` VALUES (12,'Servicio 2','Laborum repellat magni impedit a.',36650.71),(13,'Servicio 3','Voluptatum dolor magni deserunt.',14659.57),(14,'Servicio 4','Cum quos explicabo aperiam iure aut voluptatibus.',49635.09),(15,'Servicio 5','Eius vel cum atque optio illum quia dolores.',29335.83);
/*!40000 ALTER TABLE `accounts_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_usuario`
--

DROP TABLE IF EXISTS `accounts_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `rut` varchar(12) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `rut` (`rut`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_usuario`
--

LOCK TABLES `accounts_usuario` WRITE;
/*!40000 ALTER TABLE `accounts_usuario` DISABLE KEYS */;
INSERT INTO `accounts_usuario` VALUES (1,'pbkdf2_sha256$1000000$HPEcRVsyhxMswIgsh2RnIH$nte+1DnJti/0ej51nvVgakgHBxuyA8MW2ek32QzaIXI=','2025-09-08 20:36:33.085306',1,'admin','juan','peres','lidif90147@ahanim.com',1,1,'2025-08-26 19:09:15.000000','434r53455345','987654321','2025-08-26 19:09:15.423372'),(37,'pbkdf2_sha256$1000000$F0uakVuVPjY2ziwRrJlUwx$29+cUVq5G35wZ9BPA1DAOioNVy3L/5QCT01dWRCliYo=',NULL,0,'user0','Francisco','Flores','ytorres@example.net',0,1,'2025-09-09 20:25:19.760670','12706224-12','+56 58 337 1748','2025-09-09 20:25:20.030271'),(38,'pbkdf2_sha256$1000000$OI9HhR09hrygZy1eBDr6wC$NQ21l7txgjrWN0VSaHDXI8HmN9Cl841xyaG5pUtrGqI=',NULL,0,'user1','Silvia','Briceño','sepulvedaangel@example.org',0,1,'2025-09-09 20:25:20.042408','20469328-1','+56 64 350 0375','2025-09-09 20:25:20.306527'),(39,'pbkdf2_sha256$1000000$MEdbOSGecydkvIXEL5EjGT$Mhm66JiULb0uyAnZh84OlYoIigV8E05R5Vaspe5b7ko=',NULL,0,'user2','Eduardo','Velásquez','giovanni12@example.com',0,1,'2025-09-09 20:25:20.318770','16553172-7','+56 800 301 302','2025-09-09 20:25:20.582842'),(40,'pbkdf2_sha256$1000000$uB3GsVtYHlhiQKT3G8O75u$TiPb+t69wHn2qtfa2slhWzGpTVE9TkUcVx55BM9+X8g=',NULL,0,'user34','Héctor','Castro','marionvillalobos@example.net',0,1,'2025-09-09 20:25:20.594299','17804320-2','+56 9 9178 0376','2025-09-09 20:25:20.867265'),(41,'pbkdf2_sha256$1000000$wOT7pJI8O1wkdbZ79TMWxE$obhjmsWMXoJXNeA8MLqp00ilb3IyJY7flNtsigltZXw=',NULL,0,'user4','Marcelo','Araya','zperez@example.net',0,1,'2025-09-09 20:25:20.879059','17906482-3','+56 600 232 796','2025-09-09 20:25:21.153426'),(42,'pbkdf2_sha256$1000000$3XH7f8o1mjC4Z4bmHcfHPd$3YdFQFzgO2Rdr6h2HUga8rGLOiLr68NEeJCHwlzwg1A=',NULL,0,'user5','Lilian','Varela','maitehernandez@example.com',0,1,'2025-09-09 20:25:21.163835','18790424-6','+56 800 958 136','2025-09-09 20:25:21.424015'),(43,'pbkdf2_sha256$1000000$YR89r54iHejcf2W65XLEnr$xXAUhy5+0mk4igXiE0EwKoTV2RpMIChSANKi+fkajkU=',NULL,0,'user6','Andrés','Guzmán','rvelasquez@example.com',0,1,'2025-09-09 20:25:21.436340','18847614-7','+56 800 542 796','2025-09-09 20:25:21.699363'),(44,'pbkdf2_sha256$1000000$G1gOFxJVpS1pjgrAwp5zV5$m42M8JQDRGrvqToCjBEksiQEq1IW4lGOWQdzKuxR8kA=',NULL,0,'user7','Isidora','Carrasco','elizabeth03@example.com',0,1,'2025-09-09 20:25:21.710714','10865257-9','+56 2 2668 6383','2025-09-09 20:25:21.981807'),(45,'pbkdf2_sha256$1000000$966E9RyCMCQEPfEMbngf5H$vpsWc90qdJA2ELlcKcHlXooSF6cLRx9zkTNah4QCaNw=',NULL,0,'user8','Eduardo','Pérez','azocarcecilia@example.com',0,1,'2025-09-09 20:25:21.992478','14418234-7','+56 800 576 426','2025-09-09 20:25:22.256586'),(46,'pbkdf2_sha256$1000000$LUf5frOi7lR3twCURgqqUv$0C1cqG5tdFyJ3iCALuDQ528+P1bEencXn3izWwNeh5o=',NULL,0,'user9','Romina','Solar','jaimeruiz@example.net',0,1,'2025-09-09 20:25:22.267490','11633323-2','+56 600 746 552','2025-09-09 20:25:22.529584'),(47,'pbkdf2_sha256$1000000$fDBdqyQevdutuCvVwsK8eK$ftBZurWrItM9i/umFNTWtbyIY/zvRCje6KFWvuTVcew=',NULL,0,'supervisor','','','',0,1,'2025-09-09 20:26:11.000000','23423424234',NULL,'2025-09-09 20:26:11.432616'),(48,'pbkdf2_sha256$1000000$5z7P6KoDQdU7A4bMQLRyqI$+aBxOUWoPW3/yF09KfxezH7Ula1IlIURxy4riALfBBs=',NULL,0,'trafico','asdad','asdad','yaasdajoka2545@cspaus.com',0,1,'2025-09-09 21:01:23.703062','987654321','adsada','2025-09-09 21:01:23.976063'),(49,'pbkdf2_sha256$1000000$N66th4NrXFWfmFyngehlCB$usue/4jpw/yF1ISfBKfNZ7F3fwpMT4CpOpJOdd6ulAA=',NULL,0,'compu','','','',0,1,'2025-09-11 15:08:12.973663','',NULL,'2025-09-11 15:08:13.238187'),(52,'pbkdf2_sha256$1000000$0ULgLowMMsB7Fd1s8FQxAV$gZYyYvzgeVckIgofspcur7O45iI9+tXUDNoajXon7r8=',NULL,0,'sdfsdfsdfs','eeda','dasdas','yajoka2545@cspaus.com',0,1,'2025-09-11 15:27:09.488264','21493894324','asdada','2025-09-11 15:27:09.749239');
/*!40000 ALTER TABLE `accounts_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_usuario_groups`
--

DROP TABLE IF EXISTS `accounts_usuario_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_usuario_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_usuario_groups_usuario_id_group_id_90f476d3_uniq` (`usuario_id`,`group_id`),
  KEY `accounts_usuario_groups_group_id_81d91a41_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_usuario_gro_usuario_id_8eb16911_fk_accounts_` FOREIGN KEY (`usuario_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `accounts_usuario_groups_group_id_81d91a41_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_usuario_groups`
--

LOCK TABLES `accounts_usuario_groups` WRITE;
/*!40000 ALTER TABLE `accounts_usuario_groups` DISABLE KEYS */;
INSERT INTO `accounts_usuario_groups` VALUES (1,1,1),(60,37,2),(45,38,4),(46,39,6),(56,40,2),(48,41,2),(49,42,6),(50,43,2),(51,44,2),(52,45,4),(53,46,4),(54,47,4),(57,48,5);
/*!40000 ALTER TABLE `accounts_usuario_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_usuario_user_permissions`
--

DROP TABLE IF EXISTS `accounts_usuario_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_usuario_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_usuario_user_pe_usuario_id_permission_id_0065a2ce_uniq` (`usuario_id`,`permission_id`),
  KEY `accounts_usuario_use_permission_id_3de42c14_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_usuario_use_permission_id_3de42c14_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_usuario_use_usuario_id_d048ad71_fk_accounts_` FOREIGN KEY (`usuario_id`) REFERENCES `accounts_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_usuario_user_permissions`
--

LOCK TABLES `accounts_usuario_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_usuario_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_usuario_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_vehiculo`
--

DROP TABLE IF EXISTS `accounts_vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_vehiculo` (
  `patente` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `anio` int NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `vin` varchar(50) DEFAULT NULL,
  `kilometraje` int DEFAULT NULL,
  `chofer_id` bigint DEFAULT NULL,
  PRIMARY KEY (`patente`),
  UNIQUE KEY `vin` (`vin`),
  KEY `accounts_vehiculo_chofer_id_f7a5bfee_fk_accounts_usuario_id` (`chofer_id`),
  CONSTRAINT `accounts_vehiculo_chofer_id_f7a5bfee_fk_accounts_usuario_id` FOREIGN KEY (`chofer_id`) REFERENCES `accounts_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_vehiculo`
--

LOCK TABLES `accounts_vehiculo` WRITE;
/*!40000 ALTER TABLE `accounts_vehiculo` DISABLE KEYS */;
INSERT INTO `accounts_vehiculo` VALUES ('AGAU08','Toro y Vásquez Limitada','herido',1984,'Azul pizarra medio','d2a4f437-0e43-4962-a8a9-98886e932206',147334,41),('BLHS48','Duarte S.p.A.','illum',1999,'Verde mar medio','b4f83039-6543-44e4-95ee-233561ecc62b',99462,43),('DU4933','Club Ojeda, Pérez y Fierro SPA','sequi',1977,'Oliva','226f3a42-9dc0-4b2f-bd20-8a09a090935e',12601,37),('EPMC93','Correa, Herrera y Pérez Ltda.','occaecati',1982,'Índigo','440c14e0-62a6-49a1-be3a-ba17c2e4e97e',155492,NULL),('fuaSD','ASDA','DASDA',23423,'ASDAS','ASDASD32',23423,40),('GL1201','Faúndez Sociedad Anónima','fuga',1988,'Violeta sonrojado pálido','134761aa-f99d-41ee-9a88-df78a939c6be',107164,44),('PW3774','Gaete y Fuentes S.A.','rem',2022,'Azul cielo claro','220f07a3-3acf-4e0e-9ac6-5d2626cd9331',38139,NULL),('QQ5436','Industrias Fuentes y Asociados S.p.A.','maiores',2011,'Beige mocasín','af022012-a308-46ca-bd69-f4b3874eacc0',74979,NULL),('QSFO22','García S.A.','ad',2009,'Rojo oscuro','09e5b64e-24df-40e2-ad2d-902342fe0c5c',35862,NULL),('TO1244','Grupo Bastías, Gallegos y Catalán Sociedad Anónima','debitis',1973,'Azul acero claro','644886db-6d01-47ae-a619-3269a83e0a4e',83402,43),('WJKP91','Katherine Arenas E.I.R.L.','laborum',1978,'Verde primavera','d3b1f444-bd7c-415b-a42d-7fba975830b3',156256,43),('WQ9426','Compañía Pulgar, Toledo y Díaz Sociedad Anónima','aliquid',1978,'Marfil','2bc2bdde-bef4-49d1-a16f-8caae2b89072',23382,43),('WXMY87','Grupo Gutiérrez y Parra S.p.A.','nostrum',2006,'Blanco menta','0fe6822a-6297-4086-a523-b57ac1ab7ec0',57440,NULL),('XLIL63','Compañía González y Valderrama SPA','commodi',2001,'Verde mar oscuro','cd029efa-3349-4e27-a2f5-ccd1c26881fe',182476,43),('XQ6097','Venegas S.p.A.','reprehenderit',2021,'Verde mar medio','01844060-7708-4d57-aff2-122b0dbf1cdf',196171,40),('YX1327','Pérez y Torres SPA','porro',1985,'Blanco concha','79e4aaa3-f0c4-4706-83ae-49ae03888971',84340,37);
/*!40000 ALTER TABLE `accounts_vehiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'admin'),(6,'Administrativo'),(2,'Chofer'),(3,'Mecánico'),(5,'Seguridad'),(4,'Supervisor');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,2,32),(58,2,37),(59,2,38),(60,2,40),(61,2,44),(62,2,45),(63,2,48),(75,3,24),(76,3,28),(64,3,32),(65,3,42),(66,3,44),(67,3,45),(68,3,46),(69,3,48),(70,3,49),(71,3,53),(72,3,54),(73,3,55),(74,3,56),(97,4,21),(98,4,22),(99,4,23),(100,4,24),(101,4,25),(102,4,26),(103,4,27),(104,4,28),(105,4,29),(106,4,30),(107,4,31),(108,4,32),(109,4,33),(110,4,34),(111,4,35),(112,4,36),(113,4,37),(114,4,38),(115,4,39),(116,4,40),(117,4,41),(118,4,42),(119,4,43),(120,4,44),(121,4,45),(122,4,46),(123,4,47),(124,4,48),(125,4,49),(126,4,50),(127,4,51),(128,4,52),(129,4,53),(130,4,54),(131,4,55),(132,4,56),(134,5,32),(133,5,40);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add producto',6,'add_producto'),(22,'Can change producto',6,'change_producto'),(23,'Can delete producto',6,'delete_producto'),(24,'Can view producto',6,'view_producto'),(25,'Can add servicio',7,'add_servicio'),(26,'Can change servicio',7,'change_servicio'),(27,'Can delete servicio',7,'delete_servicio'),(28,'Can view servicio',7,'view_servicio'),(29,'Can add vehiculo',8,'add_vehiculo'),(30,'Can change vehiculo',8,'change_vehiculo'),(31,'Can delete vehiculo',8,'delete_vehiculo'),(32,'Can view vehiculo',8,'view_vehiculo'),(33,'Can add user',9,'add_usuario'),(34,'Can change user',9,'change_usuario'),(35,'Can delete user',9,'delete_usuario'),(36,'Can view user',9,'view_usuario'),(37,'Can add Agendamiento',10,'add_agendamiento'),(38,'Can change Agendamiento',10,'change_agendamiento'),(39,'Can delete Agendamiento',10,'delete_agendamiento'),(40,'Can view Agendamiento',10,'view_agendamiento'),(41,'Can add Orden de Servicio',11,'add_orden'),(42,'Can change Orden de Servicio',11,'change_orden'),(43,'Can delete Orden de Servicio',11,'delete_orden'),(44,'Can view Orden de Servicio',11,'view_orden'),(45,'Can add Documento de Orden',12,'add_ordendocumento'),(46,'Can change Documento de Orden',12,'change_ordendocumento'),(47,'Can delete Documento de Orden',12,'delete_ordendocumento'),(48,'Can view Documento de Orden',12,'view_ordendocumento'),(49,'Can add Historial de Estado de Orden',13,'add_ordenhistorialestado'),(50,'Can change Historial de Estado de Orden',13,'change_ordenhistorialestado'),(51,'Can delete Historial de Estado de Orden',13,'delete_ordenhistorialestado'),(52,'Can view Historial de Estado de Orden',13,'view_ordenhistorialestado'),(53,'Can add Ítem de Orden',14,'add_ordenitem'),(54,'Can change Ítem de Orden',14,'change_ordenitem'),(55,'Can delete Ítem de Orden',14,'delete_ordenitem'),(56,'Can view Ítem de Orden',14,'view_ordenitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_usuario_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_usuario` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-08-26 19:25:35.432300','1','admin',1,'[{\"added\": {}}]',3,1),(2,'2025-08-26 19:27:53.372958','1','juan peres (admin)',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\", \"Rut\", \"Telefono\", \"Grupos\"]}}]',9,1),(3,'2025-08-26 19:28:38.367945','1','juan peres (admin)',2,'[]',9,1),(4,'2025-09-08 20:40:17.956693','2','Chofer',1,'[{\"added\": {}}]',3,1),(5,'2025-09-08 20:41:50.321569','3','Mecánico',1,'[{\"added\": {}}]',3,1),(6,'2025-09-08 20:42:46.912678','4','Supervisor',1,'[{\"added\": {}}]',3,1),(7,'2025-09-08 20:43:07.435526','5','Seguridad',1,'[{\"added\": {}}]',3,1),(8,'2025-09-08 20:46:44.028427','4','Supervisor',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(9,'2025-09-08 20:47:28.978974','2','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(10,'2025-09-08 20:49:19.434799','2','  (Supervisor)',2,'[{\"changed\": {\"fields\": [\"Rut\", \"Grupos\"]}}]',9,1),(11,'2025-09-08 20:49:39.125366','2','  (Supervisor)',2,'[]',9,1),(12,'2025-09-08 20:49:54.211393','3','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(13,'2025-09-08 20:50:24.999591','3','  (Chofer)',2,'[{\"changed\": {\"fields\": [\"Rut\", \"Grupos\"]}}]',9,1),(14,'2025-09-08 20:50:50.565006','4','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(15,'2025-09-08 20:51:02.358292','4','  (Seguridad)',2,'[{\"changed\": {\"fields\": [\"Rut\", \"Grupos\"]}}]',9,1),(16,'2025-09-08 20:51:16.080496','5','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(17,'2025-09-08 23:56:30.954905','5','  (Mecánico)',2,'[{\"changed\": {\"fields\": [\"Rut\", \"Grupos\"]}}]',9,1),(18,'2025-09-09 19:25:50.278304','2','  (Supervisor)',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',9,1),(19,'2025-09-09 19:27:03.731530','2','añaña aña (Supervisor)',2,'[{\"changed\": {\"fields\": [\"Grupos\"]}}]',9,1),(20,'2025-09-09 20:26:11.433800','47','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(21,'2025-09-09 20:26:39.343525','47','  (Supervisor)',2,'[{\"changed\": {\"fields\": [\"Rut\", \"Grupos\"]}}]',9,1),(22,'2025-09-09 20:37:29.834283','31','Cita para QQ5436 el 09-09-2025 17:37',1,'[{\"added\": {}}]',10,1),(23,'2025-09-09 20:39:30.522232','32','Cita para AGAU08 el 09-09-2025 17:39',1,'[{\"added\": {}}]',10,1),(24,'2025-09-09 20:43:30.359206','11','Servicio 1',3,'',7,1),(25,'2025-09-09 20:43:40.657812','31','Orden #31 - BLHS48 (En Proceso)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"\\u00cdtem de Orden\", \"object\": \"Esse (x1.01)\"}}, {\"added\": {\"name\": \"Documento de Orden\", \"object\": \"Foto para Orden #31\"}}]',11,1),(26,'2025-09-09 20:45:42.575144','33','Cita para TO1244 el 09-09-2025 17:45',1,'[{\"added\": {}}]',10,1),(27,'2025-09-09 20:58:27.262360','13','Servicio 3',2,'[]',7,1),(28,'2025-09-09 22:34:36.742623','47','  (Supervisor)',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',9,1),(29,'2025-09-09 23:05:02.883011','43','Andrés Guzmán (Chofer)',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',9,1),(30,'2025-09-10 19:05:23.245529','YX1327','YX1327 - Pérez y Torres SPA porro (Francisco)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(31,'2025-09-10 19:05:26.354451','XQ6097','XQ6097 - Venegas S.p.A. reprehenderit (Héctor)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(32,'2025-09-10 19:05:29.214458','XLIL63','XLIL63 - Compañía González y Valderrama SPA commodi (Andrés)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(33,'2025-09-10 19:05:31.980581','WQ9426','WQ9426 - Compañía Pulgar, Toledo y Díaz Sociedad Anónima aliquid (Francisco)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(34,'2025-09-10 19:05:36.817652','fuaSD','fuaSD - ASDA DASDA (Isidora)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(35,'2025-09-10 19:06:00.158379','BLHS48','BLHS48 - Duarte S.p.A. illum (Andrés)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(36,'2025-09-10 19:12:21.412617','TO1244','TO1244 - Grupo Bastías, Gallegos y Catalán Sociedad Anónima debitis (Andrés)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(37,'2025-09-10 19:12:47.410226','WQ9426','WQ9426 - Compañía Pulgar, Toledo y Díaz Sociedad Anónima aliquid (Andrés)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(38,'2025-09-10 19:14:40.443075','WJKP91','WJKP91 - Katherine Arenas E.I.R.L. laborum (Andrés)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(39,'2025-09-10 19:17:46.498243','AGAU08','AGAU08 - Toro y Vásquez Limitada herido (Isidora)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(40,'2025-09-10 19:17:59.165975','AGAU08','AGAU08 - Toro y Vásquez Limitada herido (Isidora)',2,'[]',8,1),(41,'2025-09-10 19:18:01.562831','BLHS48','BLHS48 - Duarte S.p.A. illum (Andrés)',2,'[]',8,1),(42,'2025-09-10 19:18:05.248575','DU4933','DU4933 - Club Ojeda, Pérez y Fierro SPA sequi (Francisco)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(43,'2025-09-10 19:22:11.563042','fuaSD','fuaSD - ASDA DASDA (Héctor)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(44,'2025-09-10 19:22:21.044629','GL1201','GL1201 - Faúndez Sociedad Anónima fuga (Isidora)',2,'[{\"changed\": {\"fields\": [\"Chofer\"]}}]',8,1),(45,'2025-09-11 15:08:13.242064','49','  (Sin Rol)',1,'[{\"added\": {}}]',9,1),(46,'2025-09-11 15:27:09.750920','52','eeda dasdas (Sin Rol)',1,'[{\"added\": {}}]',9,1),(47,'2025-09-11 15:29:02.241594','53','sdfsdf asdada (Seguridad)',3,'',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (10,'accounts','agendamiento'),(11,'accounts','orden'),(12,'accounts','ordendocumento'),(13,'accounts','ordenhistorialestado'),(14,'accounts','ordenitem'),(6,'accounts','producto'),(7,'accounts','servicio'),(9,'accounts','usuario'),(8,'accounts','vehiculo'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-08-26 19:08:30.650695'),(2,'contenttypes','0002_remove_content_type_name','2025-08-26 19:08:30.776759'),(3,'auth','0001_initial','2025-08-26 19:08:31.248515'),(4,'auth','0002_alter_permission_name_max_length','2025-08-26 19:08:31.328316'),(5,'auth','0003_alter_user_email_max_length','2025-08-26 19:08:31.334319'),(6,'auth','0004_alter_user_username_opts','2025-08-26 19:08:31.341056'),(7,'auth','0005_alter_user_last_login_null','2025-08-26 19:08:31.350393'),(8,'auth','0006_require_contenttypes_0002','2025-08-26 19:08:31.354857'),(9,'auth','0007_alter_validators_add_error_messages','2025-08-26 19:08:31.360985'),(10,'auth','0008_alter_user_username_max_length','2025-08-26 19:08:31.368047'),(11,'auth','0009_alter_user_last_name_max_length','2025-08-26 19:08:31.374298'),(12,'auth','0010_alter_group_name_max_length','2025-08-26 19:08:31.389517'),(13,'auth','0011_update_proxy_permissions','2025-08-26 19:08:31.396238'),(14,'auth','0012_alter_user_first_name_max_length','2025-08-26 19:08:31.402353'),(15,'accounts','0001_initial','2025-08-26 19:08:33.019197'),(16,'admin','0001_initial','2025-08-26 19:08:33.199603'),(17,'admin','0002_logentry_remove_auto_add','2025-08-26 19:08:33.208912'),(18,'admin','0003_logentry_add_action_flag_choices','2025-08-26 19:08:33.217409'),(19,'sessions','0001_initial','2025-08-26 19:08:33.263700'),(20,'accounts','0002_alter_ordenitem_precio_unitario_and_more','2025-09-09 22:01:26.144020'),(21,'accounts','0003_vehiculo_chofer','2025-09-10 19:04:34.260440');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('9sq8mojjiwik6pwwaam35d6epag2j63r','.eJxVjMsOgjAQRf-la9P0YWnr0j3fQOZ2BkENJBRWxn9XEha6veec-1IdbevQbVWWbmR1UVadfjdQeci0A77TdJt1mad1GaF3RR-06nZmeV4P9-9goDp8677JoXdRfONTQYYzCUgOEimxiSLAOaMvVqKx2Vhm2CSe4BBcIK_eH_jSOIk:1uw7OY:A1E1QHOo-1Kl6Vz5WbQAJFE8TANDVEwN62O89ZNPna4','2025-09-23 23:05:02.899875');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-11 12:35:15
