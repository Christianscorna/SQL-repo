/*
 Las funciones de agregacion nos permiten agrupar datos, resumirlos y realizar estadisticas con ellos.
 Se utilizan con la cláusula SELECT.
 */

-- SUM( ) → sumatoria de la columna especificada
SELECT SUM(Price) AS total 
FROM Products

-- AVG( ) → promedio de la columna especificada
SELECT AVG(Price) AS PromedioPrecios
FROM Products

-- ROUND() → redondea un valor
SELECT ROUND(AVG(Price), 2) AS PromedioPreciosRedondeado
FROM Products; -- El 2 es porque queremos dejar 2 decimales

-- MAX( ) → valor máximo de la columna especificada
SELECT MAX(Price) AS PrecioMasAlto
FROM Products;

-- MIN ( ) → valor mínimo de la columna especificada
SELECT MIN(Price) AS PrecioMasBajo
FROM Products;

-- COUNT ( ) → cantidad de valores en un campo
SELECT COUNT(FirstName) AS CantidadNombres
FROM Employees;

-- STDDEV() → desvío estándar de la columna especificada