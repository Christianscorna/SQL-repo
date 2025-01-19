-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-06-13 13:42:28.805

-- example table 1
-- Table: CLIENTE
CREATE TABLE CLIENTE (
    id_cliente int  NOT NULL,
    nombre varchar(20)  NOT NULL,
    apellido varchar(20)  NOT NULL,
    fecha_nac date  NOT NULL,
    direccion varchar(20)  NOT NULL,
    telefono varchar(10)  NOT NULL,
    CONSTRAINT CLIENTE_pk PRIMARY KEY (id_cliente)
);

-- example table 2
-- Table: ALUMNO
CREATE TABLE ALUMNO (
    LU integer NOT NULL,
    documento integer NOT NULL,
    apellido varchar(30) NOT NULL,
    nombre varchar(30) NOT NULL,
    tutor varchar(50),
    calle varchar(20) NOT NULL,
    nro integer NOT NULL,
    ciudad varchar(30) NOT NULL,
    CONSTRAINT PK_ALUMNO PRIMARY KEY (LU)
);

-- Tambien podemos agregar la clave primaria por fuera
ALTER TABLE ALUMNO
ADD CONSTRAINT PK_ALUMNO 
PRIMARY KEY (LU);

-- End of file.

