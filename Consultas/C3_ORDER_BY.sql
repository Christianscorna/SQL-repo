-- Esta clausula nos permite ordenar por un criterio

SELECT LastName AS apellido FROM Employees
ORDER BY LastName;

/*
--Datos provenientes de la base de datos de NorthWind

apellido:
Buchanan
Callahan
Davolio
Dodsworth
Fuller
King
Leverling
Peacock
Suyama
West

Vemos que por defecto se ordena de manera ascendente. Si qusisieramos que se ordene de manera descendente utilizamos la palabra reservada: DESC

 */

SELECT LastName AS apellidito FROM Employees
ORDER BY LastName DESC;

/*
apellidito
West
Suyama
Peacock
Leverling
King
Fuller
Dodsworth
Davolio
Callahan
Buchanan

En el caso de que contemos con valores nulos en nuestra tabla, por defecto en orden ascendente se mostrarán al principio.
Si nosotros quisiseramos que dichos valores nulos se muestren al final y que el resto de los datos continuen ordenados ascendentemente lo que debemos hacer es colocar NULLS LAST
*/

SELECT LastName AS apellidin
FROM Employees
ORDER BY LastName ASC NULLS LAST;

/*
apellidin
West
Suyama
Peacock
Leverling
King
Fuller
Dodsworth
Davolio
Callahan
Buchanan
NULL
...
NULL

Tambien podemos ordenar por dos parámetros:
*/

SELECT FirstName AS nombre, LastName AS apellido
FROM Employees
ORDER BY apellido, nombre

/*
nombre  apellido	
Steven	Buchanan
Laura	Callahan
Nancy	Davolio
Anne	Dodsworth
Andrew	Fuller
Robert	King
Janet	Leverling
Margaret	Peacock
Michael	Suyama
Adam	West
*/