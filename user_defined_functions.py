#Importar la librería que nos permite comunicarnos con la BBDD y crear dataframes
import sqlite3 as sqlt
import pandas as pd

#Creamos la funcion que devuelve una potencia cubica
cubo = lambda n : n*n*n

#Creamos la conexión
conexion = sqlt.connect("C:/Users/sergi/OneDrive/Documentos/Ingeniería de Sistemas/Tercer Año/Bases de Datos I/NorthWindDataBase.db")

#Creamos la funcion para SQLite
conexion.create_function("cubo", 1, cubo)

#Creamos un cursor que nos devuelva la informacion de la consulta formateada
cursor = conexion.cursor()

#Le decimos que nos ejecute una consulta: 
##Esto además nos está iniciando una transacción
cursor.execute('''
    SELECT * FROM Products;
''') 

#Obtenemos la informacion guardada en cursor y creamos un dataframe para mostrar la info
resultado = cursor.fetchall()
df_resultado = pd.DataFrame(resultado)

#Luego, es necesario realizar el commit, para que se guarden los cambios
conexion.commit()

#Por ultimo, es necesario que cerremos tanto el cursor como la conexion, por seguriad y por recursos del sistema
cursor.close()
conexion.close()

print(df_resultado)