CREATE DATABASE territorio;
USE territorio; -- cambia la base de datos sobre la que estoy trabajando.


--DROP TABLE comunidades;
--DROP DATABASE territorio;


CREATE TABLE comunidades( 
	IDcom tinyint PRIMARY KEY IDENTITY(1,1),
	NameCom nvarchar(29) NOT NULL,
);

CREATE TABLE provincias(
	IDProv tinyint PRIMARY KEY IDENTITY(1,1),
	NameProv nvarchar(22) NOT NULL,
	NumHabProv INT NOT NULL,
	IDcom tinyint FOREIGN KEY REFERENCES comunidades,
);



