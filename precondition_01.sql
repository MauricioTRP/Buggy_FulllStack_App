-- ===========================================
-- PRECONDITION SETUP: Reset Database
-- ===========================================

-- Clear all existing data
DELETE FROM audit_logs;
DELETE FROM user_profiles;
DELETE FROM users;

-- Reset auto-increment counters
DELETE FROM sqlite_sequence WHERE name IN ('users', 'user_profiles', 'audit_logs');

-- Vacuum database to reclaim space and reset internal counters
VACUUM;

-- ===========================================
-- Now you can run your dummy data inserts
-- ===========================================

-- Insert users for 31 minutos characters
INSERT INTO users (username, email, status) VALUES
('tulio_trivino', 'tulio.trivino@31minutos.cl', 'active'),
('juan_carlos_bodoque', 'juan.carlos@31minutos.cl', 'active'),
('juanin_juan_harry', 'juanin@31minutos.cl', 'active'),
('mario_hugo', 'mario.hugo@31minutos.cl', 'active'),
('guillermina', 'guillermina@31minutos.cl', 'active'),
('calcetin_con_rombos_man', 'calcetin@31minutos.cl', 'active'),
('patana_tufillo', 'patana@31minutos.cl', 'active'),
('mico_mico', 'mico@31minutos.cl', 'active'),
('bodoque_sr', 'bodoque.sr@31minutos.cl', 'active'),
('dona_concha', 'dona.concha@31minutos.cl', 'active'),
('profesor_rossa', 'prof.rossa@31minutos.cl', 'active'),
('policia_checho', 'checho@31minutos.cl', 'active'),
('don_paraguayo', 'don.paraguayo@31minutos.cl', 'active'),
('mama_rosa', 'mama.rosa@31minutos.cl', 'active'),
('papa_tulio', 'papa.tulio@31minutos.cl', 'active'),
('hermano_mayor', 'hermano.mayor@31minutos.cl', 'active'),
('hermano_menor', 'hermano.menor@31minutos.cl', 'active'),
('tia_cotota', 'tia.cotota@31minutos.cl', 'active'),
('tio_pepe', 'tio.pepe@31minutos.cl', 'active'),
('vecina_chismosa', 'vecina@31minutos.cl', 'active'),
('panadero_ramon', 'panadero@31minutos.cl', 'active'),
('carnicero_oscar', 'carnicero@31minutos.cl', 'active'),
('verdulero_raul', 'verdulero@31minutos.cl', 'active'),
('pescadero_ernesto', 'pescadero@31minutos.cl', 'active'),
('lechero_alfredo', 'lechero@31minutos.cl', 'active'),
('cartero_jorge', 'cartero@31minutos.cl', 'active'),
('bombero_roberto', 'bombero@31minutos.cl', 'active'),
('doctor_garcia', 'doctor@31minutos.cl', 'active'),
('enfermera_maria', 'enfermera@31minutos.cl', 'active'),
('dentista_lopez', 'dentista@31minutos.cl', 'active'),
('veterinario_carlos', 'veterinario@31minutos.cl', 'active'),
('peluquero_antonio', 'peluquero@31minutos.cl', 'active'),
('mecanico_pedro', 'mecanico@31minutos.cl', 'active'),
('electricista_luis', 'electricista@31minutos.cl', 'active'),
('plomero_ricardo', 'plomero@31minutos.cl', 'active'),
('pintor_manuel', 'pintor@31minutos.cl', 'active'),
('jardinero_felipe', 'jardinero@31minutos.cl', 'active');

-- Insert user profiles for 31 minutos characters
INSERT INTO user_profiles (user_id, first_name, last_name, phone_number, address) VALUES
(1, 'Tulio', 'Triviño', '+56 9 1234 5678', 'Calle Pelotillehue 123, Pelotillehue'),
(2, 'Juan Carlos', 'Bodoque', '+56 9 2345 6789', 'Avenida de los Animales 456, Pelotillehue'),
(3, 'Juanín Juan Harry', 'Baldeón', '+56 9 3456 7890', 'Callejón de los Niños 789, Pelotillehue'),
(4, 'Mario Hugo', 'Mario Hugo', '+56 9 4567 8901', 'Plaza Central 321, Pelotillehue'),
(5, 'Guillermina', 'Guillermina', '+56 9 5678 9012', 'Calle de las Flores 654, Pelotillehue'),
(6, 'Calcetín con Rombos', 'Man', '+56 9 6789 0123', 'Calle de los Calcetines 987, Pelotillehue'),
(7, 'Patana', 'Tufillo', '+56 9 7890 1234', 'Calle de los Olores 147, Pelotillehue'),
(8, 'Mico', 'Mico', '+56 9 8901 2345', 'Árbol de la Plaza 258, Pelotillehue'),
(9, 'Bodoque', 'Sr.', '+56 9 9012 3456', 'Casa de los Bodoque 369, Pelotillehue'),
(10, 'Doña', 'Concha', '+56 9 0123 4567', 'Calle de las Señoras 741, Pelotillehue'),
(11, 'Profesor', 'Rossa', '+56 9 1111 2222', 'Escuela de Pelotillehue 852, Pelotillehue'),
(12, 'Policía', 'Checho', '+56 9 2222 3333', 'Comisaría de Pelotillehue 963, Pelotillehue'),
(13, 'Don', 'Paraguayo', '+56 9 3333 4444', 'Tienda Paraguaya 159, Pelotillehue'),
(14, 'Mamá', 'Rosa', '+56 9 4444 5555', 'Casa de la Familia Triviño 753, Pelotillehue'),
(15, 'Papá', 'Triviño', '+56 9 5555 6666', 'Casa de la Familia Triviño 753, Pelotillehue'),
(16, 'Hermano', 'Mayor', '+56 9 6666 7777', 'Casa de la Familia Triviño 753, Pelotillehue'),
(17, 'Hermano', 'Menor', '+56 9 7777 8888', 'Casa de la Familia Triviño 753, Pelotillehue'),
(18, 'Tía', 'Cotota', '+56 9 8888 9999', 'Calle de las Tías 951, Pelotillehue'),
(19, 'Tío', 'Pepe', '+56 9 9999 0000', 'Calle de los Tíos 357, Pelotillehue'),
(20, 'Vecina', 'Chismosa', '+56 9 0000 1111', 'Calle de los Vecinos 159, Pelotillehue'),
(21, 'Ramón', 'Panadero', '+56 9 1111 0000', 'Panadería Central 753, Pelotillehue'),
(22, 'Oscar', 'Carnicero', '+56 9 2222 1111', 'Carnicería del Pueblo 951, Pelotillehue'),
(23, 'Raúl', 'Verdulero', '+56 9 3333 2222', 'Verdulería Fresca 357, Pelotillehue'),
(24, 'Ernesto', 'Pescadero', '+56 9 4444 3333', 'Pescadería del Mar 159, Pelotillehue'),
(25, 'Alfredo', 'Lechero', '+56 9 5555 4444', 'Lechera del Valle 753, Pelotillehue'),
(26, 'Jorge', 'Cartero', '+56 9 6666 5555', 'Oficina de Correos 951, Pelotillehue'),
(27, 'Roberto', 'Bombero', '+56 9 7777 6666', 'Bomberos de Pelotillehue 357, Pelotillehue'),
(28, 'Dr. García', 'Médico', '+56 9 8888 7777', 'Consultorio Médico 159, Pelotillehue'),
(29, 'María', 'Enfermera', '+56 9 9999 8888', 'Consultorio Médico 159, Pelotillehue'),
(30, 'Dr. López', 'Dentista', '+56 9 0000 9999', 'Clínica Dental 753, Pelotillehue'),
(31, 'Dr. Carlos', 'Veterinario', '+56 9 1111 0000', 'Clínica Veterinaria 951, Pelotillehue'),
(32, 'Antonio', 'Peluquero', '+56 9 2222 1111', 'Peluquería Elegante 357, Pelotillehue'),
(33, 'Pedro', 'Mecánico', '+56 9 3333 2222', 'Taller Mecánico 159, Pelotillehue'),
(34, 'Luis', 'Electricista', '+56 9 4444 3333', 'Servicios Eléctricos 753, Pelotillehue'),
(35, 'Ricardo', 'Plomero', '+56 9 5555 4444', 'Servicios de Plomería 951, Pelotillehue'),
(36, 'Manuel', 'Pintor', '+56 9 6666 5555', 'Pinturas y Decoraciones 357, Pelotillehue'),
(37, 'Felipe', 'Jardinero', '+56 9 7777 6666', 'Jardines y Paisajismo 159, Pelotillehue');

-- Insert some sample audit logs
INSERT INTO audit_logs (user_id, action, changed_field, old_value, new_value) VALUES
(1, 'CREATE', 'user', NULL, 'tulio_trivino'),
(2, 'CREATE', 'user', NULL, 'juan_carlos_bodoque'),
(3, 'CREATE', 'user', NULL, 'juanin_juan_harry'),
(1, 'UPDATE', 'status', 'inactive', 'active'),
(2, 'UPDATE', 'email', 'juan.carlos@old.cl', 'juan.carlos@31minutos.cl'),
(4, 'CREATE', 'user', NULL, 'mario_hugo'),
(5, 'CREATE', 'user', NULL, 'guillermina'),
(6, 'CREATE', 'user', NULL, 'calcetin_con_rombos_man'),
(7, 'CREATE', 'user', NULL, 'patana_tufillo'),
(8, 'CREATE', 'user', NULL, 'mico_mico'),
(9, 'CREATE', 'user', NULL, 'bodoque_sr'),
(10, 'CREATE', 'user', NULL, 'dona_concha'),
(11, 'CREATE', 'user', NULL, 'profesor_rossa'),
(12, 'CREATE', 'user', NULL, 'policia_checho'),
(13, 'CREATE', 'user', NULL, 'don_paraguayo'),
(14, 'CREATE', 'user', NULL, 'mama_rosa'),
(15, 'CREATE', 'user', NULL, 'papa_tulio'),
(16, 'CREATE', 'user', NULL, 'hermano_mayor'),
(17, 'CREATE', 'user', NULL, 'hermano_menor'),
(18, 'CREATE', 'user', NULL, 'tia_cotota'),
(19, 'CREATE', 'user', NULL, 'tio_pepe'),
(20, 'CREATE', 'user', NULL, 'vecina_chismosa'),
(21, 'CREATE', 'user', NULL, 'panadero_ramon'),
(22, 'CREATE', 'user', NULL, 'carnicero_oscar'),
(23, 'CREATE', 'user', NULL, 'verdulero_raul'),
(24, 'CREATE', 'user', NULL, 'pescadero_ernesto'),
(25, 'CREATE', 'user', NULL, 'lechero_alfredo'),
(26, 'CREATE', 'user', NULL, 'cartero_jorge'),
(27, 'CREATE', 'user', NULL, 'bombero_roberto'),
(28, 'CREATE', 'user', NULL, 'doctor_garcia'),
(29, 'CREATE', 'user', NULL, 'enfermera_maria'),
(30, 'CREATE', 'user', NULL, 'dentista_lopez'),
(31, 'CREATE', 'user', NULL, 'veterinario_carlos'),
(32, 'CREATE', 'user', NULL, 'peluquero_antonio'),
(33, 'CREATE', 'user', NULL, 'mecanico_pedro'),
(34, 'CREATE', 'user', NULL, 'electricista_luis'),
(35, 'CREATE', 'user', NULL, 'plomero_ricardo'),
(36, 'CREATE', 'user', NULL, 'pintor_manuel'),
(37, 'CREATE', 'user', NULL, 'jardinero_felipe');