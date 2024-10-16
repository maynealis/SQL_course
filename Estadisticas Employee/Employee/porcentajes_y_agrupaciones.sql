-- Desde la tabla HumanResources.Employee, calcula el porcentaje de hombres y el porcentaje de mujeres


DECLARE @TotalEmployees INT;

SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;


SELECT 
    Gender,
    COUNT(*) * 100.0 / @TotalEmployees AS Percentage
FROM 
    HumanResources.Employee

GROUP BY 
    Gender;

-- Desde la tabla HumanResources.Employee, Averigua cual porcentje es mayor, si el de hombres casados o el de mujeres casadas


DECLARE @TotalEmployees INT;
DECLARE @TotalMales INT;
DECLARE @TotalFemales INT

SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;
SELECT @TotalMales = COUNT(*) FROM HumanResources.Employee WHERE Gender = 'M';
SELECT @TotalFemales = COUNT(*) FROM HumanResources.Employee WHERE Gender = 'F';

SELECT 
    Gender,
    COUNT(*) * 100.0 / CASE WHEN Gender = 'M' THEN @TotalMales ELSE @TotalFemales END AS Percentage
FROM 
    HumanResources.Employee
WHERE MaritalStatus = 'M'
GROUP BY 
    Gender;


-- Calcula la edad media de los empleados que hay en la tabla HumanResources.Employee
SELECT * FROM HumanResources.Employee;
select avg(year(GETDATE()) - year(BirthDate)) from HumanResources.Employee

-- Calcula la edad media de los empleados por genero que hay en la tabla HumanResources.Employee
select gender, avg(year(GETDATE()) - year(BirthDate)) from HumanResources.Employee
group by Gender;
-- Calcula la edad media de los empleados cuando fueron contratadod por genero que hay en la tabla HumanResources.Employee
select gender, avg(year(HireDate) - year(BirthDate)) from HumanResources.Employee
group by gender;

select Gender, MaritalStatus ,year(GETDATE()) - year(BirthDate) from HumanResources.Employee
group by Gender, MaritalStatus
order by gender;


SELECT 
    Gender, MaritalStatus,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM HumanResources.Employee) AS Percentage
FROM 
    HumanResources.Employee
GROUP BY 
    Gender, MaritalStatus
ORDER by
	Gender;


/*
Desde la tabla HumanResources.Employee, Elabora una matriz con filas para el género
y columnas para el estado civil, en la que se cuenten cuantos empleados 
hay en cada categaoría
*/

SELECT 
    Gender,
    [S], [M]
FROM 
    (SELECT 
        Gender, MaritalStatus
    FROM HumanResources.Employee) AS SourceTable
PIVOT 
(
    COUNT(MaritalStatus)
    FOR MaritalStatus IN ([S], [M])
) AS PivotTable;

/*
Desde la tabla HumanResources.Employee, Elabora una matriz con filas para el género
y columnas para el estado civil, en la que se muestre el % que representa cada segmento
en el total de empleados.

*/
DECLARE @TotalEmployees INT;
SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;

SELECT 
    Gender,
    [S], [M]
FROM 
    (SELECT 
        Gender, MaritalStatus, 100 * 1.0/@TotalEmployees as percentaje
    FROM HumanResources.Employee) AS SourceTable
PIVOT 
(
    sum(percentaje)
    FOR MaritalStatus IN ([S], [M])
) AS PivotTable;

/*
Ahora formateando la salida
*/

DECLARE @TotalEmployees INT;
SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;

SELECT 
    Gender,
    FORMAT([S], '0.00') + '%' AS [Single],
    FORMAT([M], '0.00') + '%' AS [Married]
FROM 
    (SELECT 
        Gender, 
        MaritalStatus, 
        100 * 1.0 * COUNT(*) / @TotalEmployees AS percentage
     FROM HumanResources.Employee 
     GROUP BY Gender, MaritalStatus) AS SourceTable
PIVOT 
    (SUM(percentage)
     FOR MaritalStatus IN ([S], [M])) AS PivotTable;