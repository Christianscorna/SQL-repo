/*
 Los JOIN nos permiten vincular dos o mas tablas.

 Devuelve los datos que coinciden en AMBAS tablas + Los datos de la tabla izquierda + Los datos de la tabla derecha
 */

SELECT * FROM institucion
FULL JOIN direccion
USING (id_direccion)

-- Justamente POSTGRESQL es un buen servidor pero si sos pichi y usas SQL Lite seguramente te encuentres con que no se puede implementar el full join ya que no lo soporta
-- El full join se puede simular con un left join + un right join + la cláusula UNION

SELECT * FROM institucion LEFT JOIN direccion
USING (id_direccion)

UNION

SELECT * FROM direccion LEFT JOIN institucion
USING (id_direccion);
-- Luego se obtiene la union de el resultado de un left join con un right join simulado con un left join inviertiendo tablas
-- Justo en este caso no se puede por la compatibilidad de los datos, tomar solamente a modo de ejemplo.