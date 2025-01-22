-- Para el siguiente ejemplo de derivacion unaria vamos a considerar el típico caso donde un alumno de una facultad se relaciona consigo mismo al tener la posibilidad de ser tutor de otro/s alumnos

CREATE TABLE ALUMNO (
    LU int NOT NULL,
    nombre varchar(20) NOT NULL,
    apellido varchar(20) NOT NULL,
    LU_tutor int -- damos la posibilidad de nulo
);

-- luego modificamos la tabla para que LU sea PK de ALUMNO
ALTER TABLE ALUMNO 
    ADD CONSTRAINT PK_ALUMNO
    PRIMARY KEY(LU);

ALTER TABLE ALUMNO
    ADD CONSTRAINT FK_ALUMNO
    FOREIGN KEY (LU_tutor)
    REFERENCES ALUMNO(LU);

