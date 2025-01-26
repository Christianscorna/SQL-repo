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

