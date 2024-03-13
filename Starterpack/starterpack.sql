INSERT INTO items (name, label) VALUES
  ('pack1', 'Pack Légal'),
  ('pack2', 'Pack Illégal')
;

ALTER TABLE `users` ADD COLUMN `getStarter` int(11) NOT NULL DEFAULT '0';
