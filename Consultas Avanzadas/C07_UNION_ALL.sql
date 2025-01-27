/*
  UNION ALL Obtiene la relacion que contiene las tuplas que se encuentran ya sea en las tablas A y B, con la diferencia respecto de UNION que preserva los elementos duplicados
  --> Siguiendo con el ejemplo de UNION, dados dos conjuntos A = [1, 2, 3] y B = [3, 4, 5]
  UNION ALL(A, B) --> [1, 2, 3, 3, 4, 5] } Considera repetidos
 */

-- Por ejemplo si quisiéramos las tareas que se hacen actualmente y anteriormente:
SELECT id_tarea FROM voluntario
UNION ALL
SELECT id_tarea FROM historico
-- La salida a la anterior consulta son 118 filas