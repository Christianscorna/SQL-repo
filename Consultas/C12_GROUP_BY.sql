/*
 La cláusula GROUP BY en una sentencia SELECT forma grupos con las filas que tienen valores en común para la lista de columnas especificadas para el grupo (puede ser una o más columnas)

 Su forma general es:

    SELECT lista_columnas, función de agrupamiento (columna)
    FROM lista_tablas
    WHERE condición_tuplas
    GROUP BY lista_columnas;

  Es importante saber que retorna una única fila por cada grupo
 */

-- Agrupar los productos por id, mostrando el precio en promedio de cada producto. Se deben mostrar en orden ascendente por propmedio y mostrar al menos 3 decimales.
SELECT SupplierID, round(avg(Price), 3) AS PromedioPrecio 
FROM Products
GROUP BY SupplierID
ORDER BY PromedioPrecio;

-- Si quisiéramos saber la cantidad de voluntarios que existen por intitucion
SELECT id_institucion, COUNT(*) AS CantidadVoluntarios
FROM voluntarios
GROUP BY id_institucion;

-- Si quisiéramos saber el porcentaje promedio de los voluntarios por institucion
SELECT id_institucion, avg(porcentaje)
FROM voluntarios
GROUP BY id_institucion;

-- ¿Cuántos voluntarios realizan cada tarea?
SELECT id_tarea, COUNT(nro_voluntario) AS CantidadVoluntarios
FROM voluntario
GROUP BY id_tarea
ORDER BY CantidadVoluntarios DESC;

-- ¿Cuál es el promedio de horas aportadas por tarea?
SELECT id_tarea, ROUND(AVG(horas_aportadas), 2) AS PromedioHoras
FROM voluntario
GROUP BY id_tarea
ORDER BY PromedioHoras;