-- Creamos DB
CREATE DATABASE Taller;

USE Taller;

-- Creamos tabla Cliente
CREATE TABLE Cliente
(
	NIF_PK VARCHAR(9) PRIMARY KEY CHECK( 
		NIF_PK LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]' OR 
		NIF_PK LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'		OR
		NIF_PK LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]' OR
		NIF_PK LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	nombre NVARCHAR(50) NOT NULL,
	apellido1 NVARCHAR(50) NOT NULL,
	apellido2 NVARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	poblacion VARCHAR(50) NOT NULL,
	CP CHAR(5) NOT NULL CHECK(CP LIKE '[0-5][0-9][0-9][0-9][0-9]'),
	telefono INT NOT NULL,
	correo VARCHAR(50) NOT NULL CHECK(correo LIKE '%_@_%_._%'),
	consentimientoPDF VARCHAR(MAX) NOT NULL, 
);

-- Creamos tabla auxiliar para el cambio de marchas
CREATE TABLE TipoCambio
(
	tipoCambio_PK TINYINT PRIMARY KEY IDENTITY(0,1),
	nombre_cambio VARCHAR(10) NOT NULL,
);

-- Rellenamos tabla auxiliar para el cambio de marchas
INSERT INTO TipoCambio (nombre_cambio)
VALUES 
('manual'),
('automático');

-- Creamos tabla Vehiculo
CREATE TABLE Vehiculo
(
	matricula_PK VARCHAR(7) PRIMARY KEY CHECK(matricula_PK LIKE '[0-9][0-9][0-9][0-9][A-Z][A-Z][A-Z]'),
	marca VARCHAR(25) NOT NULL,
	modelo VARCHAR(50) NOT NULL,
	año_matricula SMALLINT CHECK (año_matricula >= 2000),
	km INT CHECK(km >= 0),
	combustible VARCHAR(25),
	tipo_cambio_FK TINYINT FOREIGN KEY REFERENCES TipoCambio,
	potencia SMALLINT CHECK(potencia > 0), --potencia en cm3
	propietario_FK VARCHAR(9) FOREIGN KEY REFERENCES Cliente NOT NULL, 
);

-- Creamos tabla Reparacion
CREATE TABLE Reparacion
(
	num_rep_PK SMALLINT PRIMARY KEY IDENTITY(1,1),
	fecha_rep DATE DEFAULT GETDATE() NOT NULL,
	descripcion_rep VARCHAR(MAX),
	precio_materiales SMALLMONEY CHECK(precio_materiales >= 0),
	horas_rep DECIMAL(5,2) DEFAULT 0.5 CHECK(horas_rep >=0.25) NOT NULL,
	vehiculo_rep_FK VARCHAR(7) FOREIGN KEY REFERENCES Vehiculo,
);

-- Creamos tabla Factura
CREATE TABLE Factura
(
	num_fac_PK SMALLINT PRIMARY KEY IDENTITY(1,1),
	fecha_fac DATE,


);