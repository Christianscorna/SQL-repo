-- Veremos como son los casos de relaciones ternarias donde tenemos un lado o mas con cardinalidad máxima 1
-- Utilizamos las mismas tablas

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


-- La relacion tendrá por clave primaria las dos del lado N y se excluye la que queda "sola" es decir la del "lado 1"
CREATE TABLE RELACION_R (
    id_profesor int NOT NULL,
    id_libro int NOT NULL,
    id_materia INT NOT NULL
);

ALTER TABLE RELACION_R
    ADD CONSTRAINT PK_RELACION_R
    PRIMARY KEY (id_profesor, id_libro); -- Supongamos que la relación nos dice que un profesor, para cada libro lo utiliza solo y en solo una materia

ALTER TABLE RELACION_R
    ADD CONSTRAINT FK_RELACION_PROFESOR
    FOREIGN KEY (id_profesor)
    REFERENCES PROFESOR(id_profesor);

ALTER TABLE RELACION_R
    ADD CONSTRAINT FK_RELACION_LIBRO
    FOREIGN KEY (id_libro)
    REFERENCES LIBRO(id_libro);

-- TERNARIAS N-1-1 Y 1-1-1:
-- Para estos casos se elije una de las claves que quedan del lado uno y se la excluye ya que la clave de la relación se compone de al menos dos claves extranjeras. 
-- Practicamente podríamos decir que "son todas iguales"