-- Una agregación es un tipo de relación del modelo entidad relación extendido que permite modelar situaciones en las que una entidad se vincula de manera independiente a ejemplares de tuplas que se relacionan entre si por si solas. 
-- Al contrario que en las relaciones ternarias, las entidades participantes no deben existir si o si a la vez,
-- La agregación se realiza hacia una relación binaria N a N

-- por ejemplo: Supongamos que tenemos que hay proyectos que se instalan en distintas oficinas de trabajo o que en una oficina se pueden instalar diferentes proyectos (ninguno o más de uno)
-- A la vez consideraremos un empleado que trabaja alli... Primero no diremos que es una relación ternaria porque:
  -- La relación proyecto - <instalado_en> - oficina existe sin necesidad del empleado
  -- estaríamos obligando a que los empleados trabajen si o si en proyectos instalados en oficinas (work? what its it?)

-- Se deriva tal cual aprendimos las derivaciones binarias de N a N y se crea una entidad nueva para el empleado cuyas claves extranjeras seran las claves primarias (y extranjeras) de la relación del medio

-- table: proyecto
CREATE TABLE PROYECTO (
    id_proyecto int NOT NULL,
    titulo varchar(50) NOT NULL,
    presupuesto integer NOT NULL
);

ALTER TABLE PROYECTO
    ADD CONSTRAINT PK_PROYECTO
    PRIMARY KEY (id_proyecto);

-- table: oficina
CREATE TABLE OFICINA (
    id_oficina int NOT NULL,
    descripcion varchar(20)  NOT NULL,
    capacidad int NOT NULL   
);

ALTER TABLE OFICINA
    ADD CONSTRAINT PK_OFICINA
    PRIMARY KEY (id_oficina);

-- table: instalado
CREATE TABLE INSTALADO (
    id_proyecto int NOT NULL,
    id_oficina int NOT NULL
);

ALTER TABLE INSTALADO
    ADD CONSTRAINT PK_INSTALADO
    PRIMARY KEY (id_proyecto, id_oficina);

ALTER TABLE INSTALADO
    ADD CONSTRAINT FK_INSTALADO_PROYECTO
    FOREIGN KEY (id_proyecto)
    REFERENCES PROYECTO(id_proyecto);

ALTER TABLE INSTALADO
    ADD CONSTRAINT FK_INSTALADO_OFICINA
    FOREIGN KEY (id_oficina)
    REFERENCES OFICINA(id_oficina);

-- table: empleado
CREATE TABLE EMPLEADO (
    tipo_doc char NOT NULL,
    num_doc int NOT NULL,
    apellido varchar(20) NOT NULL,
    nombre varchar(20) NOT NULL,
    telefono int,
    CONSTRAINT PK_EMPLEADO PRIMARY KEY(tipo_doc, num_doc)
);

ALTER TABLE EMPLEADO
    ADD CONSTRAINT FK_EMPLEADO_INSTALADO
    FOREIGN KEY (id_proyecto, id_oficina)
    REFERENCES INSTALADO(id_proyecto, id_oficina);
