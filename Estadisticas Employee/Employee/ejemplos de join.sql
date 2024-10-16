select top 5 * from Person.StateProvince;	-- ciudad
select top 5 * from Person.CountryRegion;	-- pais
select top 5 * from Person.Address;			-- a

-- listar las ciudades y paises
select ciudades.name as Ciudad, paises.name as Pais from Person.StateProvince as ciudades
inner join Person.CountryRegion as paises
on ciudades.CountryRegionCode = paises.CountryRegionCode
order by paises.name, ciudades.name;


-- agrupamos las direcciones con la ciudad y país
select a.AddressLine1, ciudad.Name as Ciudad, pais.Name as Pais from Person.Address as a
inner join Person.StateProvince as ciudad
on a.StateProvinceID = ciudad.StateProvinceID
inner join Person.CountryRegion as pais
on pais.CountryRegionCode = ciudad.CountryRegionCode;

-- encontrar los 3 países con más clientes
select top 3 pais.Name as Pais, count(a.AddressLine1) as NumberClients from Person.Address as a
inner join Person.StateProvince as ciudad
on a.StateProvinceID = ciudad.StateProvinceID
inner join Person.CountryRegion as pais
on pais.CountryRegionCode = ciudad.CountryRegionCode
group by pais.Name
order by NumberClients desc;


/*
EJERCICIOS CLASE 16/10
*/


--EJERCICIO 1: ordenamos los apellidos de cada país
select per.LastName, country.Name as Pais, ciudad.Name as Ciudad from Person.Person as per
inner join Person.BusinessEntity as be
on per.BusinessEntityID = be.BusinessEntityID
inner join Person.BusinessEntityAddress as bea
on be.BusinessEntityID = bea.BusinessEntityID
inner join Person.Address as addres
on bea.AddressID = addres.AddressID
inner join Person.StateProvince as ciudad
on addres.StateProvinceID = ciudad.StateProvinceID
inner join Person.CountryRegion as country
on ciudad.CountryRegionCode = country.CountryRegionCode
order by country.Name, per.LastName;

-- es más rápido si después del inner join empezamos la condición por la última tabla y luego la primera:
select per.LastName, country.Name as Pais, ciudad.Name as Ciudad from Person.Person as per
inner join Person.BusinessEntity as be
on be.BusinessEntityID = per.BusinessEntityID
inner join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID = be.BusinessEntityID
inner join Person.Address as a
on a.AddressID = bea.AddressID
inner join Person.StateProvince as ciudad
on ciudad.StateProvinceID = a.StateProvinceID
inner join Person.CountryRegion as country
on country.CountryRegionCode = ciudad.CountryRegionCode
order by country.Name, per.LastName;



select distinct per.BusinessEntityID, country.Name as Pais, ciudad.Name as Ciudad from Person.Person as per
left join Person.BusinessEntity as be
on be.BusinessEntityID = per.BusinessEntityID
left join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID = be.BusinessEntityID
left join Person.Address as a
on a.AddressID = bea.AddressID
left join Person.StateProvince as ciudad
on ciudad.StateProvinceID = a.StateProvinceID
left join Person.CountryRegion as country
on country.CountryRegionCode = ciudad.CountryRegionCode;
-- hemos perdido información... Hay más registros de personas al principio de la primera tabla.

select * from Person.Person;

-- EJERCICIO 2: De qué personas tenemos el teléfono de su casa y cual es?
select * from Person.Person;
select * from Person.PersonPhone;
select * from Person.PhoneNumberType;

select p.FirstName, phone.PhoneNumber, phoneType.Name as Type from Person.Person as p
inner join Person.PersonPhone as phone
on phone.BusinessEntityID = p.BusinessEntityID
inner join Person.PhoneNumberType as phoneType
on phoneType.PhoneNumberTypeID = phone.PhoneNumberTypeID
where phoneType.Name = 'Home';

-- EJERCICIO 3: Mostrar la dirección de facturación de los clientes franceses.

select * from Sales.Customer;
select * from Person.Person;
select * from Sales.SalesTerritory;
select * from Person.CountryRegion;
select * from Person.Address;
select * from Person.AddressType;

select * from Person.Person as p
inner join Sales.Customer as customer
on customer.PersonID = p.BusinessEntityID
inner join Sales.SalesTerritory as t
on t.TerritoryID = customer.TerritoryID
inner join Person.CountryRegion as country
on country.CountryRegionCode = t.CountryRegionCode
where country.Name = 'France';

select p.FirstName, a.AddressLine1, atype.Name, country.Name from Person.Person as p
left join Person.BusinessEntity as be
on be.BusinessEntityID = p.BusinessEntityID
left join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID = be.BusinessEntityID
left join Person.Address as a
on a.AddressID = bea.AddressID
inner join Person.AddressType as atype
on bea.AddressTypeID = atype.AddressTypeID
inner join Sales.Customer as customer
on customer.PersonID = p.BusinessEntityID
inner join Sales.SalesTerritory as t
on t.TerritoryID = customer.TerritoryID
inner join Person.CountryRegion as country
on country.CountryRegionCode = t.CountryRegionCode
where atype.Name = 'Shipping';
