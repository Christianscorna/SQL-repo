-- En este archivo se resolveran los ejericicios correspondientes al práctico 4 parte 1

-- 1.1 Liste los códigos de las distintas tareas que están realizando actualmente los voluntarios
SELECT DISTINCT id_tarea
FROM voluntario;

-- 1.2 Genere un listado con los distintos identificadores de los coordinadores
SELECT DISTINCT id_coordinador 
FROM voluntario
WHERE id_coordinador IS NOT NULL;

-- 2.1 Muestre los apellidos, nombres y e_mail de los voluntarios que llevan aportadas más de 1.000 horas, ordenados por apellido
SELECT apellido, nombre, e_mail, horas_aportadas AS Aportes
FROM voluntario
WHERE horas_aportadas > 1000
ORDER BY apellido ASC;

-- 2.2 Muestre el apellido y teléfono de todos los voluntarios de las instituciones 20 y 50 en orden alfabético por apellido y nombre
SELECT apellido, nombre, id_institucion AS Institucion
FROM voluntario
WHERE id_institucion IN (20, 50)
ORDER BY apellido, nombre ASC;

-- 2.3 Muestre el apellido, nombre y el e-mail de todos los voluntarios cuyo teléfono comienza con '+11'. Coloque como encabezado de las columnas los títulos 'Apellido y Nombre' y 'Dirección de mail'
SELECT apellido || ', ' || nombre AS "Apellido y Nombre", e_mail AS "Email", telefono AS "Teléfono"
FROM voluntario
WHERE telefono LIKE '+11%';

-- 3.1 Muestre apellido, nombre e identificador de todos los empleados que no cobran porcentaje de comisión. Ordene por apellido
SELECT apellido || ',    ' || nombre || ',    ' || id_empleado AS "Datos de Empleados", porc_comision
FROM empleado
WHERE NOT (porc_comision <> 0 AND porc_comision IS NOT NULL)
ORDER BY apellido ASC
LIMIT 30;

-- 3.2 Muestre los datos de los distribuidores internacionales que no tienen registrado teléfono
SELECT * FROM distribuidor
WHERE telefono IS NULL;

-- 3.3 Seleccione la clave y el nombre de los departamentos sin jefe
SELECT id_departamento, nombre
FROM departamento
WHERE jefe_departamento IS NULL;

-- 4.1 Haga un listado de los voluntarios donde se muestre el apellido y nombre (concatenados y separados por una coma) y la fecha de nacimiento (como año, mes y día), ordenados por año de nacimiento
SELECT apellido || ', ' || nombre AS "Apellido y Nombre", to_char(fecha_nacimiento, 'YYYY-MM-DD') AS "Fecha de Nacimiento"
FROM voluntario
ORDER BY EXTRACT (year from fecha_nacimiento)
LIMIT 20;
-- NOTA: También se puede pasar otros formatos de fecha como --> DD-MM-YYYY || MM-DD-YYYY etc 

-- 4.2 Muestre todos los voluntarios nacidos a partir de 1998 con más de 5000 horas aportadas, ordenados por su identificador
SELECT apellido || ', ' || nombre AS "Apellido y Nombre", EXTRACT (year from fecha_nacimiento) AS "Año de Nacimiento", horas_aportadas AS "Horas de Aporte", nro_voluntario
FROM voluntario
WHERE EXTRACT (year from fecha_nacimiento) > 1998 AND horas_aportadas > 5000
ORDER BY nro_voluntario
LIMIT 20;

-- 4.3 Haga un listado de los voluntarios que cumplen años hoy (día y mes actual), indicando el nombre, apellido y su edad (en años)
SELECT nombre, apellido, nro_voluntario, EXTRACT(year from AGE(CURRENT_DATE, fecha_nacimiento)) AS "Edad del voluntario"
FROM voluntario
WHERE EXTRACT(month from CURRENT_DATE) = EXTRACT(month from fecha_nacimiento) 
  AND EXTRACT(day from CURRENT_DATE) = EXTRACT(day from fecha_nacimiento);
-- NOTA tambien se podría tomar la fecha completa y listo --> AGE(CURRENT_DATE, fecha_nacimiento)

-- 5.1 Seleccione los datos de las 10 primeras direcciones ordenadas de acuerdo a su identificador
SELECT calle || ',    ' || codigo_postal || ',    ' || ciudad AS "Datos Direcciones"
FROM direccion
ORDER BY id_direccion
LIMIT 10;

-- 5.2 Si se desea paginar la consulta que selecciona los datos de las tareas cuyo nombre comience con O, A o C, y hay 5 registros por página, muestre la consulta que llenaría los datos para la 3er. página
SELECT id_tarea, nombre_tarea
FROM tarea
WHERE nombre_tarea LIKE 'O%' OR nombre_tarea LIKE 'A%' OR nombre_tarea LIKE 'C%'
LIMIT 5
OFFSET 10; 

-- 6.1 Recupere la cantidad mínima, máxima y promedio de horas aportadas por los voluntarios de más de 25 años
  -- Solución a priori
  SELECT MIN(horas_aportadas), MAX(horas_aportadas), ROUND(AVG(horas_aportadas), 2)
  FROM voluntario
  WHERE EXTRACT(year from fecha_nacimiento) > 25;

  -- Solución agrupando por bloques de edad superiores a 25 años
  SELECT EXTRACT(year from fecha_nacimiento) AS edad, MIN(horas_aportadas), MAX(horas_aportadas), ROUND(AVG(horas_aportadas), 2)
  FROM voluntario
  GROUP BY EXTRACT(year from fecha_nacimiento)
  HAVING EXTRACT(year from fecha_nacimiento) > 25
  ORDER BY edad;

-- 6.2 Obtenga la cantidad de voluntarios que tiene cada institución
SELECT id_institucion, count(nro_voluntario) AS "Cantidad de voluntarios"
FROM voluntario
GROUP BY id_institucion
ORDER BY id_institucion;

-- 6.3 Muestre la fecha de nacimiento del voluntario más joven y del más viejo
SELECT MIN(fecha_nacimiento) AS "Voluntario mas antiguo",  MAX(fecha_nacimiento) AS "Voluntario mas jóven"
FROM voluntario;

-- 6.4 Considerando los datos históricos de cada voluntario, indique la cantidad de tareas distintas que cada uno ha realizado
SELECT nro_voluntario, COUNT(DISTINCT id_tarea) AS "Tareas realizadas"
FROM historico
GROUP BY nro_voluntario
ORDER BY nro_voluntario;

-- 6.5 Se quiere conocer los coordinadores que tienen a su cargo menos de 3 voluntarios dentro de cada institución
SELECT id_coordinador, COUNT(nro_voluntario) AS "Voluntarios a cargo"
FROM voluntario
GROUP BY id_coordinador
HAVING COUNT(nro_voluntario) < 3;

-- ADICIONALES

-- 1 Realice un listado donde, por cada voluntario, se indique las distintas instituciones y tareas que ha desarrollado (considere los datos históricos)
SELECT nro_voluntario, COUNT(DISTINCT id_tarea) AS "Tareas diferentes", COUNT(DISTINCT id_institucion) AS "Instituciones diferentes"
FROM historico
GROUP BY nro_voluntario
ORDER BY nro_voluntario;

-- 2 Muestre el apellido, la tarea y las horas aportadas de todos los voluntarios cuyas tareas sean de “SA_REP” o “ST_CLERK” y cuyas horas aportadas no sean iguales a 2.500, 3.500 ni 7.000
SELECT apellido, id_tarea, horas_aportadas
FROM voluntario
WHERE id_tarea IN ('SA_REP', 'ST_CLERK') AND horas_aportadas NOT IN (2500, 3500, 7000);

  -- Variante, agrupando por tarea
  SELECT id_tarea, COUNT(horas_aportadas) AS "Aportes totales", SUM(horas_aportadas) AS "Horas totales aportadas"
  FROM voluntario
  WHERE id_tarea IN ('SA_REP', 'ST_CLERK') AND horas_aportadas NOT IN (2500, 3500, 7000)
  GROUP BY id_tarea;

-- 3 Muestre los datos completos de las instituciones que posean director
SELECT * FROM institucion
WHERE id_director IS NOT NULL;

-- 4 Muestre el apellido e identificador de la tarea de todos los voluntarios que no tienen coordinador.
SELECT nombre, apellido, id_tarea
FROM voluntario
WHERE id_coordinador IS NULL;

-- 5 Muestre el apellido, las horas aportadas y el porcentaje de donación para todos los voluntarios que aportan horas (aporte > 0 o distinto de nulo). Ordene los datos de forma descendente según las horas aportadas y porcentajes de donaciones
SELECT apellido, horas_aportadas, porcentaje
FROM voluntario
WHERE horas_aportadas > 0 OR horas_aportadas IS NOT NULL
ORDER BY horas_aportadas DESC, porcentaje;

-- 6 Liste los identificadores de aquellos coordinadores que coordinan a más de 8 voluntarios
SELECT id_coordinador, COUNT(nro_voluntario)
FROM voluntario
GROUP BY id_coordinador
HAVING COUNT(nro_voluntario) > 8
ORDER BY id_coordinador;

-- 7 Muestre el identificador de las instituciones y la cantidad de voluntarios que trabajan en ellas, sólo de aquellas instituciones que tengan más de 10 voluntarios
SELECT id_institucion, COUNT(nro_voluntario) AS "Voluntarios que laburan"
FROM voluntario
GROUP BY id_institucion
HAVING COUNT(nro_voluntario) > 10;

-- 8 Liste los apellidos, nombres y e-mails de los empleados con cuentas de gmail y cuyo sueldo sea superior a 1000.
SELECT apellido, nombre, e_mail 
FROM empleado
WHERE sueldo > 1000;
 -- NOTA: Los email no admiten nulos asi que no hace falta consultar por IS NOT NULL a e_mail

 -- 9 Muestre los códigos de películas que han recibido entre 3 y 5 entregas. (cantidad de entregas, NO cantidad de películas entregadas)
SELECT codigo_pelicula, cantidad
FROM renglon_entrega
WHERE cantidad BETWEEN 3 AND 5;

-- 10 Liste la cantidad de películas que hay por cada idioma.
SELECT idioma, COUNT(codigo_pelicula) AS "Películas por Idioma"
FROM pelicula
GROUP BY idioma
ORDER BY idioma;

-- 11 Calcule la cantidad de empleados por departamento
SELECT id_departamento, COUNT(id_empleado) AS "Empleados por Deptartamento"
FROM empleado
GROUP BY id_departamento
ORDER BY id_departamento;

-- Fin Trabajo Práctico N°4 Parte 1