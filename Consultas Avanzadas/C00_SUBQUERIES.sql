/*
 Una subconsulta es una consulta que se haya dentro de otra consulta
 --> Las subqueries solo recuperan datos, suelen ser SELECT (No alteran a la base)
 */

SELECT ProductID AS 'ID ORDER', Quantity AS 'CANT ORDER', (
	SELECT ProductName
	FROM Products
	WHERE OrderDetails.ProductID = Products.ProductID ) AS 'Nombre PRODUCTO', (
	SELECT ProductID
	FROM Products
	WHERE OrderDetails.ProductID = Products.ProductID ) AS 'ID PRODUCTO'
FROM OrderDetails

/*
  En el ejemplo anterior nos trajimos el nombre y el Id de los productos que coinciden con los de las ordenes, pero separados en dos subconsultas ya que no podemos consultar por dos campos dado que esto nos estaría devolviendo una tabla

  |ID ORDER|CANT ORDER |        Nombre PRODUCTO       |ID PRODUCTO|
  |  11	   |    12	   |Queso Cabrales	              |     11    |
  |  42	   |    10	   |Singaporean Hokkien Fried Mee |     42    |

 */
 
SELECT ProductID, SUM(Quantity) AS 'Vendido', (
	-- Me traigo el precio desde OrderDetails mediante una subconsulta
	SELECT Price FROM Products
	-- Aquí realizamos el ensable entre tablas
	WHERE OrderDetails.ProductID == Products.ProductID ) AS 'Precio', (
	-- No podemos utilziar alias de funciones de agregacion ni de consultas para realizar operaciones matemáticas, tenemos que hacer las consultas nuevamente si o si
	SUM(Quantity) * (SELECT Price FROM Products WHERE OrderDetails.ProductID == Products.ProductID)) AS 'Recaudado'
FROM OrderDetails -- Aquí tendríamos el total
GROUP BY ProductID; -- Aquí tenemos el resultado por grupo

-- El problema de las subconsultas es que, como vemos, se hace muy denso el código y el programa se vuelve muy pesado.

--También podemos utilizar las subconsultas para filtrar cosas: Por ejemplo si quiero que solo me devuelva los precios menores a 35 puedo volver a utilizar la misma consulta ¡¡Aunque no su alias!!
SELECT ProductID, SUM(Quantity) AS 'Vendido'
FROM OrderDetails
WHERE (
    SELECT Price 
    FROM Products 
    WHERE OrderDetails.ProductID == Products.ProductID
) < 35
GROUP BY ProductID; 
-- De esta manera hemos podido controlar el filtro por precios de la tabla productos, pero, desde otra tabla

-- En cambio para filtrar si podemos utilizar el alias, por ejemplo si hubieramos decidido mostrar el precio:
SELECT ProductID, SUM(Quantity) AS 'Vendido', 
    ( SELECT Price FROM Products WHERE OrderDetails.ProductID == Products.ProductID ) AS 'Precio'
FROM OrderDetails
WHERE Precio < 35
GROUP BY ProductID; 

-- Lo bueno de estas subconsultas es que estamos creando nuestras propias tablas personalizadas y a su vez a esas tablas les podemos hacer consultas
SELECT * FROM (
	SELECT ProductID, SUM(Quantity) AS 'Vendido', 
		( SELECT Price FROM Products WHERE OrderDetails.ProductID == Products.ProductID ) AS 'Precio'
	FROM OrderDetails
	WHERE Precio < 35
	GROUP BY ProductID
); -- En este caso hemos decidido traernos todo

SELECT ProductID FROM (
	SELECT ProductID, SUM(Quantity) AS 'Vendido', 
		( SELECT Price FROM Products WHERE OrderDetails.ProductID == Products.ProductID ) AS 'Precio'
	FROM OrderDetails
	WHERE Precio < 35
	GROUP BY ProductID
)
WHERE Vendido > 163; -- O en este otro caso quisimos los id de los productos que vendieron mas de 163

-- Incluso podemos seguir jugando y combinando
SELECT * FROM (
	SELECT ProductID, SUM(Quantity) AS 'Vendido', 
		( SELECT Price FROM Products WHERE OrderDetails.ProductID == Products.ProductID ) AS 'Precio'
	FROM OrderDetails
	WHERE Precio < 35
	GROUP BY ProductID
)
WHERE Vendido > 163 OR Precio < 55; -- Que nos muestre los datos de aquellos productos que vendieron mas de 163 o que el precio sea menor a una determinada tarifa