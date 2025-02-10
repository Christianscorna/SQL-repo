-- En este archivo se resolveran los ejericicios correspondientes al práctico 4 parte 2

-- 1.1 Haga un resumen de cuantas veces ha cambiado de tareas cada voluntario. Indique el número, nombre y apellido del voluntario
SELECT v.nro_voluntario, v.nombre, v.apellido, COUNT(h.id_tarea) AS "Cambios de tareas"
FROM historico h INNER JOIN voluntario v
ON v.nro_voluntario = h.nro_voluntario
GROUP BY v.nro_voluntario, v.nombre, v.apellido

-- Otra forma de hacerlo es:
SELECT nro_voluntario, nombre, apellido, COUNT(nro_voluntario) AS "Cambios de tareas"
FROM historico INNER JOIN voluntario
USING ( nro_voluntario )
GROUP BY ( nro_voluntario, nombre, apellido )

-- 1.2 Liste los datos de contacto (nombre, apellido, e-mail y teléfono) de los voluntarios que hayan desarrollado tareas con diferencia max_horas-min_horas de hasta 5000 horas y que las hayan finalizado antes del 01/01/2000
SELECT v.nombre || ', ' || v.apellido || ', ' || v.e_mail || ', ' || v.telefono AS "Datos de contacto"
FROM voluntario v
INNER JOIN historico h ON h.nro_voluntario = v.nro_voluntario
INNER JOIN tarea t ON t.id_tarea = v.id_tarea
WHERE (t.max_horas - t.min_horas)  <= 5000 AND EXTRACT(year from h.fecha_fin) < 2000;

-- 1.3 Indique nombre, id y dirección completa de las instituciones que no poseen voluntarios con aporte de horas mayor o igual que el máximo de horas de la tarea que realiza
SELECT i.nombre_institucion, i.id_institucion, d.calle, d.ciudad, d.codigo_postal, v.horas_aportadas, t.max_horas
FROM institucion i
INNER JOIN direccion d ON d.id_direccion = i.id_direccion 
INNER JOIN voluntario v ON v.nro_voluntario = i.id_director
INNER JOIN tarea t ON t.id_tarea = v.id_tarea
WHERE v.horas_aportadas < t.max_horas

-- 1.4 Liste en orden alfabético los nombres de los países que nunca han tenido acción de voluntarios (considerando sólo información histórica, no tener en cuenta los voluntarios actuales
SELECT DISTINCT p.nombre_pais
FROM pais p
LEFT JOIN direccion d ON d.id_pais = p.id_pais
LEFT JOIN institucion i ON i.id_direccion = d.id_direccion
LEFT JOIN historico h ON h.id_institucion = i.id_institucion
WHERE h.nro_voluntario IS NULL
ORDER BY p.nombre_pais ASC;

-- 1.5 Indique los datos de las tareas que se han desarrollado históricamente y que no se están desarrollando actualmente

-- El problema es que el esquema te permite tener asignadas tareas que ya finalizaron, por lo tanto ademas de verificar que las tareas ya hayan terminado debemos buscar que no exista ningun voluntario con una tarea asignada que este registrada en el campo histórico

-- Mediante esta consulta buscamos cuales son esas tareas que estan asignadas actualmente:
SELECT v.nro_voluntario, v.id_tarea
FROM voluntario v JOIN historico h ON v.nro_voluntario = h.nro_voluntario
WHERE v.id_tarea = h.id_tarea

SELECT DISTINCT t.id_tarea , t.nombre_tarea, t.min_horas, t.max_horas, h.fecha_fin
FROM tarea t
JOIN historico h ON h.id_tarea = t.id_tarea
WHERE h.fecha_fin < CURRENT_DATE 
AND h.id_tarea NOT IN (
    SELECT v.id_tarea
    FROM voluntario v 
    JOIN historico h ON v.nro_voluntario = h.nro_voluntario
    WHERE v.id_tarea = h.id_tarea
);

-- Incluso ya sabiendo que id_tareas no queremos saber simplemente haríamos:
SELECT DISTINCT t.id_tarea , t.nombre_tarea, t.min_horas, t.max_horas, h.fecha_fin
FROM tarea t
JOIN historico h ON h.id_tarea = t.id_tarea
WHERE h.fecha_fin < CURRENT_DATE 
AND h.id_tarea NOT IN ('SA_REP', 'AD_ASST');

-- 1.6 Liste el id, nombre y máxima cantidad de horas de las tareas que se están ejecutando solo una vez y que actualmente la están realizando voluntarios de la ciudad ‘Munich’. Ordene por id de tarea
-- Ejecutamos 
SELECT id_tarea, COUNT(*)
FROM voluntario
GROUP BY id_tarea
HAVING COUNT(*) = 1;
-- Y averiguamos que las tareas que se hacen una sola vez son: PU_MAN, FI_MGR HR_REP MK_MAN AC_MGR AD_ASST PR_REP MK_REP AD_PRES AC_ACCOUNT 

SELECT t.id_tarea, t.nombre_tarea, t.max_horas
FROM tarea t
JOIN voluntario v USING(id_tarea)
JOIN institucion i USING(id_institucion)
JOIN direccion d USING(id_direccion)
WHERE d.ciudad LIKE 'Munich'
GROUP BY t.id_tarea, t.nombre_tarea, t.max_horas
HAVING COUNT(*) = 1
ORDER BY t.id_tarea;
-- Efectivamente en la salida nos dice PR_REP que es una que se ejecuto una sola vez. 

-- Otra posible solucion hubiese sido:
SELECT t.id_tarea, t.nombre_tarea, t.max_horas
FROM tarea t
JOIN voluntario v ON v.id_tarea = t.id_tarea
JOIN institucion I ON i.id_institucion = v.id_institucion
WHERE i.id_direccion = (
    SELECT d.id_direccion
    FROM direccion d
    WHERE d.ciudad = 'Munich'
)
GROUP BY t.id_tarea, t.nombre_tarea, t.max_horas
HAVING COUNT(*) = 1
ORDER BY t.id_tarea;

-- 1.7 Indique los datos de las instituciones que poseen director, donde históricamente se hayan desarrollado tareas que actualmente las estén ejecutando voluntarios de otras instituciones
SELECT i.*
FROM institucion i
JOIN historico h ON h.id_institucion = i.id_institucion
JOIN voluntario v ON v.nro_voluntario = h.nro_voluntario
WHERE i.id_director IS NOT NULL AND ((i.id_institucion != v.id_institucion) AND (v.id_tarea = h.id_tarea));

-- 1.8 Liste los datos completos de todas las instituciones junto con el apellido y nombre de su director, si poseen
SELECT i.*, v.apellido, v.nombre
FROM institucion i
LEFT JOIN voluntario v ON i.id_institucion = v.id_institucion
-- Por qué LEFT y no INNER? Porque precisamente el enunciado nos dice: TODAS las instituciones e INNER quita aquellas instituciones que contenían valores nullos 
  --> EL resultado son 106 filas para inner contra 122 para left

-- 1.9 Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de su jefe, en caso de tenerlo
SELECT (e.id_empleado || ', ' || e.nombre || ', ' || e.apellido) AS "Datos empleado", (e1.id_empleado || ', ' || e1.nombre || ', ' || e1.apellido) AS "Datos Jefe"
FROM empleado e
INNER JOIN empleado e1 ON e.id_empleado = e1.id_jefe;

-- 1.10 Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los id
SELECT e.id_empleado, e.nombre, e.apellido --, c.id_ciudad
FROM empleado e
INNER JOIN empleado j ON j.id_jefe = e.id_empleado
INNER JOIN departamento d ON d.id_departamento = j.id_departamento
INNER JOIN ciudad c ON c.id_ciudad = d.id_ciudad
WHERE c.nombre_ciudad LIKE 'Rawalpindi' 
ORDER BY e.id_empleado;

SELECT nombre_ciudad FROM ciudad WHERE id_ciudad = 175; --Efectivamente es la ciudad solicitada

-- 1.11 Liste los ids y números de inscripción de los distribuidores nacionales que hayan entregado películas en idioma Español luego del año 2010
SELECT din.id_distribuidor, din.nro_inscripcion, en.fecha_entrega
FROM nacional din
LEFT JOIN distribuidor di ON di.id_distribuidor = din.id_distribuidor 
LEFT JOIN entrega en ON en.id_distribuidor = di.id_distribuidor
LEFT JOIN renglon_entrega re ON re.nro_entrega = en.nro_entrega
WHERE re.codigo_pelicula IN (
    SELECT p.codigo_pelicula
    FROM pelicula p
    WHERE p.idioma LIKE 'Español'
) AND EXTRACT(year from en.fecha_entrega) > 2010;

-- Otra forma de hacerlo era con otro JOIN
SELECT din.id_distribuidor, din.nro_inscripcion, en.fecha_entrega, p.idioma
FROM nacional din
LEFT JOIN distribuidor di ON di.id_distribuidor = din.id_distribuidor 
LEFT JOIN entrega en ON en.id_distribuidor = di.id_distribuidor
LEFT JOIN renglon_entrega re ON re.nro_entrega = en.nro_entrega
LEFT JOIN pelicula p ON p.codigo_pelicula = re.codigo_pelicula
WHERE (p.idioma LIKE 'Español') AND EXTRACT(year from en.fecha_entrega) > 2010;

-- 1.12 Liste las películas que nunca han sido entregadas por un distribuidor nacional
SELECT p.codigo_pelicula, p.titulo, p.idioma, p.formato, p.genero
FROM pelicula p 
WHERE p.codigo_pelicula NOT IN (
    SELECT re.codigo_pelicula
    FROM renglon_entrega re 
    INNER JOIN entrega en ON en.nro_entrega = re.nro_entrega
    INNER JOIN distribuidor di ON di.id_distribuidor = en.id_distribuidor
    INNER JOIN nacional din ON din.id_distribuidor = di.id_distribuidor);
-- Nos paramos en las peliculas y vamos a filtrar las entregas

-- 1.13 Liste el apellido y nombre de los empleados que trabajan en departamentos residentes en el país Argentina y donde el jefe de departamento posee más del 40% de comisión
SELECT em.apellido, em.nombre
FROM empleado em
WHERE em.id_departamento IN (
    SELECT dep.id_departamento
    FROM departamento dep
    -- Debemos vincular al empleado con el pais
    JOIN ciudad c ON c.id_ciudad = dep.id_ciudad
    JOIN pais p ON p.id_pais = c.id_pais
    -- Y admas debemos vincular al empleado con el departamento (Habrá un empleado que sea el jefe del departamento)
    JOIN empleado j ON j.id_jefe = dep.jefe_departamento
    WHERE p.nombre_pais LIKE 'ARGENTINA' AND j.porc_comision > 0.4
);

-- 1.14 Indique los departamentos (nombre e identificador completo) que tienen más de 3 empleados con tareas con sueldo mínimo menor a 6000. Muestre el resultado ordenado por distribuidor
SELECT depto.nombre, depto.id_departamento, depto.id_distribuidor
FROM departamento depto
JOIN empleado e ON e.id_departamento = depto.id_departamento AND e.id_distribuidor = depto.id_distribuidor
WHERE e.id_tarea IN (
    SELECT t.id_tarea
    FROM tarea t
    WHERE t.sueldo_minimo < 6000
)
GROUP BY depto.nombre, depto.id_departamento, depto.id_distribuidor
HAVING COUNT(e.id_empleado) > 3
ORDER BY depto.id_distribuidor;

-- 1.15 Liste los datos de los departamentos en los que trabajan menos del 10 % de los empleados que hay registrados
SELECT COUNT(id_empleado) FROM empleado; --> Hay 35081 empleados registrados en total
SELECT ((10 * COUNT(id_empleado))/100) AS "diez por ciento" FROM empleado; --> el 10% es 3508
-- O sea que tenemos que ver en que departamentos hay menos de 3508 empleados

SELECT depto.nombre, depto.id_departamento, depto.id_distribuidor
FROM departamento depto
JOIN empleado e ON e.id_departamento = depto.id_departamento AND e.id_distribuidor = depto.id_distribuidor
GROUP BY depto.nombre, depto.id_departamento, depto.id_distribuidor
HAVING COUNT(e.id_empleado) < (
    SELECT ((10 * COUNT(id_empleado))/100) FROM empleado;
)

-- 2.1 Considere la siguiente tabla, con la inserción de datos siguiente
CREATE TABLE Equipo (
    Id int NOT NULL,
    puntos int,
    descripcion varchar(20),
    CONSTRAINT pk_equipo PRIMARY KEY(Id)
);

INSERT INTO Equipo(id, puntos) VALUES (1, null), (2, null), (3, null), (4, null)

-- que retornan las siguientes consultas?
SELECT avg(puntos), count(puntos), count(*) FROM Equipo
  -- Null, 0, 4

SELECT id, || "Su descripción es " || descripcion FROM equipo
WHERE puntos NOT IN (select distinct puntos from equipo);
  -- No retorna nada No hay puntos distinto y encima estas pidiendo que los puntos no esten incluidos en esos puntos

SELECT * FROM equipo
WHERE puntos NOT IN (select distinct puntos from equipo);
  -- Tampoco retorna nada

SELECT e1.* FROM equipo e1 
JOIN equipo e2 ON (e1.puntos = e2.puntos);
  -- Tampoco devuelve nada

-- Modifique la consulta 1 para que devuelva los valores nulos como ceros o blancos
INSERT INTO Equipo(id, puntos) VALUES (1, 0), (2, 0), (3, 0), (4, 0);
  -- Honestamente no se si el ejercicio es una tomada de pelo o es tan complicado que no lo entiendo

-- 2.2 ¿Cuáles son los voluntarios que no selecciona la siguiente consulta?
SELECT nro_voluntario, apellido, nombre FROM VOLUNTARIO
WHERE NOT (porcentaje BETWEEN 0.15 AND 0.30)
  -- La consulta no selecciona a aquellos voluntarios cuyo porcentaje de comision está entre el 15% y el 30%

-- 2.3 ¿Estas dos consultas arrojan los mismos resultados? O sino, ¿cuáles son las diferencias
SELECT I.id_institucion, count(*)
FROM institucion I LEFT JOIN voluntario V
ON (I. id_institucion = V. id_institucion)
GROUP BY I.id_institucion;

SELECT V.id_institucion, count(*)
FROM institucion I LEFT JOIN voluntario V
ON (I. id_institucion = V. id_institucion)
GROUP BY V.id_institucion;
  -- Son diferentes, no arrojan los mismo resultados. Eso es porque el primero es un left join, trae todas las tuplas de la tabla institucion y las que coinciden con voluntario, pero la otra consulta es como si fuera un rigth join ya que estan invertidas las tablas (de hecho es lo que se hace en servidores sql que no soportan la funcion right)

-- 3.1 Indique cuáles instituciones tienen solo un voluntario trabajando y ninguna tarea desarrollada -históricamente- hasta el momento
SELECT id_institucion FROM voluntario
GROUP BY id_institucion
HAVING count(nro_voluntario) = 1 -- Con esta consulta averiguamos las instituciones que tienen un solo voluntario trabajando

INTERSECT

SELECT v.id_institucion FROM voluntario v
WHERE v.nro_voluntario NOT IN (
    SELECT h.nro_voluntario
    FROM historico h
); -- Con esta subconsulta se obtienen aquellas instituciones que no han tenido nunca una tarea desarrollada
-- Nos da como resultado que las instituciones 70, 40 y una null cumplen con ambas restricciones

-- 3.2 Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ o que son coordinadores, y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente 
SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion
JOIN pais p ON p.id_pais = d.id_pais
JOIN continente c ON c.id_continente = p.id_continente
WHERE c.nombre_continente = 'Europeo' OR v.nro_voluntario IN ( --verificamos que coincida el nombre del continente y que ademas el voluntario sea ese coordinador
  SELECT v2.id_coordinador
  FROM voluntario v2
  WHERE v2.id_coordinador IS NOT NULL
)

INTERSECT

SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion 
WHERE i.id_director IS NOT NULL AND i.id_director = v.nro_voluntario; --Verificamos que tenga director y que ademas ese voluntario sea el director

-- Liste todos los voluntarios que no pertenecen a instituciones ubicadas en el continente Europeo
SELECT v.nombre, v.apellido, v.nro_voluntario, c.id_continente
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion
JOIN pais p ON p.id_pais = d.id_pais
JOIN continente c ON c.id_continente = p.id_continente

EXCEPT

SELECT v.nombre, v.apellido, v.nro_voluntario, c.id_continente
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion
JOIN pais p ON p.id_pais = d.id_pais
JOIN continente c ON c.id_continente = p.id_continente
WHERE c.id_continente = 1;

-- 3.4 Indique los voluntarios que históricamente hayan trabajado para todas las instituciones, ordenando el resultado por nombre de voluntario
-- Te la debo

-- 3.5 Determine cuáles tareas se están ejecutando en todas las instituciones
-- Te la debo

-- De adicionales

-- 1 Realice un resumen por país, indicando el nombre del país y la cantidad de voluntarios mayores de edad. Tenga en cuenta sólo aquellos voluntarios que pertenezcan a instituciones con más de 4 voluntarios 
SELECT p.nombre_pais, COUNT(v.nro_voluntario) as "Mayores"
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion 
JOIN pais p ON p.id_pais = d.id_pais
WHERE (EXTRACT(year from CURRENT_DATE) - EXTRACT(year from v.fecha_nacimiento)) > 18
GROUP BY p.nombre_pais
HAVING COUNT(v.nro_voluntario) > 4;

-- 2 Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente por apellido y nombre 
SELECT v.nro_voluntario, v.nombre, v.apellido
FROM voluntario v
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion
JOIN  pais p ON p.id_pais = d.id_pais
JOIN continente c ON c.id_continente = p.id_continente
WHERE c.nombre_continente = 'Europeo' AND v.nro_voluntario = i.id_director
ORDER BY v.nombre, v.apellido;

-- 3 Indique el id y el nombre de las instituciones que tengan más de 4 voluntarios con tareas de no más de 3500 horas estimadas, o que las horas aportadas no superen las 4000
SELECT i.id_institucion, i.nombre_institucion, COUNT(v.nro_voluntario) as "Cant voluntarios"
FROM institucion i
JOIN voluntario v ON v.id_institucion = i.id_institucion
WHERE v.horas_aportadas < 4000
GROUP BY i.id_institucion, i.nombre_institucion
HAVING COUNT(v.nro_voluntario) > 4;

-- 4 Liste los datos completos de las instituciones en las que se estén ejecutando más del 10% del total de las tareas (distintas)
-- queremos el 10 % de las tareas
SELECT (10 * COUNT(DISTINCT id_tarea))/100 AS "10%" FROM tarea;

SELECT i.nombre_institucion, i.id_institucion
FROM institucion i
JOIN voluntario v ON v.id_institucion = i.id_institucion
JOIN tarea t ON t.id_tarea = v.id_tarea
GROUP BY i.nombre_institucion, i.id_institucion
HAVING COUNT(DISTINCT t.id_tarea) > ((10 * COUNT(DISTINCT t.id_tarea))/100)

-- 5 Liste el nombre y apellido de los voluntarios que pertenecen a instituciones de la provincia ‘Washington’ y donde el director de la institución ha cumplido con 2 o más tareas
SELECT v.nombre, v.apellido
FROM voluntario v 
JOIN institucion i ON i.id_institucion = v.id_institucion
JOIN direccion d ON d.id_direccion = i.id_direccion
WHERE d.provincia = 'Washington' AND i.id_director IN (
  SELECT i2.id_director
  FROM institucion i2
  JOIN voluntario v2 ON v2.nro_voluntario = i2.id_director
  JOIN tarea t ON t.id_tarea = v2.id_tarea
  GROUP BY i2.id_director
  HAVING (COUNT(t.id_tarea)) >= 2
);

-- 6 Liste nombre, apellido y teléfono de los 5 voluntarios que han participado en la mayor cantidad de tareas
SELECT v.nombre, v.apellido, v.telefono, COUNT(t.id_tarea) "Total tareas"
FROM voluntario v 
JOIN  tarea t ON t.id_tarea = v.id_tarea
GROUP BY v.nombre, v.apellido, v.telefono
ORDER BY COUNT(t.id_tarea) DESC
LIMIT 5;

-- 7 Liste los identificadores y títulos de aquellas películas que registran la mayor cantidad de entregas y la menor cantidad de ellas, junto con la cantidad respectiva
SELECT p.codigo_pelicula, p.titulo, MAX(re.cantidad)
FROM pelicula p
JOIN renglon_entrega re ON re.codigo_pelicula = p.codigo_pelicula
GROUP BY p.codigo_pelicula, p.titulo

UNION

SELECT p.codigo_pelicula, p.titulo, MIN(re.cantidad)
FROM pelicula p
JOIN renglon_entrega re ON re.codigo_pelicula = p.codigo_pelicula
GROUP BY p.codigo_pelicula, p.titulo

-- 8 Obtenga los datos de los videos que han recibido entregas por parte de distribuidores nacionales y también internacionales, ordenados por razón social
SELECT v.id_video, v.razon_social, v.direccion, v.telefono, v.propietario
FROM video v 
JOIN entrega en ON en.id_video = v.id_video
JOIN distribuidor d ON d.id_distribuidor = en.id_distribuidor
WHERE d.id_distribuidor IN (
  SELECT din.id_distribuidor
  FROM nacional din
)

UNION 

SELECT v.id_video, v.razon_social, v.direccion, v.telefono, v.propietario
FROM video v 
JOIN entrega en ON en.id_video = v.id_video
JOIN distribuidor d ON d.id_distribuidor = en.id_distribuidor
WHERE d.id_distribuidor IN (
  SELECT inter.id_distribuidor
  FROM internacional inter
);

-- 9 Liste id, nombre y apellido de los empleados que no son jefes de departamento
SELECT e.id_empleado, e.nombre, e.apellido
FROM empleado e

EXCEPT

SELECT e.id_empleado, e.nombre, e.apellido
FROM empleado e
JOIN departamento d ON d.id_departamento = e.id_departamento AND d.id_distribuidor = e.id_distribuidor
WHERE e.id_jefe = d.jefe_departamento;

-- 10 Indique si hay distribuidores (nacionales o internacionales) que efectuaron entregas a todos los videos
SELECT din.id_distribuidor
FROM nacional din
JOIN distribuidor di IN di.id_distribuidor = din.id_distribuidor
JOIN entrega en ON en.id_distribuidor = di.id_distribuidor
WHERE en.id_video IN (
  SELECT v.id_video 
  FROM video v
)

UNION 

SELECT dii.id_distribuidor
FROM internacional dii
JOIN distribuidor di ON di.id_distribuidor = dii.id_distribuidor
JOIN entrega en ON en.id_distribuidor = di.id_distribuidor
WHERE en.id_video IN (
  SELECT v.id_video
  FROM video v
);

-- 11 Determine los videos que han recibido entregas de parte de todos los distribuidores internacionales
SELECT v.id_video, v.razon_social, v.propietario
FROM video v 
JOIN entrega en ON en.id_video = v.id_video 
JOIN distribuidor di ON en.id_distribuidor = di.id_distribuidor

EXCEPT

SELECT v.id_video, v.razon_social, v.propietario
FROM video v 
JOIN entrega en ON en.id_video = v.id_video 
JOIN distribuidor di ON en.id_distribuidor = di.id_distribuidor
JOIN nacional din ON din.id_distribuidor = di.id_distribuidor;