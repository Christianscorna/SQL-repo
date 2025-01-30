import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

conexion = sqlite3.Connection("C:/Users/sergi/OneDrive/Documentos/Ingeniería de Sistemas/Tercer Año/Bases de Datos I/NorthWindDataBase.db")
productos_mas_rentables = '''
    SELECT ProductName, SUM(Price * Quantity) AS "Rentabilidad"
    FROM OrderDetails JOIN Products USING(ProductID)
    GROUP BY ProductID
    ORDER BY Rentabilidad DESC
    LIMIT 10;
'''

empleados_mas_eficientes = '''
    SELECT e.FirstName || " " || e.LastName AS Empleado, COUNT(*) as "Total"
    FROM Orders o JOIN Employees e USING(EmployeeID)
    GROUP BY o.EmployeeID
    ORDER BY Total DESC
'''

pmr = pd.read_sql_query(productos_mas_rentables, conexion)
print("los productos mas rentables son: ")
print(pmr)

#Ver los productos o empleados de esta forma es bastante indeseable, podemos aprovechar la potencialidad de matplot y verlos mediante gráficos

#Creamos un plot y le damos título, nombres al eje x e y, el tipo de gráfico, el tamaño de las barras y que no tenga leyenda
pmr.plot(x="ProductName", y="Rentabilidad", kind="bar", figsize=(10, 5), legend=False)
plt.title("Top 10 productos mas rentables")
plt.xlabel("Nombre producto")
plt.ylabel("Rentabilidad")
plt.xticks(rotation=45)
#plt.show()

cmr = pd.read_sql_query(empleados_mas_eficientes, conexion)
cmr.plot(x="Empleado", y="Total", kind="bar", figsize=(10, 5), legend=False)
plt.title("Empleados mas eficientes")
plt.xlabel("Empleado")
plt.ylabel("Recaudacion")
plt.xticks(rotation=25)
plt.show()

