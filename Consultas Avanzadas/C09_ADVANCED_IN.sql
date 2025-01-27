/*
  En esta oportunidad veremos la cláusula IN en profundidad

  --> Anteriormente dijimos que es una abreviación de muchas consultas OR...

  * IN como subconsulta devuelve un conjunto de valores, de esta forma podemos hacer subconsultas a una tabla, por decirlo de alguna manera.

  * Se recomienda que se pruebe antes la subconsulta por separado, para verificar que nos esté devolviendo lo que le estamos pidiendo

 */

-- Por ejemplo Liste el apellido y nombre de los empleados que trabajan en departamentos de Argentina.

-- Primero necesitamos el subconjunto que tiene por id_pais a ARGENTINA 
SELECT id_pais FROM pais WHERE nombre_pais = 'ARGENTINA'

-- Luego necesitamos al subconjunto que tiene la ciudad (Que tiene al pais)
SELECT c.id_ciudad
FROM ciudad c
WHERE c.id_pais IN (
    SELECT id_pais FROM pais WHERE nombre_pais = 'ARGENTINA'
)

-- Seguimos retrocediendo en el esquema y ahora vamos a necesitar los departamentos (Que tienen la ciudad (Que tiene al pais))
SELECT d.id_departamento
FROM departamento d 
WHERE d.id_ciudad IN (
    SELECT c.id_ciudad FROM ciudad c WHERE c.id_pais IN (
        SELECT id_pais FROM pais WHERE nombre_pais = 'ARGENTINA'
    )
)

-- Retrocedemos una vez mas en el esquema hasta alcanzar los empleados (Que estan en los departamentos (Que tienen la ciudad (Que tiene al pais)))
SELECT e.apellido, e.nombre
FROM empleado e
WHERE (e.id_departamento, e.id_distribuidor) IN (
    SELECT d.id_departamento, d.id_distribuidor FROM departamento d WHERE d.id_ciudad IN (
        SELECT c.id_ciudad FROM ciudad c WHERE c.id_pais IN (
            SELECT id_pais FROM pais WHERE nombre_pais = 'ARGENTINA'
        )
    )
)
-- Importante, estar atento a las PK en este caso el empleado se ensambla con el departamento mediante una PK compuesta. Ojito!

-- ¿Se puede con IN? Si, se puede. ¿Es más fácil con JOIN? Si, es mucho más facil:
SELECT e.apellido, e.nombre FROM empleado e 
INNER JOIN departamento d ON e.id_departamento = d.id_departamento AND e.id_distribuidor = d.id_distribuidor
INNER JOIN ciudad c ON d.id_ciudad = c.id_ciudad
INNER JOIN pais p ON c.id_pais = p.id_pais
WHERE p.nombre_pais = 'ARGENTINA';

