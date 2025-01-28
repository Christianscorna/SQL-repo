#Importar la librería que nos permite comunicarnos con la BBDD
import sqlite3 as sqlt

#Creamos la funcion que devuelve una potencia cubica
cubo = lambda n : n*n*n

#Creamos la conexión
conexion = sqlt.connect("C:/Users/sergi/OneDrive/Documentos/Ingeniería de Sistemas/Tercer Año/Bases de Datos I/NorthWindDataBase.db")

#Creamos la funcion para SQLite
conexion.create_function("cubo", 1, cubo)

#Creamos un cursor que nos devuelva la informacion de la consulta formateada
cursor = conexion.cursor()

#Le decimos que nos ejecute una consulta:
cursor.execute('''
    SELECT * FROM Products;
''')

#Obtenemos la informacion guardada en cursor
resultado = cursor.fetchall()