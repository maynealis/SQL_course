USE Biblioteca;

INSERT INTO Socios(socio_DNI_PK, socio_Name, socio_Apellido1, socio_Apellido2, socio_dir, socio_tel, socio_fecha_entrada)
VALUES
('12345678A', 'Carlos', 'Pérez', 'González', 'Calle Mayor 123', 654321987, '2020-05-12'),
('87654321B', 'Ana', 'López', 'Martínez', 'Avenida Sol 456', 612345678, '2019-10-23'),
('13579246C', 'Luis', 'Gómez', NULL, 'Calle Luna 789', 678912345, '2021-03-15'),
('24681357D', 'María', 'Rodríguez', 'Sánchez', 'Calle Estrella 321', 689123456, '2022-07-07');

INSERT INTO Libros(lib_title, lib_author, lib_fecha_edicion)
VALUES
('Orlando', 'Virginia Woolf', '1928-10-11'),
('El color púrpura', 'Alice Walker', '1982-10-01'),
('Los juegos del hambre: Sinsajo', 'Suzanne Collins', '2010-08-24'),
('Los Miserables', 'Victor Hugo', '1862-04-03');

INSERT INTO Prestamos(fecha_prestamo, fecha_devolucion, socioID_FK, libroID_FK)
VALUES
('2024-10-10', '2024-10-30', '24681357D', 5),
('2024-10-15', NULL, '24681357D', 8);