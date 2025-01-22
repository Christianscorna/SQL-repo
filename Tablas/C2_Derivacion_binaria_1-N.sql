-- Para el siguiente ejemplo tenemos una relación binaria de alumnos que cursan en una determinada ciudad
-- Un alumno puede cursar en una y solo una ciudad (obligatorio)
-- En una ciudad cursa al menos uno o mas alumnos

-- table: ALUMNO
CREATE TABLE ALUMNO (
    LU integer(10) NOT NULL,
    apellido varchar(30) NOT NULL,
    nombre varchar(30) NOT NULL,
    fecha_nacimiento date NOT NULL,
    fecha_inscripcion date NOT NULL,
    id_ciudad char(4) NOT NULL -- tiene que cursar si o si en una ciudad
);

-- Indicamos la clave primaria y extranjera por fuera
ALTER TABLE ALUMNO
    ADD CONSTRAINT PK_ALUMNO 
    PRIMARY KEY (LU);

ALTER TABLE ALUMNO
    ADD CONSTRAINT FK_ALUMNO
    FOREIGN KEY (id_ciudad)
    REFERENCES CIUDAD(id_ciudad);

-- table: CIUDAD
CREATE TABLE CIUDAD (
    id_ciudad char(4) NOT NULL,
    sede_UNICEN varchar(30) NOT NULL
);

ALTER TABLE CIUDAD 
    ADD CONSTRAINT PK_CIUDAD
    PRIMARY KEY (id_ciudad);

-- Tambien podría presentarse el caso de que el lado uno de la relación sea opcional
-- Una marca de cerveza pertenece a una o mas cervezas
-- Una cerveza puede no pertenecer a ninguna marca (Una artesanal por ejemplo)

CREATE TABLE CERVEZA (
    id_cerveza integer(12) NOT NULL,
    nombre varchar(15) NOT NULL,
    graduacion_alcoholica integer(8) NOT NULL,
    color varchar(10) NOT NULL,
    id_marca integer(20) -- No tiene por qué tener si o si una marca
);

ALTER TABLE CERVEZA
    ADD CONSTRAINT PK_CERVEZA
    PRIMARY KEY (id_cerveza);

ALTER TABLE CERVEZA
    ADD CONSTRAINT FK_CERVEZA
    FOREIGN KEY (id_marca)
    REFERENCES MARCA;

-- y creamos a la marca
CREATE TABLE MARCA (
    id_marca integer(20) NOT NULL
    nombre_marca varchar(30) NOT NULL
);

ALTER TABLE MARCA
    ADD CONSTRAINT PK_MARCA
    PRIMARY KEY (id_marca);