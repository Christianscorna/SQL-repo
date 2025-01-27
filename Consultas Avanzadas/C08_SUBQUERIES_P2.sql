/*
  Continuamos profundizando en las consultas anidadas.

  Consultas de una sola fila: Aquellas consultas que emplean cualquier operador de comparación antes visto es una consulta de una sola fila
  (>, <, >=, <=, <>, !=)
 */

-- Se desea seleccionar los voluntarios que realizan la misma tarea que el voluntario 141 y que aportan más horas que el voluntario 143

-- Notar que en un principio es más facil separar las consultas es decir primero nos preguntamos: 
-- seleccionar los voluntarios que realizan la misma tarea que el voluntario 141
SELECT id_tarea FROM voluntario WHERE nro_voluntario = 141;

-- aportan más horas que el voluntario 143 --> Para eso necesitamos las horas aprotadas del voluntario 143
SELECT horas_aportadas FROM voluntario WHERE nro_voluntario = 143;

-- Sabemos que estas dos condiciones necesitan cumplirse, por lo tanto con un AND podemos lograr este objetivo
SELECT * 
FROM voluntario
WHERE id_tarea = (
    SELECT id_tarea FROM voluntario
    WHERE nro_voluntario = 141
) AND horas_aportadas > (
    SELECT horas_aportadas -- Es importante comparar siempre con los mismo campos (O que al menos tengan el mismo tipo de dato)
    FROM voluntario
    WHERE nro_voluntario = 143
);

-- Es importante destacar que la subquery debe devolver una sola fila!!!

SELECT MIN(horas_aportadas) FROM voluntario -- Salida: min(2100)

-- Esto lo puedo usar para saber que cantidad de voluntarios aportan la mínima cantidad de horas
SELECT * FROM voluntario
WHERE horas_aportadas = ( SELECT MIN(horas_aportadas) FROM voluntario );
-- En realidad no es otra coas que hacer:
SELECT * FROM voluntario
WHERE horas_aportadas = 2100;
-- Pero solo porque conocemos el dato, si no lo conociéramos este tipo de consultas nos ayuda a automatizar 

-- Y si quisiéramos el máximo?
SELECT * FROM voluntario
WHERE horas_aportadas = ( SELECT MAX(horas_aportadas) FROM voluntario );
-- Es exactamente lo mismo, cambiando a MAX

-- ¿Cuál es el promedio de horas que trabajan los voluntarios?
SELECT ROUND(AVG(horas_aportadas), 2) FROM voluntario; -- Salida: seis mil y pico

-- Entonces ¿Cómo sabemos qué voluntarios aportan más horas que el promedio?
SELECT * FROM voluntario
WHERE horas_aportadas > ( SELECT ROUND(AVG(horas_aportadas), 2) FROM voluntario );

/*
  Subconsultas en HAVING

  --> Se ejecuta en primer lugar la subconsulta. 
  --> Esta nos devuelve resultados a la cláusula HAVING (correspondiente a la consulta principal) que luego se usan para chequear la condición de grupo.
 */

-- Si quisiéramos saber las instituciones donde la mínima cantidad de horas que aportan sus voluntarios es mayor que la mínima cantidad de horas que aportan los de la institución 40

-- Primero buscamos la mínima cantidad de horas que aportan los voluntarios de la institución 40
SELECT MIN(horas_aportadas)
FROM voluntario
WHERE id_institucion = 40; -- Devuelve 6500, es decir que queremos ahora las instituciones (GRUPO) donde la cantidad minima de horas que aportan sus voluntarios supera (ES MAYOR QUE) 6500, una pavada ahora que tenemos el dato

SELECT id_institucion, MIN(horas_aportadas) AS 'Aporte de otras instituciones'
FROM voluntario 
GROUP BY id_institucion
HAVING MIN(horas_aportadas) > 6500; -- Solo que en lugar de poner el dato, automatizamos y clavamos la subconsulta

SELECT id_institucion, MIN(horas_aportadas) AS 'Aporte de otras instituciones'
FROM voluntario 
GROUP BY id_institucion
HAVING MIN(horas_aportadas) > (
    SELECT MIN(horas_aportadas)
    FROM voluntario
    WHERE id_institucion = 40 );

-- Ejercicio práctico:
-- ¿Cuáles son las tareas cuyo promedio de horas aportadas por tarea de los voluntarios nacidos a partir del año 1995 es superior al promedio general de dicho grupo de voluntarios?

-- Primero vamos a buscar promedio general de horas aportadas
SELECT ROUND(AVG(horas_aportadas), 2)
FROM voluntario
WHERE EXTRACT(year from fecha_nacimiento) > 1995; -- Salida: 5844.44


-- Luego buscamos el promedio de horas por tarea
SELECT id_tarea, ROUND(AVG(horas_aportadas), 2)
FROM voluntario
WHERE EXTRACT(year from fecha_nacimiento) > 1995
GROUP BY id_tarea;

-- Ahora solamente nos quedaría comparar los datos para eso usamos, la cláusula having
SELECT id_tarea, ROUND(AVG(horas_aportadas), 2)
FROM voluntario
WHERE EXTRACT(year from fecha_nacimiento) > 1995
GROUP BY id_tarea
HAVING ROUND(AVG(horas_aportadas), 2) > (
    SELECT ROUND(AVG(horas_aportadas), 2)
    FROM voluntario
    WHERE EXTRACT(year from fecha_nacimiento) > 1995
);