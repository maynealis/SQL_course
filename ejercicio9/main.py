import pyodbc
from funciones import imprimir_2_col_just

# ----------------------- CONNEXIÓN CON EL SERVIDOR -----------------------
server = "DESKTOP-V7R78RP"
user = "python_connect"
password = "CursoSOC&2024"

# --------------- CONNEXIÓN CON LA BASE DE DATOS TERRITORIO ---------------
data_base = "territorio"
conexion_str = ("DRIVER={SQL Server};" 
                + f"""SERVER={server};
                DATABASE={data_base};
                UID={user};
                PWD={password};""")
conn = pyodbc.connect(conexion_str)
cursor = conn.cursor()


# ---------------------- RESPONDEMOS A LAS PREGUNTAS ----------------------
comunidad = 'Andalucía'
cursor.execute(f"""SELECT count(p.NameProv) AS NumeroProvincias
                FROM comunidades AS c inner join provincias AS p
                on p.IDcom = c.IDcom
                GROUP BY c.NameCom
                HAVING c.NameCom = '{comunidad}';""")
print(f"1. En {comunidad} hay {cursor.fetchval()} provincias.")
# -------------------------------------------------------------------------
cursor.execute(f"""SELECT format(sum(p.NumHabProv), 'N0') FROM provincias AS p""")
print(f"2. Número total de habitantes de España: {cursor.fetchval()}")
# -------------------------------------------------------------------------
comunidad = 'Galicia'
cursor.execute(f"""SELECT p.NameProv, format(sum(p.NumHabProv), 'N0') FROM provincias AS p
               inner join comunidades as c
               on c.IDcom = p.IDcom
               WHERE c.NameCom = '{comunidad}'
               GROUP BY p.NameProv
               order by sum(p.NumHabProv) DESC; """)
print(f"3. Lista de provincias de {comunidad} ordenadas por número de habitantes:")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------
end_string = "de"
cursor.execute(f"""SELECT c.NameCom, count(p.NameProv) FROM provincias AS p
               inner join comunidades AS c
               on c.IDcom = p.IDcom
               GROUP BY c.NameCom
               HAVING c.NameCom LIKE '%{end_string}'""")
print (f"4. Número de provincias que tiene cada una de las comunidades autónomas que terminan con '{end_string}'")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------
cursor.execute(f"""SELECT DISTINCT p.NameProv, format(p.NumHabProv, 'N0') FROM provincias AS p
               WHERE p.NumHabProv >= 1000000
               ORDER BY p.NameProv;
               """)
print (f"5. Ordena alfabéticamente las provincias millonarias")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------
cursor.execute(f"""SELECT TOP 5 p.NameProv, format(p.NumHabProv, 'N0') FROM provincias AS p
               ORDER BY p.NumHabProv;""")
print(f"6. Las 5 provincias con menor población")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------
cursor.execute(f"""SELECT p.NameProv, format(p.NumHabProv, 'N0') FROM provincias AS p
               WHERE len(p.NameProv) = 7
               AND ((p.NumHabProv > 150000 AND p.NumHabProv < 200000) OR (p.NumHabProv > 900000 AND p.NumHabProv < 1000000));""")
print(f"7. Muestra las provincias con nombre de 7 letras cuya población sea mayor de 150 000 y menor de 200 000 habitante o que sea mayor de 900 000 y menor de 1 000 000 de habitantes:")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------
letra = 'M'
cursor.execute(f"""SELECT format(sum(p.NumHabProv), 'N0') AS 'Población de las provinicias de las comunidades autónomas que empiezan por {letra}'
               FROM provincias AS p
               inner join comunidades AS c
               on c.IDcom = p.IDcom
               WHERE c.NameCom LIKE '{letra}%';""")
print(f"8. La población de las provinicias de las comunidades autónomas que empiezan por {letra} es: {cursor.fetchval()}")
# -------------------------------------------------------------------------
cursor.execute(f"""SELECT c.NameCom, count(p.NameProv) FROM comunidades as c
               inner join provincias AS p
               on p.IDcom = c.IDcom
               WHERE p.NumHabProv >= 700000 AND p.NumHabProv <= 800000
               GROUP BY c.NameCom
               ORDER BY count(p.NameProv) DESC;""")
print(f"9. Los nombres de las comunidades autónomas ordenada descendentemente por el número de sus provincias cuya población está entre 700 000 y 800 000 habitantes:")
imprimir_2_col_just(cursor)
# -------------------------------------------------------------------------

conn.close()
