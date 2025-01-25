/*
 LIKE nos permite buscar y filtrar datos por patrones de texto 
  --> Por defecto es igual al operador =
    --> El poder de like se vería desperciado si solo lo usáramos para buscar cosas igual a 
    --> Por ello cuenta con un par de comodines...
 */

 -- Si quisiéramos saber cuantos argentinos tiene la tabla Customers
SELECT * FROM Customers
WHERE Country LIKE "ARGENTINA";

-- EL operador de % nos idica que DEBE TERMINAR CON lo que siga después, por ejemplo
-- Cuantos nombres tenemos que terminen con ng
SELECT * FROM Customers
WHERE ContactName LIKE "%ng";

-- Colocados al revés significa que tiene que empezar con
-- Cuantos paises que arranquen con la letra A
SELECT * FROM Customers
WHERE Country LIKE "A%";

-- A ambos lados de la expresion, significa que debe contener
-- Cuantos nombres de Clientes tienen la letra w
SELECT * FROM Customers
WHERE CustomerName LIKE "%w%";

/*
 Otra herramienta que es bastante poderosa con la que cuenta LIKE es el operador _ (Guión bajo) Nos sirve cuando queremos buscar un dato que recordamos una parte pero no del todo
 */

-- Queremos traer todos los clientes cuya segunda letra del nombre sea la h
SELECT * FROM Customers
WHERE CustomerName LIKE "_h%";
-- Christian, Christina, Thomas