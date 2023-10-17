CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `dim_products` (
  `supplier_ids` longtext,
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
ALTER TABLE dim_shippers RENAME COLUMN id TO shipper_key;


CREATE TABLE `orders_status` (
  `id` tinyint NOT NULL,
  `status_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price` decimal(19,4) DEFAULT '0.0000',
  `discount` double NOT NULL DEFAULT '0',
  `status_id` int DEFAULT NULL,
  `date_allocated` datetime DEFAULT NULL,
  `purchase_order_id` int DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`),
  KEY `id_4` (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `id_5` (`id`),
  KEY `fk_order_details_orders1_idx` (`order_id`),
  KEY `fk_order_details_order_details_status1_idx` (`status_id`),
  CONSTRAINT `fk_order_details_order_details_status1` FOREIGN KEY (`status_id`) REFERENCES `order_details_status` (`id`),
  CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3;
CREATE TABLE `order_details_status` (
  `id` int NOT NULL,
  `status_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;




