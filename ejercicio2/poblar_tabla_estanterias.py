import pyodbc

server = "DESKTOP-V7R78RP"  # name of the server
user = "python_connect"     # user created to connect by password
password = "CursoSOC&2024"  # password for the user

DB_NAME = "Almacen"
TABLE_NAME = "Estanterias"
MAX_ESTANTERIAS = 10
MAX_POSICIONES = 20
MAX_ALTURA = 3

conexion_str = "DRIVER={SQL Server};" + f"""SERVER={server};
                                        DATABASE={DB_NAME};
                                        UID={user};
                                        PWD={password};
                                        """
conn = pyodbc.connect(conexion_str, autocommit=True)
cursor = conn.cursor()

insert_query = f"""INSERT INTO {TABLE_NAME} (estNum, estPos, estAlt) VALUES (?, ?, ?)"""

try:
    for estNum in range(1, MAX_ESTANTERIAS + 1):
        for estPos in range(1, MAX_POSICIONES + 1):
            for estAlt in range(1, MAX_ALTURA + 1):
                cursor.execute(insert_query, (estNum, estPos, estAlt))
    conn.commit()
    print("Datos insertados en la tabla Estanterias")
except Exception as e:
    print(f"Error al insertar datos: {e}")
    conn.rollback()
finally:
    cursor.close()
    conn.close()