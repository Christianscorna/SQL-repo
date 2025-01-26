/*
 Los JOIN nos permiten vincular dos o mas tablas.

  INNER JOIN resuelve de manera mas eficiente que el producto cartesiano

  Solo devuelve los datos que coinciden en AMBAS tablas
 */

SELECT *
FROM institucion i INNER JOIN direccion d
ON i.id_direccion = d.id_direccion; -- ON es la condicion mediante la cual se van a combinar las tablas

-- Tambien podemos obviar el INNER, SQL ya sabe que es una union del tipo INNER
SELECT *
FROM institucion i JOIN direccion d
ON i.id_direccion = d.id_direccion; 

 -- Ademas si Si la/s columna/s por la/s cual/es se ensambla se llama/n igual en ambas tablas podemos emplear la cláusula USING 
SELECT * FROM institucion JOIN direccion
USING (id_direccion) -- De esta manera nos queda mucho más cómodo

