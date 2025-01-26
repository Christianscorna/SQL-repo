/*
 Los JOIN nos permiten vincular dos o mas tablas.

 Devuelve los datos que coinciden en AMBAS tablas + Los datos de la tabla derecha
 */

SELECT * FROM institucion 
RIGHT JOIN direccion
USING (id_direccion)

-- Justamente POSTGRESQL es un buen servidor pero si sos pichi y usas SQL Lite seguramente te encuentres con que no se puede implementar el right join ya que no lo soporta
-- El right join se puede simular con un left join e invirtiendo el orden de las tablas

SELECT * FROM direccion 
LEFT JOIN institucion
USING (id_direccion)
-- Obviamente las tablas estarán intercambiadas de lugar, como era de esperar, pero el resultado es exactamente el mismo