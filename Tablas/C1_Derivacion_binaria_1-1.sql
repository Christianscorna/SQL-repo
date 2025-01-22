-- En el siguiente ejemplo veremos las relaciones binarias 

-- Imaginen que un Alumno que cursa su primer año de facultad debe tener un profesor de tutor y que todos los años un profesor pueda ser tutor de un alumno.
-- Prestar atención a las palabras clave: "debe" --> Indica la obligatoriedad, "puede" --> Indica la opcionalidad, no es necesario.

CREATE TABLE ALUMNO (
    LU int NOT NULL,
    nombre varchar(20) NOT NULL,
    fecha_nacimiento date NOT NULL
    CUIL int NOT NULL
);

ALTER TABLE ALUMNO
    ADD CONSTRAINT PK_ALUMNO
    PRIMARY KEY ALUMNO(LU);

-- el alumno debe tener el cuil porque no pueden existir ejemplares de alumno sin un profesor a cargo
ALTER TABLE ALUMNO
    ADD CONSTRAINT FK_ALUMNO
    FOREIGN KEY (CUIL)
    REFERENCES PROFESOR(CUIL);

CREATE TABLE PROFESOR (
    CUIL int NOT NULL,
    nombre varchar(20) NOT NULL,
    apellido varchar(25) NOT NULL
    e_mail varchar(15) NOT NULL
);

ALTER TABLE PROFESOR
    ADD CONSTRAINT PK_PROFESOR
    PRIMARY KEY PROFESOR(CUIL);
