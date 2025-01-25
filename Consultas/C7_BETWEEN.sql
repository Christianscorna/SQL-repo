/*
 Between nos permite trabajar con rangos numéricos, o de fechas.
 Es inclusivo, es decir considera los extremos.
 El primer valor corresponde al menos valor del rango, el segundo, al mayor.
 --> SELECT * FROM tabla
     WHERE columna BETWEEN valor1 AND valor2;
 */

-- Si quisieramos los productos entre un determinado rango de precios
SELECT *
FROM Products
WHERE Price  
BETWEEN 14 AND 19.75
AND CategoryID = 5;

-- Si quisiéramos buscar a aquellos empleados que hayan nacido entre los 80 y 90
SELECT *
FROM Employees
WHERE BirthDate 
BETWEEN "1980-1-1" AND "1990-1-1";
