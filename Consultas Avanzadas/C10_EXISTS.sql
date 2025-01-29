/*
  El operador [NOT] EXISTS comprueba la existencia (o no) de filas en el conjunto de filas del resultado de la consulta.

  El EXISTS opera de la siguiente manera:
  --> Si se encuentra un valor de fila de la subconsulta:
    --> La búsqueda no continúa en la consulta interna.
    --> Se señaliza a la condición como TRUE.
  --> Si no se encuentra un valor de fila de la subconsulta:
    --> Se señaliza a la condición como FALSE.
    --> La búsqueda continúa en la consulta interna.
 */

SELECT e.nombre, e.apellido
FROM empleado e
WHERE EXISTS (
    SELECT 'X' FROM departamento d
    WHERE e.id_departamento = d.id_departamento
    AND e.id_distribuidor = d.id_distribuidor
    AND EXISTS (
        SELECT 'Y' FROM ciudad c
        WHERE d.id_ciudad = c.id_ciudad
        AND EXISTS (
            SELECT 'Z' FROM pais p
            WHERE p.id_pais = c.id_pais
            AND nombre_pais = 'ARGENTINA'
        )
    )
);

/*
  La subconsulta no retornará ningún dato, devuelve valores VERDADEROS o FALSOS que dependen de la verificación de existencia de los valores de la subconsulta.
  --> Para hacerlo debe recorrer TODA la subconsulta
 */