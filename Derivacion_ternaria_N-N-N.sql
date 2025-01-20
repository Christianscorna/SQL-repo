-- Vamos a crear una tabla por entidad y una para la relación, que la llamaremos R
-- Imaginemos que queremos modelar los libros que un profesor utiliza para un determinado curso, venimos de asumir que las tres entidades participan siempre si o si de la relación para poder modelarlos como relación ternaria.

-- tale: profesor
CREATE TABLE PROFESOR (
    id_profesor int NOT NULL
);

ALTER TABLE PROFESOR
    ADD CONSTRAINT PK_PROFESOR
    PRIMARY KEY (id_profesor);

-- table: libro
CREATE TABLE LIBRO (
    id_libro int NOT NULL
);

ALTER TABLE LIBRO
    ADD CONSTRAINT PK_LIBRO
    PRIMARY KEY (id_libro);

-- table: materia
CREATE TABLE MATERIA (
    id_materia int NOT NULL
);

ALTER TABLE MATERIA
    ADD CONSTRAINT PK_MATERIA
    PRIMARY KEY (id_materia);

-- La clave primaria de una relación ternaria se compone como las claves primarias de las entidades participantes, que a la vez las trae como extranjeras

CREATE TABLE RELACION_R (
    id_profesor int NOT NULL,
    id_libro int NOT NULL,
    ID id_materia int NOT NULL
);

ALTER TABLE RELACION_R
    ADD CONSTRAINT PK_RELACION_R
    PRIMARY KEY (id_profesor, id_libro, id_materia);

ALTER TABLE RELACION_R
    ADD CONSTRAINT FK_RELACION_PROFESOR
    FOREIGN KEY (id_profesor)
    REFERENCES PROFESOR(id_profesor);

ALTER TABLE RELACION_R
    ADD CONSTRAINT FK_RELACION_LIBRO
    FOREIGN KEY (id_libro)
    REFERENCES LIBRO(id_libro);

ALTER TABLE RELACION_R
    ADD CONSTRAINT FK_RELACION_MATERIA
    FOREIGN KEY (id_materia)
    REFERENCES MATERIA(id_materia);