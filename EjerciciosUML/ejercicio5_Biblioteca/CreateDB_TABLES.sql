CREATE DATABASE Biblioteca;

USE Biblioteca;
CREATE TABLE Libros
(
	lib_PK SMALLINT PRIMARY KEY IDENTITY(1,1),
	lib_fecha_edicion DATE NOT NULL,
	lib_title NVARCHAR(100) NOT NULL,
	lib_author nombre
);

CREATE TABLE Socios
(
	socio_DNI_PK VARCHAR(9) PRIMARY KEY 
		CHECK(socio_DNI_PK LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]' 
		OR socio_DNI_PK LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'),
	socio_Name nombre NOT NULL,
	socio_Apellido1 nombre NOT NULL,
	socio_Apellido2 nombre,
	socio_dir VARCHAR(50),
	socio_tel INT NOT NULL,
	socio_fecha_entrada DATE NOT NULL,
);

CREATE TABLE Prestamos
(
	ID TINYINT PRIMARY KEY IDENTITY(1,1),
	fecha_prestamo DATE NOT NULL,
	fecha_devolucion DATE,
	socioID_FK VARCHAR(9) FOREIGN KEY REFERENCES Socios,
	libroID_FK SMALLINT FOREIGN KEY REFERENCES Libros,
	CONSTRAINT check_dni CHECK(fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo)
);