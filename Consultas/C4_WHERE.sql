/*
  La sentencia where nos permite filtrar búsquedas implementando diferentes condiciones
 */

 -- Si quisiéramos saber que podemos comprar con 45 dólares (Hasta) 
SELECT * 
FROM Products
WHERE Price <= 45
ORDER BY Price;

-- Si quisiéramos saber el id de un producto específico
SELECT ProductID AS id_producto 
FROM Products
WHERE ProductName = "Queso Manchego La Pastora";
-- id 12

-- O al reves, si quisiéramos saber que nombre tiene el id tal
SELECT ProductName 
FROM Products
WHERE ProductID = "56";
-- Gnocchi di nonna Alice

/* 
 
 La cláusula where nos permite utilizar comparadores algebráicos:

 * < menor que
 * > mayor que
 * = igual
 * <= menor o igual que
 * >= mayor o igual que
 * <> o != distinto
    
    * Los resultados de las comparaciones WHERE pueden retornar 3 posibles resultados, a saber:
    --> TRUE (verdadero)
    --> FALSE (Falso)
    --> Unknown (Desconocido)
    |--> Las comparaciones entre valores nulos siempre retornaran como resultado un desconocido ya que podría ser mayor, menor o igual (No se sabe)

 FUNCIONAMIENTO DE LOS DBMS (Data Base Managment System)

 * 1 --> Recuperación de las filas con las que trabajará (Especificadas en la cláusula FROM)
 * 2 --> Filtrado de los datos (Especificadas en la cláusula WHERE)
 * 3 --> Por ultimo la proyección, ¿Qué es lo que va a tomar? (Especificadas en la cláusula SELECT)

 */

