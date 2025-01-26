/*
 Los JOIN nos permiten vincular dos o mas tablas.

 Devuelve los datos que coinciden en AMBAS tablas + Los datos de la tabla izquierda
 */

SELECT * FROM institucion 
LEFT JOIN direccion
USING (id_direccion)