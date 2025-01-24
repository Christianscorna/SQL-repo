/*
 La cláusula LIMIT nos permite poner un límite de resultados, de esta manera podemos hacer que se muestren solo la cantidad de resultados que nosotros querramos
 */

-- De esta manera mostramos un subconjunto de los 10 primeros empleados
SELECT * FROM voluntario
ORDER BY nro_voluntario
LIMIT 10;

-- Tambien podemos traernos los productos que cuesten menos de un precio, no sean de tal marca y solo mostremos 4 opciones
SELECT * FROM Products
WHERE Price < 32
    AND NOT CategoryID = 4
ORDER By ProductID
limit 4;