#Otra forma de hacer lo mismo pero con contexto
import sqlite3 as sqlt
import pandas as pd

#Crear la funcion de interes como siempre
precio_doble = lambda n : n*2

#Crear el contexto
with sqlt.connect("C:/Users/sergi/OneDrive/Documentos/Ingeniería de Sistemas/Tercer Año/Bases de Datos I/NorthWindDataBase.db") as conexion:
    conexion.create_function("double", 1, precio_doble)
    cursor = conexion.cursor()
    cursor.execute('SELECT price, double(Price) FROM Products')
    resultado = cursor.fetchall()
    df_resultado = pd.DataFrame(resultado)

#Al salirnos, cierra automaticamente las conexiones
print(df_resultado)