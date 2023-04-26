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

CREATE TABLE `preorder_product` (
  `preorder_id` varchar(45) NOT NULL,
  `product_id` varchar(45) NOT NULL,
  PRIMARY KEY (`preorder_id`,`product_id`),
  KEY `product_pp_idx` (`product_id`),
  CONSTRAINT `preorder_pp` FOREIGN KEY (`preorder_id`) REFERENCES `preorder` (`preorder_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_pp` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `user` (`user_id`, `user_first_name`, `user_last_name`, `user_email`, `user_how_to_know_us`, `user_phone_number`, `user_create_time`)
VALUES ('00fkXxesFNbzzXFc5T2GGwQZBOx1', '魏', '可晴', 'waketodo@gmail.com', '學生交流版', '0909503617', '2022-06-17 09:48:18');

INSERT INTO `type` (`type_id`, `type_name`, `user_id`)
VALUES ('dUoM8j33QOoMufngHglh', '香皂', '00fkXxesFNbzzXFc5T2GGwQZBOx1');

INSERT INTO `product` (`product_id`, `user_id`, `type_id`, `product_name`, `product_price`, `product_spec`, `product_enable`)
VALUES ('4wbx9iDwlxtxwuxWdxfG', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 'dUoM8j33QOoMufngHglh', '米糠皂', 229, '梔子花', 1),
       ('M7NCyLbo7bLK8PxqZJp8', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 'dUoM8j33QOoMufngHglh', '米糠皂', 249, '純米皂', 1),
       ('YhUB8k2KOsGrxn3NbCjr', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 'dUoM8j33QOoMufngHglh', '米糠皂', 229, '白茶樹', 1),
       ('kszyiuE1OGZkBALDlaDx', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 'dUoM8j33QOoMufngHglh', '米糠皂', 229, '黃香木', 1);

INSERT INTO `discount` (`discount_id`, `user_id`, `discount_value`, `discount_name`, `discount_note`)
VALUES ('7cIST5sJmrwhfmtHbhHm', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 20, "追蹤九折", 'none');

INSERT INTO `staff` (`staff_id`, `user_id`, `staff_name`, `staff_phone_number`, `staff_email`)
VALUES ('k7LaWj79lc7kj8Wt6Fx5', '00fkXxesFNbzzXFc5T2GGwQZBOx1', '魏可晴', '0909503617', 'cathie22580@gmail.com');

INSERT INTO `order` (`order_id`, `user_id`, `staff_id`, `order_discount`, `order_note`, `order_create_time`, `order_total_price`)
VALUES ('GOI83b0EqgCcmEHOh32U', '00fkXxesFNbzzXFc5T2GGwQZBOx1', 'k7LaWj79lc7kj8Wt6Fx5', 0, '110204011', '2022-07-17 09:48:18', 249);

INSERT INTO `order_product` (`order_id`, `product_id`, `op_amount`)
VALUES ('GOI83b0EqgCcmEHOh32U', 'M7NCyLbo7bLK8PxqZJp8', 1);

INSERT INTO `tag` (`tag_id`, `user_id`, `tag_name`)
VALUES ('7UhtpM8s1WykcfGIPJkU', '00fkXxesFNbzzXFc5T2GGwQZBOx1', '草莓杯杯');

INSERT INTO `order_tag` (`order_id`, `tage_id`)
VALUES ('GOI83b0EqgCcmEHOh32U', '7UhtpM8s1WykcfGIPJkU');

INSERT INTO `preorder` (`preorder_id`, `user_id`, `preorder_contact`, `preorder_create_time`, `preorder_is_picked`, `preorder_note`, `preorder_pick_up_time`, `preorder_store_name`)
VALUES ('3ExP2YKc0PkKY9BWYQs4', '00fkXxesFNbzzXFc5T2GGwQZBOx1', '123', '2022-07-17 09:48:18', 0, 'none', '2022-07-17 09:48:18', 'name');
