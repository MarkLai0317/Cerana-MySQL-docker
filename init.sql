CREATE DATABASE IF NOT EXISTS ledger_schema;
USE ledger_schema;


CREATE TABLE `user` (
  `user_id` varchar(45) NOT NULL,
  `user_first_name` varchar(20) DEFAULT NULL,
  `user_last_name` varchar(20) DEFAULT NULL,
  `user_email` varchar(45) DEFAULT NULL,
  `user_how_to_know_us` varchar(45) DEFAULT NULL,
  `user_phone_number` varchar(10) DEFAULT NULL,
  `user_create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `type` (
  `type_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `type_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  KEY `user_type_idx` (`user_id`),
  CONSTRAINT `user_type` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `staff` (
  `staff_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `staff_name` varchar(45) DEFAULT NULL,
  `staff_phone_number` varchar(10) DEFAULT NULL,
  `staff_email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `user_staff_idx` (`user_id`),
  CONSTRAINT `user_staff` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `product` (
  `product_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `type_id` varchar(45) NOT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `product_spec` varchar(45) DEFAULT NULL,
  `product_enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`product_id`),
  KEY `user_product_idx` (`user_id`),
  KEY `type_product_idx` (`type_id`),
  CONSTRAINT `type_product` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_product` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `discount` (
  `discount_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `discount_value` int(11) DEFAULT NULL,
  `discount_name` varchar(45) DEFAULT NULL,
  `discount_note` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`discount_id`),
  KEY `user_discount_idx` (`user_id`),
  CONSTRAINT `user_discount` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tag` (
  `tag_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `tag_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `user_tag_idx` (`user_id`),
  CONSTRAINT `user_tag` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `order` (
  `order_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `staff_id` varchar(45) NOT NULL,
  `order_discount` int(11) DEFAULT NULL,
  `order_note` varchar(60) DEFAULT NULL,
  `order_create_time` datetime DEFAULT NULL,
  `order_total_price` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_order_idx` (`user_id`),
  KEY `staff_order_idx` (`staff_id`),
  CONSTRAINT `staff_order` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_order` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `order_product` (
  `order_id` varchar(45) NOT NULL,
  `product_id` varchar(45) NOT NULL,
  `op_amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_op_idx` (`product_id`),
  CONSTRAINT `order_op` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_op` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `order_tag` (
  `order_id` varchar(45) NOT NULL,
  `tag_id` varchar(45) NOT NULL,
  PRIMARY KEY (`order_id`,`tag_id`),
  KEY `tag_ot_idx` (`tag_id`),
  CONSTRAINT `order_ot` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_ot` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `preorder` (
  `preorder_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `preorder_contact` varchar(45) DEFAULT NULL,
  `preorder_create_time` datetime DEFAULT NULL,
  `preorder_is_picked` tinyint(4) NOT NULL DEFAULT 0,
  `preorder_note` varchar(60) DEFAULT NULL,
  `preorder_pick_up_time` datetime DEFAULT NULL,
  `preorder_store_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`preorder_id`),
  KEY `user_preorder_idx` (`user_id`),
  CONSTRAINT `user_preorder` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
