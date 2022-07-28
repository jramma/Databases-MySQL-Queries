

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre,precio FROM producto;
-- Llista totes les columnes de la taula producto.
SELECT * FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio, precio*0.9 FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS nom_de_producto, precio as euros, precio*0.9 as dolares from producto;
-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT upper(nombre) , precio FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT lower(nombre) , precio FROM producto;

-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, left(upper(nombre), 2) FROM fabricante;

-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT round(precio) FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio,0) FROM producto;

-- Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT  f.codigo FROM producto p left join fabricante f on f.codigo = p.codigo_fabricante;
-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT  f.codigo FROM producto p left join fabricante f on f.codigo = p.codigo_fabricante group by f.codigo ;
-- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY fabricante.nombre;
-- Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY fabricante.nombre DESC;

-- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre FROM producto ORDER BY producto.nombre;
SELECT nombre FROM producto ORDER BY producto.precio DESC;

-- Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * from fabricante WHERE codigo<6 ; 
-- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * from fabricante WHERE codigo>3&&codigo<6 ; 
-- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto order by precio  LIMIT 1;
-- Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto  order by precio desc limit 1;
-- Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
select * from producto where codigo_fabricante=2;
-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
select p.nombre, p.precio, f.nombre AS fabricante from producto p LEFT join fabricante f ON f.codigo = p.codigo_fabricante;
-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre, p.precio, f.nombre AS fabricante from producto p LEFT join fabricante f ON f.codigo = p.codigo_fabricante ORDER BY f.nombre desc;
-- Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo, p.nombre, f.codigo AS codigo_fabricante, f.nombre AS fabricante from producto p join fabricante f on p.codigo_fabricante= f.codigo || p.codigo_fabricante = null GROUP By p.codigo;
-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT  p.nombre, p.precio, f.nombre AS fabricante from producto p join fabricante f on p.codigo_fabricante= f.codigo || p.codigo_fabricante = null GROUP By p.codigo order by p.precio asc limit 1 ;

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT  p.nombre, p.precio, f.nombre AS fabricante from producto p join fabricante f on p.codigo_fabricante= f.codigo || p.codigo_fabricante = null GROUP By p.codigo order by p.precio desc limit 1 ;

-- Retorna una llista de tots els productes del fabricant Lenovo.
SELECT  p.nombre from producto p join fabricante f on p.codigo_fabricante= f.codigo && f.nombre = 'Lenovo' GROUP By p.codigo;
-- Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT  * from producto p join fabricante f on p.codigo_fabricante= f.codigo && f.nombre = 'Crucial' && p.precio>200 GROUP By p.codigo;

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT  * from producto p join fabricante f on p.codigo_fabricante= f.codigo && (f.nombre = 'Asus' ||f.nombre = 'Hewlett-Packard') gROUP By p.codigo;

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT  * from producto WHERE codigo_fabricante IN (1,3);

-- Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre, p.precio from producto p join fabricante f 
on p.codigo_fabricante= f.codigo && f.nombre LIKE '%e' GROUP By p.codigo ;
-- Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre, p.precio from producto p join fabricante f 
on p.codigo_fabricante= f.codigo && f.nombre LIKE '%w%' GROUP By p.codigo ;
-- Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre, p.precio, f.nombre AS fabricante from producto p 
join fabricante f on p.codigo_fabricante= f.codigo && p.precio >= 180 
GROUP By p.codigo ORDER BY p.precio asc ;
-- Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes 
-- associats en la base de dades.
SELECT f.nombre, f.codigo FROM producto p left join fabricante f  on f.codigo = p.codigo_fabricante GROUP BY  f.codigo;
-- Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes 
-- que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT f.*, p.nombre from producto p join fabricante f  on f.codigo = p.codigo_fabricante  GROUP BY  f.codigo;
-- Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT * FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);
-- Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT nombre ='Lenovo' FROM fabricante );
-- Retorna totes les dades dels productes que tenen el mateix preu 
-- que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto WHERE precio  IN (SELECT MAX(precio)  FROM producto WHERE codigo_fabricante IN (SELECT nombre ='Lenovo' FROM fabricante ));
-- Llista el nom del producte més car del fabricant Lenovo.
SELECT *, max(precio)  FROM producto WHERE codigo_fabricante IN (SELECT nombre ='Lenovo' FROM fabricante )  ;
-- Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT *, MIN(precio)  FROM producto WHERE codigo_fabricante IN (SELECT nombre ='Hewlett-Packard' FROM fabricante );

-- Retorna tots els productes de la base de dades que tenen 
-- un preu major o igual al producte més car del fabricant Lenovo.
SELECT p2.* FROM producto p1 left join  producto p2 ON p2.precio >= p1.precio 
WHERE p1.precio IN (SELECT max(precio) FROM producto WHERE codigo_fabricante 
in (SELECT nombre ='Lenovo' FROM fabricante)) ORDER BY p2.codigo;

-- Llesta tots els productes del fabricant Asus que tenen un preu superior 
-- al preu mitjà de tots els seus productes.
SELECT p2.* FROM producto p1 left join  producto p2 ON p2.precio > p1.precio
WHERE p1.precio IN (SELECT avg(precio) FROM producto WHERE codigo_fabricante 
in (SELECT nombre ='Asus' FROM fabricante));

