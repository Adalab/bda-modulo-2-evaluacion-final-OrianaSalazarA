USE sakila;

--  1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

	-- un distinct y seleccionar la columna con el nombre de las pelis
	-- seleccionar la tabla de donde sacaremos la info

SELECT DISTINCT title 
FROM film; 


-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

	-- seleccionar columnas dodne sacaremos la info
	-- seleccionar la tabla de donde sacaremos la info
	-- seleccionamos columna donde esta la cacificacion y poner el valor que estamos buscando

SELECT 
title,
rating
FROM film
WHERE rating = 'PG-13' ;

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

	-- seleccionar columnas dodne sacaremos la info
    -- seleccionar la tabla de donde sacaremos la info
    -- la columna donde se almacena los datos especificos que necesitamos 
    -- con un LIKE buscar cualquier registro que contenga el patron "amazing"
    -- el %xxx% para que me busque en la descripcion cualquiera que contenga el paton asignado 
    
 
SELECT 
title,
description
FROM film
WHERE description LIKE '%amazing%' ;


-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

	-- seleccionar columnas donde sacaremos la info, con AS he renombrado mis columnas
    -- seleccionar la tabla de donde sacaremos la info
    -- columna de donde sacaremos la info que necesitamos y un > 120 (mayor que, los minuntos indicados) para obtener el resultado que buscamos

SELECT 
title AS 'TITULO',
length AS 'DURACIÓN'
FROM film
WHERE length > 120;


--  5. Recupera los nombres de todos los actores.

	-- seleccionar columnas donde sacaremos la info
    -- seleccionar la tabla de donde sacaremos la info

SELECT 
actor_id,
first_name
FROM actor ;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

	-- seleccionar columnas donde sacaremos la info
    -- seleccionar la tabla de donde sacaremos la info
    -- la columna donde se almacena los datos especificos que necesitamos 
    -- con un LIKE buscar cualquier registro que contenga el patron "Gibson"

SELECT
first_name,
last_name
FROM actor
WHERE last_name LIKE '%Gibson%'
;

	-- queria comprobar si quitando el LIKE obtenia el mismo resultado 
    
SELECT
first_name,
last_name
FROM actor
WHERE last_name = 'Gibson'
;


-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
	
    -- seleccionar columnas donde sacaremos la info
    -- seleccionar la tabla de donde sacaremos la info
    -- de donde: de la columna donde se almacena los datos especificos que necesitamos 
    -- indicar condicion que saque los id del 10 al 20


-- lo primero que se me vino a la mente fue hacerlo asi, está mal, solo me esta tomando el id 10 y el id 20
SELECT 
actor_id,
first_name
FROM actor
WHERE actor_id IN (10 ,  20)
;

-- el BETWEEN filtra el rango indicado incluyendo el 10 y el 20
SELECT 
actor_id,
first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20
;

-- comprobando que de esta manera (menos eficiente) me da la misma información. Podria usar un >= que  y un <= que.
SELECT 
actor_id,
first_name
FROM actor
WHERE actor_id IN (10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
;


-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

	-- seleccionar columnas donde sacaremos la info, con AS he renombrado mis columnas
    -- seleccionar la tabla de donde sacaremos la info
    -- columna de donde sacaremos la info que necesitamos y un NOT IN para que descarte la clasificación "R" y "PG-13"
 
 
 SELECT
 title AS 'Titulos_Peliculas',
 rating AS 'Clacificación'
 FROM film
 WHERE rating NOT IN ('R', 'PG-13');
 
 
 -- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
	-- identificar con que tablas vamos a trabajar (category / film_category)
    -- identificar las columnas que usaremos que nos unen ambas tablas
    -- con un GROUP BY vamos a agrupar por clacificacion para contar cuantas pelis hay en cada grupo
 
SELECT 
category.name AS categoria,
COUNT(film_id) AS numero_de_pelis
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY 
category.name ;
 
 
 -- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su  nombre y apellido junto con la cantidad de películas alquiladas.
	-- seleccionar columnas donde sacaremos la info, con AS he renombrado mis columnas
    -- seleccionar las tablas de donde sacaremos la info
    -- usaremos una funcion agregada para contar la cantidad de pelis alquiladas
    -- haré una union de tablas con un left join
    -- agrupar los resultados


SELECT
c.customer_id AS 'ID CLIENTE',
c.first_name AS 'NOMBRE',
c.last_name AS 'APELLIDO',
COUNT(alquiler.rental_id) AS cantidad_alquiladas
FROM customer AS c
LEFT JOIN rental AS alquiler
ON c.customer_id = alquiler.customer_id
GROUP BY 
c.customer_id,
c.first_name,
c.last_name;


-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
      

 SELECT 
 category.name,
 COUNT(category.name) AS 'pelis alquiladas'
 FROM rental
 INNER JOIN inventory
 ON rental.inventory_id = inventory.inventory_id
 INNER JOIN film
 ON inventory.film_id = film.film_id
 INNER JOIN film_category
 ON film_category.film_id = film.film_id
 INNER JOIN category
 ON category.category_id = film_category.category_id
 GROUP BY category.name;

 -- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

	-- seleccionar la columna de donde sacaremos la info.
    -- seleccionar la tabla de donde sacaremos la info
    -- utilizaremos la función agregada AVG para sacar la media
    -- agrupar los recultados
 
SELECT 
rating, AVG(length) AS promedio_duracion
FROM film
GROUP BY rating;


-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
	-- seleccionamos las columnas que queremos que aparezcan
    -- seleccionamos la tabla dodne vamos a sacar la info
    -- hacemos union de tablas
    
select 
a.first_name,
a.last_name
from film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor AS a
ON a.actor_id = film_actor.actor_id
where film.title = 'Indian Love';


-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

	-- seleccionar la columna de donde sacaremos la info.
    -- seleccionar la tabla de donde sacaremos la info.
    -- de donde sacaremos la info que nececitamos 
    -- un LIKE para que busque lo que pedimos y los %xxx% para que busque en la palabra
    -- he hecho dos tablas iguales, una con dog y otra con cat y las he unido para obtener los resultados 

SELECT
title
FROM film
WHERE title LIKE '%dog%'
UNION
SELECT
title
FROM film
WHERE title LIKE '%cat%';


-- 15. Encuentr a el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

	-- seleccionar la columna de donde sacaremos la info. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- seleccionar de donde sacaremos la información que queremos
    -- un operador especial BETWEEN para especificar un rango de valores

SELECT 
title AS 'TITULO',
release_year AS 'AÑO'
FROM film
WHERE release_year BETWEEN 2005 AND 2010;


-- 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".

	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- agregaremos a la izquierda la columna que nececitamos de otra tabla
    -- de donde sacaremso la info y filtramos por 'family'

SELECT
film.title AS 'PELI',
category.name AS 'CATEGORIA'
FROM film
LEFT JOIN category
ON film.film_id = category.category_id
WHERE category.name = 'family';


-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

	-- seleccionar las columnas de donde sacaremos la info y las que queramos que aparezcan en la tabla.
    -- seleccionar la tabla de donde sacaremos la info.
    -- de donde?
    -- agrupamos, filtramos y aplicamos condición para obtener resultados
    
    
SELECT 
title,
rating,
length
FROM film
WHERE rating = 'R'
GROUP BY
title,
rating,
length
HAVING length > 120
;


-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- union de tablas para obtener la info
    -- agrupamos y damos la condicion que queremos

SELECT 
actor.first_name AS nombre,
actor.last_name AS apellido
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) > 10
;


-- 19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- union de tablas para obtener la info
    -- agrupamos y damos la condicion que queremos
    
    
SELECT 
actor.actor_id,
actor.first_name,
actor.last_name
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- union de tablas para obtener la info
    -- agrupamos y damos la condicion que queremos


SELECT
category.name AS categoria,
AVG(film.length) AS 'Duración Promedio'
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY
category.name
HAVING AVG(film.length)  > 120
; 

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- union de tablas para obtener la info
    -- agrupamos y damos la condicion que queremos

SELECT
actor.actor_id,
actor.first_name,
COUNT(film_actor.film_id) AS cantidad_peliculas
FROM actor
LEFT JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
GROUP BY 
actor.actor_id,
actor.first_name
HAVING COUNT(film_actor.film_id) > 25
;


-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona películas correspondientes.


SELECT
film.title
FROM film
WHERE film.film_id IN (
	SELECT rental.rental_id
    FROM rental
    WHERE rental.return_date - rental.rental_date >5
);


-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

SELECT 
actor.first_name,
actor.last_name
FROM actor
WHERE actor.actor_id NOT IN (
	SELECT 
	actor.actor_id
	FROM film
	INNER JOIN film_actor
	ON film_actor.film_id = film.film_id
	INNER JOIN actor
	ON film_actor.actor_id = actor.actor_id
	INNER JOIN film_category
	ON film_category.film_id = film.film_id
	INNER JOIN category
	ON film_category.category_id = category.category_id
	WHERE category.name = 'Horror');


-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
	-- seleccionar la columna de donde sacaremos la info y las que queramos que aparezcan en la tabla. AS para renombrar
    -- seleccionar la tabla de donde sacaremos la info.
    -- union de tablas para obtener la info
    -- un where con la condición

SELECT 
title AS 'TITULO',
length AS 'DURACIÓN'
FROM film
INNER JOIN film_category
ON film_category.film_id = film.film_id
INNER JOIN category
ON category.category_id = film_category.category_id
WHERE length > 180 AND category.name = 'Comedy'
;


-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
 
 
 
 
