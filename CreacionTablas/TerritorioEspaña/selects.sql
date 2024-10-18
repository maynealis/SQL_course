
-- Número de provincias por comunidad autonómica ordenadas de mayor a menor, y su número de habitantes.
select c.NameCom as Comunidad, count(p.NameProv) as NumeroProvincias, format(sum(p.NumHabProv), 'N0') as NumeroHabitantes
from [comunidades] as c
inner join[provincias] as p 
on p.IDcom = c.IDcom
group by c.NameCom
order by NumeroProvincias desc, NumeroHabitantes desc;


-- crea una vista con la seleccion que hemos hecho para poder usarla después
create view prov_com as
select c.NameCom as Comunidad, count(p.NameProv) as NumeroProvincias
from [comunidades] as c
inner join[provincias] as p 
on p.IDcom = c.IDcom
group by c.NameCom;

create view comunidades_provincias_habitantes as
select c.NameCom as comunidad, p.NameProv as provincia, p.NumHabProv as habitantes
from [comunidades] as c
inner join[provincias] as p 
on p.IDcom = c.IDcom

select * from comunidades_provincias_habitantes;