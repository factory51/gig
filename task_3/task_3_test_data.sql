use sound_sync;

INSERT INTO users (username, created_at, created_user_id, `status`) VALUES
('SYSTEM_ADMIN', NOW(), 1, 1),
('superadmin1', NOW(), 1, 1),
('superadmin2', NOW(), 1, 1),
('Admin1', NOW(), 1, 1),
('admin2', NOW(), 1, 1),
('admin3', NOW(), 1, 1),
('user7', NOW(), 1, 1),
('user8', NOW(), 1, 1),
('user9', NOW(), 1, 1),
('user10', NOW(), 1, 1);

INSERT INTO user_passwords (user_id, `password`, salt, created_at, is_active) VALUES
(1, UUID(), "SALT", NOW(), 1),
(2, UUID(), "SALT", NOW(), 1),
(3, UUID(), "SALT", NOW(), 1),
(4, UUID(), "SALT", NOW(), 1),
(5, UUID(), "SALT", NOW(), 1),
(6, UUID(), "SALT", NOW(), 1),
(7, UUID(), "SALT", NOW(), 1),
(8, UUID(), "SALT", NOW(), 1),
(9, UUID(), "SALT", NOW(), 1),
(10, UUID(), "SALT", NOW(), 1);

INSERT INTO user_passwords (user_id, `password`, salt, created_at, is_active) VALUES
(11, UUID(), "SALT", DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(12, UUID(), "SALT", DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(13, UUID(), "SALT", DATE_SUB(NOW(), INTERVAL 10 DAY), 0);

INSERT INTO user_types VALUES(NULL, 'SYSTEM APPLICATION', 'L_SYSTEM_APPLICATION', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_types VALUES(NULL, 'SYSTEM SUPER ADMIN', 'L_SYSTEM_SUPER_ADMIN', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_types VALUES(NULL, 'SYSTEM ADMIN', 'L_SYSTEM_ADMIN', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_types VALUES(NULL, 'AUTHENTICATED WEB USER', 'L_AUTH_WEB_USER', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_types VALUES(NULL, 'UNAUTHENTICATED WEB USER', 'L_UNAUTH_WEB_USER', NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_lookup VALUES(1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(2,2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(3,2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(4,3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(5,3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(6,3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(7,4, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(8,4, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(9,4, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_lookup VALUES(10,4, NOW(), 1, NULL, NULL, 1);

INSERT INTO application_actions VALUES(NULL, 'GET', 'Read Data Access - HTTP GET', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_actions VALUES(NULL, 'CREATE', 'Write Access - HTTP POST', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_actions VALUES(NULL, 'UPDATE', 'Write Access - HTTP PUT', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_actions VALUES(NULL, 'DELETE', 'Write Access - HTTP DELETE', NOW(), 1, NULL, NULL, 1);

INSERT INTO application_endpoints VALUES(NULL, 'Home Page', '/', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Web Registration Page', '/signup', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Web Orders', '/orders', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Web View Band details', '/view/bands', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Web View Performer details', '/view/performers', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Web View Achievements details', '/view/achievements', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Admin Home Page', '/admin/', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Admin Settings', '/admin/settings', NOW(), 1, NULL, NULL, 1);
INSERT INTO application_endpoints VALUES(NULL, 'Admin User Management', '/admin/users/management', NOW(), 1, NULL, NULL, 1);

-- SYSTEM PERMISSIONS
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 2, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 3, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 4, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 5, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 6, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 7, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 8, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 8, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 8, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 8, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 9, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 4, NOW(), 1, NULL, NULL, 1);

-- SUPER ADMIN PERMISSION
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 2, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 2, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 3, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 3, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 4, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 4, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 5, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 5, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 6, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 6, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 7, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 7, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(1, 9, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(1, 9, 4, NOW(), 1, NULL, NULL, 1);

-- ADMIN PERMISSIONS

INSERT INTO user_type_endpoint_actions VALUES(3, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 2, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 2, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 2, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 3, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 3, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 3, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 3, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 4, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 4, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 4, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 4, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 5, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 5, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 5, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 5, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 6, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 6, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 6, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 6, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 7, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 7, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 7, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 7, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 8, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 8, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 8, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 8, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(3, 9, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 9, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 9, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(3, 9, 4, NOW(), 1, NULL, NULL, 1);

-- AUTH WEB USER
INSERT INTO user_type_endpoint_actions VALUES(4, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(4, 2, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 2, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 2, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(4, 3, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 3, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 3, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 3, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(4, 4, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 4, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 4, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 4, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(4, 5, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 5, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 5, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 5, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(4, 6, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 6, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 6, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(4, 6, 4, NOW(), 1, NULL, NULL, 1);

-- UNAUTH WEB USER

INSERT INTO user_type_endpoint_actions VALUES(5, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_type_endpoint_actions VALUES(5, 2, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 2, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_type_endpoint_actions VALUES(5, 2, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO countries VALUES(NULL, 'United Kingdom', 'L_COUNTRY_UK', 'gb', 'gbb', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Malta', 'L_COUNTRY_MALTA', 'mt', 'mtv', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Denmark', 'L_COUNTRY_DENMARK', 'dk', 'dkk', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Sweden', 'L_COUNTRY_SWEDEN', 'sv', 'svr', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Norwary', 'L_COUNTRY_NORWAY', 'no', 'nok', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Finland', 'L_COUNTRY_Finland', 'fi', 'fii', NOW(), 1, NULL, NULL, 1);
INSERT INTO countries VALUES(NULL, 'Spain', 'L_COUNTRY_SPAIN', 'es', 'ess', NOW(), 1, NULL, NULL, 1);


INSERT INTO addresses VALUES(NULL, 'Head Office', '123 Street Road', 'Bolton', NULL, 'Lancashire', 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO addresses VALUES(NULL, 'Malta Office', '123 Street Road', 'Sliema', NULL, 'Sliema', 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO addresses VALUES(NULL, 'Random Address', '123 Street Road', 'Copenhagen', NULL, 'Copenhagen', 3, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_addresses VALUES(1, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(1,2,0, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(2,1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(2,2,0, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(3,1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(3,2,0, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(4,1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(4,2,0, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(5,1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(5,2,0, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(6,1,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(6,2,0, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_addresses VALUES(8,3,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(9,3,1, NOW(), 1, NULL, NULL, 1);
INSERT INTO user_addresses VALUES(10,3,1, NOW(), 1, NULL, NULL, 1);


INSERT INTO input_schemas VALUES(NULL, 'Web User Details', NOW(), 1, NULL, NULL, 1);
INSERT INTO input_schemas VALUES(NULL, 'System User Details', NOW(), 1, NULL, NULL, 1);
INSERT INTO input_schemas VALUES(NULL, 'Performer User Details', NOW(), 1, NULL, NULL, 1);
INSERT INTO input_schemas VALUES(NULL, 'Band Details', NOW(), 1, NULL, NULL, 1);

INSERT INTO schema_fields VALUES(1, 'key1', 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(1, 'key2', 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(1, 'key3', 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(1, 'key4', 0, 4, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(1, 'key5', 0, 5, NOW(), 1, NULL, NULL, 1);

INSERT INTO schema_fields VALUES(2, 'key1', 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(2, 'key2', 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(2, 'key3', 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(2, 'key4', 0, 4, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(2, 'key5', 0, 5, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(2, 'key6', 1, 6, NOW(), 1, NULL, NULL, 1);

INSERT INTO schema_fields VALUES(3, 'first_name', 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(3, 'last_name', 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(3, 'age', 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(3, 'from', 1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO schema_fields VALUES(4, 'band_name', 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'founded_date', 1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'founded_location', 1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'main_genre', 1, 4, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'based', 1, 5, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'bio', 1, 6, NOW(), 1, NULL, NULL, 1);
INSERT INTO schema_fields VALUES(4, 'website', 1, 7, NOW(), 1, NULL, NULL, 1);

INSERT INTO user_details VALUES(8, 1, 'key1', 'val1', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(8, 1, 'key2', 'val2', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(8, 1, 'key3', 'val3', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(8, 1, 'key4', 'val4', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(8, 1, 'key5', 'val5', NOW(), 1, NULL, NULL, 1);

INSERT INTO user_details VALUES(9, 1, 'key1', 'val1', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(9, 1, 'key2', 'val2', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(9, 1, 'key3', 'val3', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(9, 1, 'key4', 'val4', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(9, 1, 'key5', 'val5', NOW(), 1, NULL, NULL, 1);

INSERT INTO user_details VALUES(10, 1, 'key1', 'val1', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(10, 1, 'key2', 'val2', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(10, 1, 'key3', 'val3', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(10, 1, 'key4', 'val4', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(10, 1, 'key5', 'val5', NOW(), 1, NULL, NULL, 1);


INSERT INTO user_details VALUES(2, 2, 'key1', 'val1', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(2, 2, 'key2', 'val2', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(2, 2, 'key3', 'val3', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(2, 2, 'key4', 'val4', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(2, 2, 'key5', 'val5', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(2, 2, 'key6', 'val6', NOW(), 1, NULL, NULL, 1);

INSERT INTO user_details VALUES(3, 2, 'key1', 'val1', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(3, 2, 'key2', 'val2', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(3, 2, 'key3', 'val3', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(3, 2, 'key4', 'val4', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(3, 2, 'key5', 'val5', NOW(), 1, NULL, NULL, 1);
INSERT INTO user_details VALUES(3, 2, 'key6', 'val6', NOW(), 1, NULL, NULL, 1);

INSERT INTO user_details_log VALUES(8, 1, 'key1', 'Nobody', 'Somebody', NOW(), 1);
INSERT INTO user_details_log VALUES(8, 1, 'key1', 'Somebody', 'Replaced', NOW(), 1);
INSERT INTO user_details_log VALUES(8, 1, 'key2', 'Ok go', 'Ok then', NOW(), 1);

INSERT INTO user_details_log VALUES(9, 1, 'key2', 'typo', 'fixed', NOW(), 1);

INSERT INTO performers VALUES(NULL, 'Lars Ulrich', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'James Hetfield', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Robert Trujillo', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Kurt Hammet', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Cliff Burton', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Dave Mustaine', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Jason Newsted', NOW(), 1, NULL, NULL, 1) ; 

INSERT INTO performers VALUES(NULL, 'Josh Homme', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'John Garcia', NOW(), 1, NULL, NULL, 1) ; 
INSERT INTO performers VALUES(NULL, 'Nick Oliveri', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Brant Bjork', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Scott Reeder', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Alfredo Hernández', NOW(), 1, NULL, NULL, 1) ;

INSERT INTO performers VALUES(NULL, 'Dave Grohl', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Mark Lanegan', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Michael Shuman', NOW(), 1, NULL, NULL, 1) ;
INSERT INTO performers VALUES(NULL, 'Troy Van Leeuwen', NOW(), 1, NULL, NULL, 1) ;

INSERT INTO performers VALUES(NULL, 'Anna Nalik', NOW(), 1, NULL, NULL, 1) ;

INSERT INTO performer_details VALUES(1, 3, 'first_name', 'Lars', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(1, 3, 'last_name', 'Ulrich', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(1, 3, 'age', '59', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(1, 3, 'from', 'Hellerup', NOW(), 1, NULL, NULL, 1);


INSERT INTO performer_details VALUES(2, 3, 'first_name', 'James', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(2, 3, 'last_name', 'Hetfield', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(2, 3, 'age', '59', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(2, 3, 'from', 'California', NOW(), 1, NULL, NULL, 1);

INSERT INTO performer_details VALUES(3, 3, 'first_name', 'Robert', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(3, 3, 'last_name', 'Trujillo', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(3, 3, 'age', '45', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(3, 3, 'from', 'California', NOW(), 1, NULL, NULL, 1);


INSERT INTO performer_details VALUES(4, 3, 'first_name', 'Kurt', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(4, 3, 'last_name', 'Hammet', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(4, 3, 'age', '56', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(4, 3, 'from', 'New York', NOW(), 1, NULL, NULL, 1);


INSERT INTO performer_details VALUES(8, 3, 'first_name', 'Josh', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(8, 3, 'last_name', 'Homme', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(8, 3, 'age', '50', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(8, 3, 'from', 'The Desert', NOW(), 1, NULL, NULL, 1);


INSERT INTO performer_details VALUES(14, 3, 'first_name', 'Dave', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(14, 3, 'last_name', 'Grohl', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(14, 3, 'age', '50', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(14, 3, 'from', 'Ohio', NOW(), 1, NULL, NULL, 1);


INSERT INTO performer_details VALUES(18, 3, 'first_name', 'Anna', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(18, 3, 'last_name', 'Nalik', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(18, 3, 'age', '38', NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_details VALUES(18, 3, 'from', 'California', NOW(), 1, NULL, NULL, 1);


INSERT INTO bands VALUES(NULL, 'Metallica', NOW(), 1, NULL, NULL, 1);
INSERT INTO bands VALUES(NULL, 'Kyuss', NOW(), 1, NULL, NULL, 1);
INSERT INTO bands VALUES(NULL, 'Queens of the Stone Age', NOW(), 1, NULL, NULL, 1);

INSERT INTO band_details VALUES(1, 4, 'band_name', 'Metallica', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'founded_date', '1980-07-02', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'founded_location', 'Burbank, California', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'main_genre', 'Heavy Metal', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'based', 'Burbank, California', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'bio', 'Metallica founded the Heavy Metal Genre, and lost out to the first every grammy in the category to Jethro Tull', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(1, 4, 'website', 'http://www.metallica.com', NOW(), 1, NULL, NULL, 1);

INSERT INTO band_details VALUES(2, 4, 'band_name', 'Kyuss', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'founded_date', '1987-03-01', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'founded_location', 'Somewhere in the Arid Desert', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'main_genre', 'Heavy Metal', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'based', 'Somewhere in the Arid Desert', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'bio', 'Kyuss where the precursor to Queens of the Stone Age, musically more sophisticated, but no one knows who they are.', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(2, 4, 'website', 'http://www.kyuss.com', NOW(), 1, NULL, NULL, 1);

INSERT INTO band_details VALUES(3, 4, 'band_name', 'Queens of the Stone Age', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'founded_date', '1997-05-23', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'founded_location', 'Probably California', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'main_genre', 'Heavy Metal', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'based', 'Probably California', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'bio', 'A more commerical version of Kyuss', NOW(), 1, NULL, NULL, 1);
INSERT INTO band_details VALUES(3, 4, 'website', 'http://www.qotsa.com', NOW(), 1, NULL, NULL, 1);


INSERT INTO album_types VALUES(NULL, 'Band Album', NOW(), 1, NULL, NULL, 1);
INSERT INTO album_types VALUES(NULL, 'Solo Artist Album', NOW(), 1, NULL, NULL, 1);
INSERT INTO album_types VALUES(NULL, 'Compilation Album', NOW(), 1, NULL, NULL, 1);


INSERT INTO record_labels VALUES(NULL, 3, 'United Artists', NOW(), 1, NULL, NULL, 1);
INSERT INTO record_labels VALUES(NULL, 3, 'Geffen', NOW(), 1, NULL, NULL, 1);
INSERT INTO record_labels VALUES(NULL, 3, 'RCA', NOW(), 1, NULL, NULL, 1);
INSERT INTO record_labels VALUES(NULL, 3, 'Hospital Records', NOW(), 1, NULL, NULL, 1);
INSERT INTO record_labels VALUES(NULL, 3, 'Factory Records', NOW(), 1, NULL, NULL, 1);

INSERT INTO albums VALUES(NULL, 1, 3, 'Kill Em All', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 3, 'Ride The Lightening', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 3, 'And Jusitice for All', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 3, 'Metallica', NOW(), 1, NULL, NULL, 1);

INSERT INTO albums VALUES(NULL, 1, 1, 'Welcome to Sky Valley', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 1, 'Blues for the Red Sun', NOW(), 1, NULL, NULL, 1);

INSERT INTO albums VALUES(NULL, 1, 4, 'Queens of the Stone Age', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 4, 'Rated R', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 4, 'Songs for the Deaf', NOW(), 1, NULL, NULL, 1);

INSERT INTO albums VALUES(NULL, 1, 2, 'Wreck of the Day', NOW(), 1, NULL, NULL, 1);
INSERT INTO albums VALUES(NULL, 1, 2, 'Broken Dolls & Odds & Ends', NOW(), 1, NULL, NULL, 1);




INSERT INTO band_albums VALUES(1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(1, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(1, 3, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(1, 4, NOW(), 1, NULL, NULL, 1);

INSERT INTO band_albums VALUES(2, 5, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(2, 6, NOW(), 1, NULL, NULL, 1);

INSERT INTO band_albums VALUES(3, 7, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(3, 8, NOW(), 1, NULL, NULL, 1);
INSERT INTO band_albums VALUES(3, 9, NOW(), 1, NULL, NULL, 1);

INSERT INTO performer_albums VALUES(18, 10, NOW(), 1, NULL, NULL, 1);
INSERT INTO performer_albums VALUES(18, 11, NOW(), 1, NULL, NULL, 1);

INSERT INTO currencies VALUES(NULL, 'Sterling (£)', NOW(), 1, NULL, NULL, 1);
INSERT INTO currencies VALUES(NULL, 'US Dollars ($)', NOW(), 1, NULL, NULL, 1);

INSERT INTO album_unit_price VALUES(1, 1, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(2, 1, 1299, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(3, 1, 1199, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(4, 1, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(5, 1, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(6, 1, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(7, 1, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(8, 1, 799, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(9, 1, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(10, 1, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(11, 1, 1999, NOW(), 1, NULL, NULL, 1);


INSERT INTO album_unit_price VALUES(1, 2, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(2, 2, 1299, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(3, 2, 1199, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(4, 2, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(5, 2, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(6, 2, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(7, 2, 1999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(8, 2, 799, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(9, 2, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(10, 2, 999, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_unit_price VALUES(11, 2, 1999, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 3, 'Hit the Lights', 257, NOW(), 1, NULL, NULL, 1);
INSERT INTO tracks VALUES(NULL, 3, 'The Four Horsemen', 433, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 3, 'Creeping Death', 257, NOW(), 1, NULL, NULL, 1);
INSERT INTO tracks VALUES(NULL, 3, 'Fade to Black', 433, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 3, 'Eye of the Beholder', 257, NOW(), 1, NULL, NULL, 1);
INSERT INTO tracks VALUES(NULL, 3, 'One', 433, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 3, 'Enter Sandman', 433, NOW(), 1, NULL, NULL, 1);
INSERT INTO tracks VALUES(NULL, 3, 'Dont tread on me', 433, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 1, 'Asteroid', 433, NOW(), 1, NULL, NULL, 1);
INSERT INTO tracks VALUES(NULL, 1, 'Demon Cleaner', 433, NOW(), 1, NULL, NULL, 1);


INSERT INTO tracks VALUES(NULL, 4, 'Feel Good Hit of the Summer', 433, NOW(), 1, NULL, NULL, 1);

INSERT INTO tracks VALUES(NULL, 2, '2am (Breathe)', 145, NOW(), 1, NULL, NULL, 1);


INSERT INTO album_track_listing VALUES(1, 1, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(1, 2, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(2, 3, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(2, 4, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(3, 5, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(3, 6, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(4, 7, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(4, 8, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(5, 9, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(5, 10, 2, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(8, 11, 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO album_track_listing VALUES(10, 12, 1, NOW(), 1, NULL, NULL, 1);


INSERT INTO track_unit_price VALUES(1, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(2, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(3, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(4, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(5, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(6, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(7, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(8, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(9, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(10, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(11, 1, 299, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(12, 1, 299, NOW(), 1, NULL, NULL, 1);


INSERT INTO track_unit_price VALUES(1, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(2, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(3, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(4, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(5, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(6, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(7, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(8, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(9, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(10, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(11, 2, 249, NOW(), 1, NULL, NULL, 1);
INSERT INTO track_unit_price VALUES(12, 2, 249, NOW(), 1, NULL, NULL, 1);



INSERT INTO track_performer_rosta VALUES(1, 1, 'Lars Ulrich', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(1, 2, 'James Hetfield', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(1, 5, 'Cliff Burton', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(1, 6, 'Dave Mustaine', NOW(), 1, NULL, NULL, 1);

INSERT INTO track_performer_rosta VALUES(2, 1, 'Lars Ulrich', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(2, 2, 'James Hetfield', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(2, 5, 'Cliff Burton', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(2, 6, 'Dave Mustaine', NOW(), 1, NULL, NULL, 1);

INSERT INTO track_performer_rosta VALUES(3, 1, 'Lars Ulrich', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(3, 2, 'James Hetfield', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(3, 7, 'Jason Newsted', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(3, 4, 'Kurt Hammet', NOW(), 1, NULL, NULL, 1);

INSERT INTO track_performer_rosta VALUES(9, 8, 'Josh Homme', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(9, 9, 'John Garcia', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(9, 10, 'Nick Oliveri', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(9, 11, 'Brant Bjork', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(9, 12, 'Scott Reader', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(9, 13, 'Alferdo Hernández', NOW(), 1, NULL, NULL, 1);

INSERT INTO track_performer_rosta VALUES(10, 8, 'Josh Homme', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(10, 9, 'John Garcia', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(10, 10, 'Nick Oliveri', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(10, 11, 'Brant Bjork', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(10, 12, 'Scott Reader', NOW(), 1, NULL, NULL, 1);
INSERT INTO track_performer_rosta VALUES(10, 13, 'Alferdo Hernández', NOW(), 1, NULL, NULL, 1);

INSERT INTO track_performer_rosta VALUES(12, 18, 'Anna Nalik', NOW(), 1, NULL, NULL, 1);

INSERT INTO award_body VALUES(NULL, 'Grammys', NOW(), 1, NULL, NULL, 1);
INSERT INTO award_body VALUES(NULL, 'Brit Awards', NOW(), 1, NULL, NULL, 1);
INSERT INTO award_body VALUES(NULL, 'Tony Awards', NOW(), 1, NULL, NULL, 1);
INSERT INTO award_body VALUES(NULL, 'MTV Awards', NOW(), 1, NULL, NULL, 1);


INSERT INTO award_types VALUES(NULL, 'Group Award', NOW(), 1, NULL, NULL, 1);
INSERT INTO award_types VALUES(NULL, 'Individual Award', NOW(), 1, NULL, NULL, 1);

INSERT INTO awards VALUES(NULL, 1, 'Best New Comers', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards VALUES(NULL, 2, 'Best New Comer', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards VALUES(NULL, 1, 'Best Album', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards VALUES(NULL, 2, 'Best Album by a Female Solo Artist', NOW(), 1, NULL, NULL, 1);

INSERT INTO awards_listing VALUES(NULL, 1, 1, 'Best New Commer - Grammy', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards_listing VALUES(NULL, 1, 2, 'Best New Commer - Grammy', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards_listing VALUES(NULL, 1, 3, 'Best Album - Grammy', NOW(), 1, NULL, NULL, 1);
INSERT INTO awards_listing VALUES(NULL, 1, 4, 'Best Female Album - Grammy', NOW(), 1, NULL, NULL, 1);

INSERT INTO award_listing_performer_rosta VALUES(1, 1, 'Lars Ulrich', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(1, 2, 'James Hetfield', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(1, 5, 'Cliff Burton', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(1, 6, 'Dave Mustaine', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);

INSERT INTO award_listing_performer_rosta VALUES(2, 12, 'Anna Nalik', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);

INSERT INTO award_listing_performer_rosta VALUES(3, 1, 'Lars Ulrich', DATE(NOW()), 0, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(3, 2, 'James Hetfield', DATE(NOW()), 0, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(3, 5, 'Cliff Burton', DATE(NOW()), 0, NOW(), 1, NULL, NULL, 1);
INSERT INTO award_listing_performer_rosta VALUES(3, 6, 'Dave Mustaine', DATE(NOW()), 0, NOW(), 1, NULL, NULL, 1);

INSERT INTO award_listing_performer_rosta VALUES(4, 12, 'Anna Nalik', DATE(NOW()), 1, NOW(), 1, NULL, NULL, 1);

INSERT INTO orders VALUES(NULL, 8, 3, 3499, NOW(), 8, NULL, NULL, 1);
INSERT INTO orders VALUES(NULL, 9, 3, 1999, NOW(), 8, NULL, NULL, 1);
INSERT INTO orders VALUES(NULL, 10, 3, 2134, NOW(), 8, NULL, NULL, 1);
INSERT INTO orders VALUES(NULL, 7, 3, 299, NOW(), 2, NOW(), 2, 1);
INSERT INTO orders VALUES(NULL, 8, 3, 999, NOW(), 8, NULL, NULL, 1);

INSERT INTO order_status VALUES(NULL, 'Order Processsing', NOW(), 1, NULL, NULL, 1);
INSERT INTO order_status VALUES(NULL, 'Order Payment Declined', NOW(), 1, NULL, NULL, 1);
INSERT INTO order_status VALUES(NULL, 'Order Dispatched', NOW(), 1, NULL, NULL, 1);
INSERT INTO order_status VALUES(NULL, 'Order Cancelled', NOW(), 1, NULL, NULL, 1);
INSERT INTO order_status VALUES(NULL, 'Order Complete', NOW(), 1, NULL, NULL, 1);

INSERT INTO order_history VALUES(1, 1, NOW(), 8, NULL, NULL, 1);
INSERT INTO order_history VALUES(1, 3, NOW(), 8, NULL, NULL, 1);
INSERT INTO order_history VALUES(1, 5, NOW(), 8, NULL, NULL, 1);

INSERT INTO order_history VALUES(2, 1, NOW(), 9, NULL, NULL, 1);
INSERT INTO order_history VALUES(2, 2, NOW(), 9, NULL, NULL, 1);
INSERT INTO order_history VALUES(2, 4, NOW(), 9, NULL, NULL, 1);

INSERT INTO order_history VALUES(3, 1, NOW(), 10, NULL, NULL, 1);
INSERT INTO order_history VALUES(3, 2, NOW(), 10, NULL, NULL, 1);
INSERT INTO order_history VALUES(3, 3, NOW(), 10, NULL, NULL, 1);

INSERT INTO order_history VALUES(4, 1, NOW(), 7, NULL, NULL, 1);
INSERT INTO order_history VALUES(4, 3, NOW(), 2, NULL, NULL, 1);
INSERT INTO order_history VALUES(4, 5, NOW(), 2, NULL, NULL, 1);

INSERT INTO order_history VALUES(5, 1, NOW(), 8, NULL, NULL, 1);
INSERT INTO order_history VALUES(5, 3, NOW(), 8, NULL, NULL, 1);
INSERT INTO order_history VALUES(5, 5, NOW(), 8, NULL, NULL, 1);

INSERT INTO item_types VALUES(NULL, 'Full Album', NOW(), 1, NULL, NULL, 1);
INSERT INTO item_types VALUES(NULL, 'Individual Track', NOW(), 1, NULL, NULL, 1);

INSERT INTO order_items VALUES(1, 1, 1, 2, NOW(), 8, NULL, NULL, 1);
INSERT INTO order_items VALUES(1, 1, 2, 1,  NOW(), 8, NULL, NULL, 1);
INSERT INTO order_items VALUES(1, 1, 3, 1,  NOW(), 8, NULL, NULL, 1);

INSERT INTO order_items VALUES(2, 1, 5, 1, NOW(), 9, NULL, NULL, 1);

INSERT INTO order_items VALUES(3, 1, 9, 1,  NOW(), 10, NULL, NULL, 1);
INSERT INTO order_items VALUES(3, 2, 1, 1, NOW(), 10, NULL, NULL, 1);
INSERT INTO order_items VALUES(3, 2, 11, 1, NOW(), 10, NULL, NULL, 1);
INSERT INTO order_items VALUES(3, 2, 9, 1, NOW(), 10, NULL, NULL, 1);

INSERT INTO order_items VALUES(4, 1, 12, 1, NOW(), 2, NULL, NULL, 1);

INSERT INTO order_items VALUES(5, 1, 5, 1, NOW(), 8, NULL, NULL, 1);









