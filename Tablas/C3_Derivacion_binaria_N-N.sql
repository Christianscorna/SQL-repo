-- Tanto en este tipo de relación binaria como unaria de cardinalidad N a N se deriva de la siguiente manera:
-- Se crea una nueva tabla
-- Su clave es la yuxtaposición de las claves de las entidades partícipes
-- Seran claves extranjeras, porque se las "trae" de afuera.

-- Imaginemos que un alumno puede cursar varias carreras y que una carrera puede ser cursada por varios alumnos:

CREATE TABLE ALUMNO (
    LU int NOT NULL,
    nombre varchar(20) NOT NULL,
    fecha_nacimiento date NOT NULL
);

ALTER TABLE ALUMNO
    ADD CONSTRAINT PK_ALUMNO
    PRIMARY KEY (LU);

CREATE TABLE CARRERA (
    id_carrera int NOT NULL,
    nombre_carrera varchar(20) NOT NULL,
    plan_estudios varchar(45) NOT NULL
);

ALTER TABLE CARRERA 
    ADD CONSTRAINT PK_CARRERA
    PRIMARY KEY (id_carrera);

-- Ahora la relación:

CREATE TABLE CURSA (
    LU int NOT NULL,
    id_carrera int NOT NULL
); -- si tuviera atributos colocarlos, ejem: id_cursada, cant_alumnos, etc.

ALTER TABLE CURSA
    ADD CONSTRAINT PK_CURSA
    PRIMARY KEY (LU, id_carrera); -- cuando tenemos más de un atributo identificador, podemos colocarlos todos separados mediante comas.

ALTER TABLE CURSA 
    ADD CONSTRAINT FK_CURSA_ALUMNO
    FOREIGN KEY (LU)
    REFERENCES ALUMNO(LU);

ALTER TABLE CURSA 
    ADD CONSTRAINT FK_CURSA_CARRERA
    FOREIGN KEY (id_carrera)
    REFERENCES CARRERA(id_carrera);