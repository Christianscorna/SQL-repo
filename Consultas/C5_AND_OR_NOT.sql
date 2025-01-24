/*
  AND y OR son operadores lógicos que nos permiten combinar dos o más condiciones de manera que estas cumplan obligatoriamente u opcional respectivamente
 */

-- Si quisieramos saber los datos de los productos cuyo id va de entre 5 y 10 (Incluidos)
-- Permite simular rangos, aunque para estos SQL ya provee una cláusula que veremos mas adelante
SELECT *
FROM Products
WHERE ProductID >= 5 AND ProductID <= 10;

-- Si quisiéramos saber si alguno de nuestros empleados tiene un sueldo menor a 10000 o si tienen id_trabajo = 3
SELECT *
FROM empleados
WHERE sueldo <= 10000 OR id_trabajo = 3;

-- Los operadores son combinables, es decir podemos manejar muchos filtros lógicos dentro de una misma consulta
SELECT *
FROM Products
WHERE Unit = "500 ml" or SupplierID = 15 AND Price > 10;

-- Mediante paréntesis podemos manipular la obligatoriedad de las consultas hacer: 
SELECT *
FROM Products
WHERE (Unit = "500 ml" or SupplierID = 15) AND Price > 10;

-- es diferente de hacer:
SELECT *
FROM Products
WHERE Unit = "500 ml" or (SupplierID = 15 AND Price > 10);

/*
 * NOT aplica para invertir lógicas
 */

--Supongamos que queremos todos los productos que no cuestan 45 
SELECT *
FROM Products
WHERE NOT Price = 45;