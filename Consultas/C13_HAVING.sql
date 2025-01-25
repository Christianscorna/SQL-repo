/*
 Utilizamos la cláusula HAVING para restringir grupos
 */

-- Por ejemplo queremos los cordinadores que tengan mas de 7 voluntarios
SELECT id_coordinador, COUNT(nro_voluntario) AS CantidadVoluntarios
FROM voluntario
GROUP BY id_coordinador
HAVING COUNT(nro_voluntario) > 7
ORDER BY CantidadVoluntarios DESC;

-- ¿Cuáles son las tareas que tienen más de 10 voluntarios?
SELECT id_tarea, COUNT(nro_voluntario) AS CantidadVoluntarios
FROM voluntario
GROUP BY (id_tarea)
HAVING COUNT(nro_voluntario) > 10;

-- ¿Cuál es el promedio de horas aportadas por tarea solo de aquellos voluntarios nacidos a partir del año 2000?
SELECT nro_voluntario, ROUND(AVG(horas_aportadas), 2) AS PromedioHoras, fecha_nacimiento
FROM voluntario
WHERE EXTRACT(year from fecha_nacimiento) >= 2000
GROUP BY nro_voluntario
ORDER BY nro_voluntario;
