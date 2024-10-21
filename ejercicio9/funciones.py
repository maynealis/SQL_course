# Funciones útiles para imprimir la información en la terminal de forma ordenada.

def imprimir_2_col_just(cursor):
    """Function that prints for command line a table of 2 columns justifying each value.

    Args:
        cursor (cursor): cursor from an sql query 
    """
    result = cursor.fetchall()
    max_just_l = 0
    max_just_r = 0
    for row in result:
        if len(row[0]) > max_just_l:
            max_just_l = len(row[0])
        if len(str(row[1])) > max_just_r:
            max_just_r = len(str(row[1]))
    max_just_l += 4
    for row in result:
        print (str(row[0]).ljust(max_just_l), str(row[1]).rjust(max_just_r))