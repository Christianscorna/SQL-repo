-- Tomaremos como ejemplo un campo que se divide en parcelas. 
-- La entidad débil es la parcela, ya que una parcela no puede existir si no existen ejemplares de campo
-- La clave se conforma como su identificador propio más el de la entidad fuerte como extranjera

-- table: Campo
CREATE TABLE CAMPO (
    id_campo int NOT NULL,
    nombre_campo varchar(10) NOT NULL
);

ALTER TABLE CAMPO
    ADD CONSTRAINT PK_CAMPO
    PRIMARY KEY (id_campo);

-- table: Parcela
CREATE TABLE PARCELA (
    id_parcela int NOT NULL,
    superficie int NOT NULL,
    ultimo_cultivo varchar(15) NOT NULL,
    id_campo int NOT NULL
);

ALTER TABLE PARCELA
    ADD CONSTRAINT PK_PARCELA
    PRIMARY KEY (id_parcela);

ALTER TABLE PARCELA
    ADD CONSTRAINT FK_PARCELA
    FOREIGN KEY (id_campo)
    REFERENCES CAMPO(id_campo);