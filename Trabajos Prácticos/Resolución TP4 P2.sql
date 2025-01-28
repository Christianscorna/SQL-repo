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


