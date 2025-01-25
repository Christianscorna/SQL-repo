/*
 En un ambiente donde estemos trabajando con datos que admiten nulos, a lo mejor quisiéramos concentrarnos en aquellos que tienen nullos o a lo mejor no los queremos para nada porque son molestos
 */

-- Si quisieramos saber los datos de los voluntarios que no tienen coordinador:
SELECT * FROM unc_esq_voluntarios
WHERE id_coordinador IS NULL;

-- Mismo al revés, supongamos que nos interesa trabajar solo con aquellos voluntarios que si tienen coordinador
SELECT * FROM unc_esq_voluntarios
WHERE id_coordinador IS NOT NULL;
