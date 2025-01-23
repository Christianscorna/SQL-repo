/*
 * Por defecto la cláusula SELECT se trae todas las filas incluidos los resultados que se repiten, si quisiéramos tener solamente los datos sin considerar las opciones repetidas le podemos indicar que traiga todos los resultados diferentes con la palabra reservada DISTINCT
*/

CREATE TABLE USERS (
    Nombre varchar(30),
    Apellido varchar(30),
    Edad int NOT NULL
);

SELECT * FROM users;

-- En este caso estamos seleccionando todo de la tabla usuarios

/*
Nombre     | Apellido    | Edad
Christian	Scornaienchi    20
Posho		0               0
Jorgelin	Ernandes	    34
Posho	    Ramone  	    19
Julian	    Alvarez	        32
Roberto	    Tito	        52
*/