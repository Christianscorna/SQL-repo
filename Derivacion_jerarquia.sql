-- Supongamos que tenemos una jerarquía en la que contamos con una entidad que representa a un determinado producto. Dicho producto sabemos que puede ser de tipo sólido o líquido y que los solidos los podemos envasas o atener a granel.
-- La jerarquía que modela si el producto es sólido o líquido es exclusiva (Solo puede ser uno a la vez)
-- La jerarquía de un producto líquido envasado o a granel es compartida (Podría ser cualqueira de los dos)

-- La entidad dependiente se lleva el identificador de la entidad padre como clave primaria y extranjera (En todos los niveles de jerarquía)

-- table: producto --> es el padre liquido y solido
CREATE TABLE PRODUCTO (
    id_producto int NOT NULL,
    marca varchar(30) NOT NULL
    tipo int NOT NULL -- En las jerarquías exclusivas se debe agregar el atributo discrimante
);

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PK_PRODUCTO
    PRIMARY KEY (id_producto);

-- table: liquido --> es el padre de envasado y a_granel
CREATE TABLE LIQUIDO (
    id_producto int NOT NULL,
    cuidados_por_manipulacion varchar(70) NOT NULL
);

ALTER TABLE LIQUIDO
    ADD CONSTRAINT PK_LIQUIDO
    PRIMARY KEY (id_producto);

ALTER TABLE LIQUIDO
    ADD CONSTRAINT FK_PRODUCTO_LIQUIDO
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO(id_producto);

-- table: solido
CREATE TABLE SOLIDO (
    id_producto int NOT NULL,
    cantidad_por_paquete int NOT NULL
);

ALTER TABLE SOLIDO
    ADD CONSTRAINT PK_SOLIDO
    PRIMARY KEY (id_producto);

ALTER TABLE SOLIDO
    ADD CONSTRAINT FK_PRODUCTO_SOLIDO
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO(id_producto);

-- Ahora vamos con los hijos de los hijos

-- table: envasado
CREATE TABLE ENVASADO (
    id_producto int NOT NULL,
    presentacion char(10) NOT NULL
);

ALTER TABLE ENVASADO
    ADD CONSTRAINT PK_ENVASADO
    PRIMARY KEY (id_producto);

ALTER TABLE ENVASADO
    ADD CONSTRAINT FK_PRODUCTO_LIQUIDO_ENVASADO
    FOREIGN KEY (id_producto)
    REFERENCES LIQUIDO(id_producto);

-- table: a_granel
CREATE TABLE A_GRANEL (
    id_producto int NOT NULL,
    cantidad_minima int NOT NULL
);

ALTER TABLE A_GRANEL
    ADD CONSTRAINT PK_A_GRANEL
    PRIMARY KEY (id_producto);

ALTER TABLE A_GRANEL
    ADD CONSTRAINT FK_PRODUCTO_LIQUIDO_A_GRANEL
    FOREIGN KEY (id_producto)
    REFERENCES LIQUIDO(id_producto);