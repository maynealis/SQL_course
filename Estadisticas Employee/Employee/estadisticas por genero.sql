SELECT TOP (1000) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[Employee]

/*
TODO: Hacer estadísticas de género en función de la posición (de poder) y de Production que es donde más empleados hay.
TODO: Hacer estadísticas sobre los cambios de salario.
*/



-- TotalEmployees es el numero total de empleados actualmente.
DECLARE @TotalEmployees INT;
SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;

-- FemaleEmployees es el número de empleadas Female
DECLARE @FemaleEmployees INT;
SELECT @FemaleEmployees = COUNT(*) FROM HumanResources.Employee WHERE Gender = 'F';

-- MaleeEmployees es el número de empleadas Female
DECLARE @MaleEmployees INT;
SELECT @MaleEmployees = COUNT(*) FROM HumanResources.Employee WHERE Gender = 'M';


DECLARE @Managers INT;
DECLARE @MaleManagers INT;
DECLARE @FemaleManagers INT;
SELECT @Managers = COUNT(*) FROM HumanResources.Employee WHERE JobTitle LIKE '%Manager%'

DECLARE @Supervisors INT;
DECLARE @MaleSupervisors INT;
DECLARE @FemaleSupervisors INT;
SELECT @Supervisors = COUNT(*) FROM HumanResources.Employee WHERE JobTitle LIKE '%Supervisor%'



SELECT 
    JobTitle,
    [M] as Male, [F] as Female, [M]+[F] as Total
FROM 
    (SELECT 
        JobTitle, Gender
    FROM HumanResources.Employee
	WHERE JobTitle LIKE '%Manager%' OR JobTitle LIKE '%Supervisor%' OR JobTitle LIKE '%President%')
	AS SourceTable
	
PIVOT 
(
    COUNT(Gender)
    FOR Gender IN ([M], [F])
) AS PivotTable;



SELECT JobTitle, Gender
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager%' OR JobTitle LIKE '%Supervisor%' OR JobTitle LIKE '%President%'