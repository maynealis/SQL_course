USE Biblioteca;

-- Libros prestados
SELECT l.lib_PK, l.lib_title, l.lib_author FROM Libros AS l
INNER JOIN Prestamos AS p
ON p.libroID_FK = l.lib_PK
WHERE p.fecha_devolucion is null;


-- Libros en la biblioteca
/* 
De todos los libros que tengo, quítame los que tengo prestados. 
*/
SELECT l.lib_PK, l.lib_title, l.lib_author FROM Libros AS l
EXCEPT
SELECT l.lib_PK, l.lib_title, l.lib_author FROM Libros AS l
INNER JOIN Prestamos AS p
ON p.libroID_FK = l.lib_PK
WHERE p.fecha_devolucion is null;



--Esto funciona. Para saber qué libros tengo en mi biblioteca disponibles.
SELECT l.lib_title, l.lib_author FROM Libros AS l
WHERE NOT EXISTS (
	SELECT * FROM Prestamos AS p
	WHERE p.libroID_FK = l.lib_PK
	AND p.fecha_devolucion IS NULL
);