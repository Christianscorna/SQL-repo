/*
 Los JOIN nos permiten vincular dos o mas tablas.

 La forma mas natural de vincular 2 tablas es mediante un CROSS JOIN que lo hacemos de manera natural, el cual nos devuelve un producto cartesiano. 
 */

SELECT nombre_institucion
-- Le colocamos la condición de ensamble
FROM institucion i, direccion d -- renombramos las tablas
WHERE i.id_direccion = d.id_direccion AND d.provincia = 'Texas';

-- En codigo es equivalente a haber escrito:
SELECT nombre_institucion
FROM institucion i
CROSS JOIN direccion d
WHERE i.id_direccion = d.id_direccion AND d.provincia = 'Texas';

/*
  El producto cartesiano (o "cross join") combina cada tupla de la primera tabla con cada tupla de la segunda tabla, para obtener tuplas compuestas por atributos de las dos relaciones combinadas 
   --> Genera todas las posibles combinaciones de filas entre las dos tablas
   --> Luego filtra las tuplas que satisfacen la condición 
 */