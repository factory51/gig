
DROP DATABASE IF EXISTS sound_sync;
CREATE DATABASE sound_sync;
USE sound_sync;


CREATE TABLE IF NOT EXISTS users
(
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    `status` TINYINT NOT NULL,
    PRIMARY KEY(user_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS user_passwords
(
    password_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    `password` CHAR(60) NOT NULL,
    salt CHAR(16) NOT NULL,
    created_at DATETIME NOT NULL,
    replaced_at DATETIME NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(password_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS user_types
(
    user_type_id INT NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(64) NOT NULL,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT,
    PRIMARY KEY(user_type_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS user_type_lookup
(
    user_id INT NOT NULL,
    user_type_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE VIEW current_user_type_view AS
SELECT
user_id,
user_type_id
FROM user_type_lookup WHERE is_active = 1;

CREATE TABLE IF NOT EXISTS application_actions
(
    action_id INT NOT NULL AUTO_INCREMENT,
    http_method VARCHAR(6) NOT NULL,
    `description` VARCHAR(32) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(action_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS application_endpoints
(
    endpoint_id INT NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(64),
    `route` VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(endpoint_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS user_type_endpoint_actions
(
    user_type_id INT NOT NULL,
    endpoint_id INT NOT NULL,
    action_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL
);

CREATE VIEW current_application_access AS 
SELECT
ae.`route`,
utea.user_type_id,
utea.endpoint_id,
utea.action_id
FROM user_type_endpoint_actions utea 
INNER JOIN application_endpoints ae ON ae.endpoint_id = utea.endpoint_id AND utea.is_active = 1
WHERE 
ae.is_active =1
GROUP BY 1,2,3,4;


CREATE TABLE IF NOT EXISTS countries
(
    country_id INT NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(64) NOT NULL,
    label VARCHAR(64) NOT NULL,
    iso CHAR(2) NOT NULL,
    iso3 CHAR(3) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(country_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS addresses
(
    address_id INT NOT NULL AUTO_INCREMENT,
    user_label VARCHAR(255) NOT NULL,
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255) NULL,
    address_line_3 VARCHAR(255) NULL,
    county VARCHAR(255),
    country_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(address_id),
    INDEX idx_country_id (country_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_addresses
(
  user_id INT UNSIGNED NOT NULL,
  address_id INT NOT NULL,
  is_primary TINYINT NOT NULL,
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  PRIMARY KEY (`user_id`, `address_id`)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS input_schemas 
(
  schema_id INT NOT NULL AUTO_INCREMENT,
  label VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  PRIMARY KEY (schema_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS schema_fields
(
    schema_id INT NOT NULL,
    key_name VARCHAR(64) NOT NULL,
    is_required TINYINT NOT NULL,
    `order` INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(schema_id, key_name),
    INDEX idx_schema_id (schema_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS user_details
(
  user_id INT UNSIGNED NOT NULL,
  schema_id INT NOT NULL,
  `key` VARCHAR(64) NOT NULL,
  `value` VARCHAR(225) NOT NULL,
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  INDEX idx_user_id (user_id),
  INDEX idx_schema_id (schema_id),
  INDEX idx_key (`key`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE VIEW current_user_details AS 
SELECT 
user_id,
schema_id,
`key`
`value`
FROM user_details WHERE is_active=1;

CREATE TABLE user_details_log
(
    user_id INT NOT NULL,
    schema_id INT NOT NULL,
    `key` VARCHAR(64) NOT NULL,
    old_value VARCHAR(255) NOT NULL,
    new_value VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS performers 
(
  performer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  label VARCHAR(64) NOT NULL, 
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  PRIMARY KEY (performer_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS performer_details
(
  performer_id INT UNSIGNED NOT NULL,
  schema_id INT NOT NULL,
  `key` VARCHAR(64) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  INDEX idx_performer_id (performer_id),
  INDEX idx_schema_id (schema_id),
  INDEX idx_key (`key`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE performer_details_log
(
    performer_id INT NOT NULL,
    schema_id INT NOT NULL,
    `key` VARCHAR(64) NOT NULL,
    old_value MEDIUMTEXT NOT NULL,
    new_value MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS bands 
(
  band_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  label VARCHAR(64) NOT NULL, 
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  PRIMARY KEY (band_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS band_details
(
  band_id INT UNSIGNED NOT NULL,
  schema_id INT NOT NULL,
  `key` VARCHAR(64) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  created_at DATETIME NOT NULL,
  created_user_id INT NOT NULL,
  modified_at DATETIME NULL,
  modified_user_id INT NULL,
  is_active TINYINT NOT NULL,
  INDEX idx_band_id (band_id),
  INDEX idx_schema_id (schema_id),
  INDEX idx_key (`key`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE band_details_log
(
    band_id INT NOT NULL,
    schema_id INT NOT NULL,
    `key` VARCHAR(64) NOT NULL,
    old_value MEDIUMTEXT NOT NULL,
    new_value MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE album_types 
(
    album_type_id INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(64) NOT NULL, 
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(album_type_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE record_labels
(
    record_label_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    address_id INT NOT NULL,
    label VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(record_label_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE albums
(
    album_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    album_type_id INT NOT NULL, 
    record_label_id INT NOT NULL,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(album_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE band_albums
(
    band_id INT NOT NULL,
    album_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(band_id, album_id),
    INDEX idx_band_id (band_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE performer_albums
(
    performer_id INT NOT NULL,
    album_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(performer_id, album_id),
    INDEX idx_performer_id (performer_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE currencies 
(
    currency_id INT NOT NULL AUTO_INCREMENT,
    label varchar(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(currency_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE album_unit_price
(
    album_id INT NOT NULL,
    currency_id INT NOT NULL,
    amount INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(album_id, currency_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE tracks
(
    track_id INT NOT NULL AUTO_INCREMENT,
    record_label_id INT NOT NULL,
    label MEDIUMTEXT NOT NULL,
    duration INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(track_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE album_track_listing
(
    album_id INT NOT NULL,
    track_id INT NOT NULL,
    `order` INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(album_id, track_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE track_unit_price
(
    track_id INT NOT NULL,
    currency_id INT NOT NULL,
    amount INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(track_id, currency_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE track_performer_rosta 
(
    track_id INT NOT NULL,
    performer_id INT NOT NULL,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(track_id, performer_id) 
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE award_body
(
    award_body_id INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(award_body_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE award_types
(
    award_type_id INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(award_type_id)

) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE awards
(
    award_id INT NOT NULL AUTO_INCREMENT,
    award_type_id INT NOT NULL,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(award_id) 
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE awards_listing
(
    award_listing_id INT NOT NULL AUTO_INCREMENT,
    award_body_id INT NOT NULL,
    award_id INT NOT NULL,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(award_listing_id),
    INDEX idx_award_body_id (award_body_id),
    INDEX idx_award_id (award_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE award_listing_performer_rosta
(
    award_listing_id INT NOT NULL,
    performer_id INT NOT NULL,
    label VARCHAR(64) NOT NULL,
    nominated_date DATE NOT NULL,
    winner TINYINT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(award_listing_id, performer_id, nominated_date),
    INDEX idx_performer_id (performer_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE orders
(
    order_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    amount INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT NOT NULL,
    PRIMARY KEY(order_id),
    INDEX idx_user_id (user_id),
    INDEX idx_address_id (address_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE order_status
(
    order_status_id INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT,
    PRIMARY KEY(order_status_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE order_history
(
    order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT,
    PRIMARY KEY(order_id, order_status_id),
    INDEX idx_order_id (order_id),
    INDEX idx_order_status_id (order_status_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE item_types
(
    item_type_id INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(64) NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT,
    PRIMARY KEY(item_type_id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE order_items
(
    order_id INT NOT NULL,
    item_type_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INT NOT NULL,
    modified_at DATETIME NULL,
    modified_user_id INT NULL,
    is_active TINYINT,
    PRIMARY KEY(order_id, item_type_id, item_id),
    INDEX idx_order_id (order_id)
);




















































