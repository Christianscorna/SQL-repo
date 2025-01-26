/*
  UNION Obtiene la relacion que contiene las tuplas que se encuentran ya sea en las tablas A y B
  --> Es la típica relación de unión del álgebra de conjuntos.
  --> Dados dos conjuntos A = [1, 2, 3] y B = [3, 4, 5]
  UNION(A, B) --> [1, 2, 3, 4, 5] } No considera repetidos
 */

 -- Por ejemplo si quisiéramos las tareas que se hacen actualmente y anteriormente:
 SELECT id_tarea FROM voluntario
 UNION
 SELECT id_tarea FROM historico
-- La salida a la anterior consulta son 19 filas

