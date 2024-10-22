import pyodbc

server = "DESKTOP-V7R78RP"  # name of the server
user = "python_connect"     # user created to connect by password
password = "CursoSOC&2024"  # password for the user

# ----------------------CREAMOS BASE DE DATOS ---------------------------------
# Para crear la base de datos nos conectamos a la master primero

data_base = "master"        
conexion_str = "DRIVER={SQL Server};" + f"""SERVER={server};
                                        DATABASE={data_base};
                                        UID={user};
                                        PWD={password};
                                        """
conn = pyodbc.connect(conexion_str, autocommit=True)
cursor = conn.cursor()

DB_NAME = "Almacen"

# TODO: comprobar y gestionar qué hacer en caso que la bd ya exista.
cursor.execute(f'CREATE DATABASE {DB_NAME}')
conn.close()
# -----------------------------------------------------------------------------

# --------------------ACCEDEMOS A LA BASE DE DATOS ----------------------------
# Una vez creada, nos conectamos a la base de datos que hemos creado.
conexion_str = "DRIVER={SQL Server};" + f"""SERVER={server};
                                        DATABASE={DB_NAME};
                                        UID={user};
                                        PWD={password};"""
conn = pyodbc.connect(conexion_str)
cursor = conn.cursor()
cursor.execute(f"USE {DB_NAME};")

# ----------------------- CREAMOS LAS TABLAS ----------------------------------
cursor.execute("""CREATE TABLE TiposObjeto(
                typeID SMALLINT PRIMARY KEY IDENTITY(1,1),
                typeName NVARCHAR(20) NOT NULL,
               );""")

# TODO: hacer otra tabla para probar a hacer la PK como una concatenacion de los otras con un CLUSTER
cursor.execute("""CREATE TABLE Estanterias(
                estID SMALLINT PRIMARY KEY IDENTITY(1,1),
                estNum TINYINT NOT NULL CHECK(estNum BETWEEN 1 AND 10),
                estPos TINYINT NOT NULL CHECK(estPos BETWEEN 1 AND 20),
                estAlt TINYINT NOT NULL CHECK(estAlt BETWEEN 1 AND 3),
                );""")

cursor.execute("""CREATE TABLE Objetos(
                objID SMALLINT PRIMARY KEY IDENTITY(1,1),
                objName NVARCHAR(40) NOT NULL,
                objVal SMALLINT CHECK(objVal >= 0),
                typeID SMALLINT FOREIGN KEY REFERENCES TiposObjeto,
                estID SMALLINT FOREIGN KEY REFERENCES Estanterias,
                );""")

cursor.commit()
conn.close()