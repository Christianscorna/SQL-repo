/*  La clausula SELECT nos permite consultar a una BBDD y traernos los datos seleccionados. 
 *  BASICS: vamos a seguir el estandar --> Las palabras reservadas escritas en mayúsculas y el resto en minúsuculas.

 *  Veamos como funciona el formato específico de SELECT
 
 *  SELECT "columna 1", "coluna 2", ... "columna n"
 *  FROM "nombre de tabla"
 *  WHERE {condiciones}

 * Esto nos dice que se estan selecionado las columnas de la 1 a la n, que se estan cargando desde la tabla <nombre de tabla> y donde se aplican las condiciones de la clausula where.

 * A saber:
 * SELECT --> Trae las columnas
 * FROM --> Indica de donde
 * WHERE --> Trae las filas 

*/

SELECT atributo FROM una_tabla;

-- para traer todos los posibles datos de la tabla se usa el asterisco (*)

SELECT * FROM una_tabla;

-- para seleccionar algunas columnas solamente las indicamos separando con comas

SELECT id_institucion, nombre_institucion
FROM esq_vol_institucion

