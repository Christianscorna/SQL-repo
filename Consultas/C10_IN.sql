/*
 Introduccion a las subconsultas, IN es un operador lógico (no de comparación)
 */

-- Supongamos que queremos conocer los productos de las categorías 3, 4, 5, y 6
SELECT * FROM Products
WHERE CategoryID = 3 
	OR CategoryID = 4
	OR CategoryID = 5
	OR CategoryID = 6;

-- Bastante molesto, pero se puede mejorar
SELECT * FROM Products
WHERE CategoryID IN (3, 4, 5, 6);
-- Lo que hicimos fue decirle que el CategoryID tiene que ESTAR EN y le pasamos la tupla con el subconjuntod e valores deseados
-- Es una especie de resumen del operador lógico OR

-- Mismo si quisieramos que no nos devuelvan determinadas categorías
SELECT * FROM Products
WHERE CategoryID NOT IN (1, 2, 7, 8);

-- O un conjunto de precios muy especifico:
SELECT * FROM Products
WHERE Price IN (10, 30, 21.35, 12);