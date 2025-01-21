-- Consulta 2: Películas con clasificación ‘Rʼ
SELECT title
FROM film
WHERE rating = 'R';

-- Consulta 3: Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

-- Consulta 4: Obtén las películas cuyo idioma coincide con el idioma original
SELECT title, original_language_id 
FROM film
WHERE language_id = original_language_id;
---No obtengo resultados. Consultas para comprobar registros más específicamente
SELECT film_id, title, language_id, original_language_id
FROM film
LIMIT 10;
---Revisión si original_language_id contiene valores NULL
SELECT COUNT(*)
FROM film
WHERE original_language_id IS NULL;
---Cuántas películas tienen language_id igual a original_language_id
SELECT COUNT(*)
FROM film
WHERE language_id = original_language_id;
---Si original_language_id tiene valores NULL, incluir esas películas
SELECT film_id AS id_pelicula,
       title AS titulo,
       language_id AS idioma,
       original_language_id AS idioma_original
FROM film
WHERE language_id = original_language_id
   OR original_language_id IS NULL;


-- Consulta 5: Ordena las películas por duración de forma ascendente
SELECT title, length
FROM film
ORDER BY length ASC;

-- Consulta 6: Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido
SELECT first_name, last_name
FROM actor
WHERE last_name ILIKE '%Allen%';

-- Consulta 7: Encuentra la cantidad total de películas en cada clasificación
SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

-- Consulta 8: Encuentra el título de las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas
SELECT title
FROM film
WHERE rating = 'PG-13' OR length > 180;

-- Consulta 9: Estadísticas generales del costo de reemplazo
SELECT 
    MIN(replacement_cost) AS minimo,
    MAX(replacement_cost) AS maximo,
    AVG(replacement_cost) AS promedio,
    STDDEV(replacement_cost) AS desviacion_estandar
FROM film;

-- Consulta 10: Encuentra la mayor y menor duración de una película
SELECT 
    MAX(length) AS mayor_duracion,
    MIN(length) AS menor_duracion
FROM film;

-- Consulta 11: Encuentra el costo del antepenúltimo alquiler ordenado por día
SELECT p.amount, r.rental_date
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
WHERE r.rental_date = (
    SELECT DISTINCT rental_date
    FROM rental
    ORDER BY rental_date DESC
    OFFSET 2 LIMIT 1
);

-- Consulta 12: Encuentra el título de las películas que no sean ni ‘NC-17’ ni ‘G’
SELECT title
FROM film
WHERE rating NOT IN ('NC-17', 'G');

-- Consulta 13: Encuentra el promedio de duración de las películas para cada clasificación
SELECT rating, AVG(length) AS promedio_duracion
FROM film
GROUP BY rating
ORDER BY promedio_duracion DESC;

-- Consulta 14: Encuentra el título de las películas que tengan una duración mayor a 180 minutos
SELECT title
FROM film
WHERE length > 180;

-- Consulta 15: Calcula el dinero total generado por la empresa
SELECT SUM(amount) AS total_generado
FROM payment;

-- Consulta 16: Muestra los 10 clientes con mayor valor de ID
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

-- Consulta 17: Encuentra los actores que aparecen en la película con título 'Egg Igby'
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title LIKE '%EGG IGBY%';

-- Consulta 18: Selecciona todos los nombres únicos de las películas
SELECT DISTINCT title
FROM film;

-- Consulta 19: Encuentra las películas de comedia con duración mayor a 180 minutos
SELECT title
FROM film
JOIN film_category fc ON film.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND film.length > 180;

-- Consulta 20: Categorías de películas con un promedio de duración superior a 110 minutos
SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110
ORDER BY promedio_duracion DESC;

-- Consulta 21: Calcula la media de duración del alquiler de las películas
SELECT AVG(rental_duration) AS media_duracion_alquiler
FROM film;

-- Consulta 22: Combina el nombre y apellido de todos los actores y actrices
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor;

-- Consulta 23: Número de alquileres por día, ordenados de forma descendente
SELECT rental_date::DATE AS fecha_alquiler, COUNT(*) AS total_alquileres
FROM rental
GROUP BY rental_date::DATE
ORDER BY total_alquileres DESC;

-- Consulta 24: Encuentra las películas con una duración superior al promedio
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- Consulta 25: Número de alquileres registrados por mes
SELECT 
    DATE_TRUNC('month', rental_date) AS mes_alquiler, 
    COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes_alquiler ASC;

-- Consulta 26: Calcula el promedio, desviación estándar y varianza del total pagado
SELECT 
    AVG(amount) AS promedio_total,
    STDDEV(amount) AS desviacion_estandar,
    VAR_SAMP(amount) AS varianza_muestral
FROM payment;

-- Consulta 27: Películas que se alquilan por encima del precio medio
SELECT f.title, f.rental_rate
FROM film f
WHERE f.rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY f.rental_rate DESC;
---Películas que se alquilan por encima del precio medio comparativa
SELECT f.title, f.rental_rate, (SELECT AVG(rental_rate) FROM film) AS precio_medio
FROM film f
WHERE f.rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY f.rental_rate DESC;

-- Consulta 28: Muestra el ID de los actores que hayan participado en más de 40 películas
SELECT actor_id, COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

-- Consulta 29: Obtener todas las películas y su cantidad disponible en el inventario
SELECT f.title, 
       COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE i.inventory_id IS NOT NULL
GROUP BY f.film_id, f.title
ORDER BY cantidad_disponible DESC;

-- Consulta 30: Obtener los actores y el número de películas en las que han actuado
SELECT a.first_name, 
       a.last_name, 
       COUNT(fa.film_id) AS numero_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY numero_peliculas DESC;

-- Consulta 31: Obtener todas las películas y los actores que han actuado en ellas, incluyendo los NULL
SELECT f.title AS pelicula,
       a.first_name AS actor_nombre,
       a.last_name AS actor_apellido
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title, actor_apellido, actor_nombre;

-- Consulta 32: Obtener todos los actores y las películas en las que han actuado, incluyendo actores sin películas
SELECT a.first_name AS actor_nombre,
       a.last_name AS actor_apellido,
       f.title AS pelicula
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
ORDER BY actor_apellido, actor_nombre, pelicula;

---Revisar actores sin películas
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

-- Consulta 33: Obtener todas las películas y sus registros de alquiler
SELECT f.title AS pelicula,
       r.rental_id AS id_alquiler,
       r.rental_date AS fecha_alquiler,
       r.return_date AS fecha_devolucion
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title, r.rental_date;

-- Consulta 34: Encuentra los 5 clientes que más dinero han gastado
SELECT c.first_name AS nombre,
       c.last_name AS apellido,
       SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;

-- Consulta 35: Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOHNNY';

-- Consulta 36: Renombrar las columnas first_name y last_name como Nombre y Apellido
SELECT first_name AS Nombre,
       last_name AS Apellido
FROM actor;

-- Consulta 37: Encuentra el ID del actor más bajo y más alto
SELECT 
    MIN(actor_id) AS id_mas_bajo,
    MAX(actor_id) AS id_mas_alto
FROM actor;

--Opcional Con Nombre Y Apellidos
SELECT 
    actor_id AS id_mas_bajo,
    first_name AS nombre,
    last_name AS apellido
FROM actor
WHERE actor_id = (SELECT MIN(actor_id) FROM actor)
UNION
SELECT 
    actor_id AS id_mas_alto,
    first_name AS nombre,
    last_name AS apellido
FROM actor
WHERE actor_id = (SELECT MAX(actor_id) FROM actor);

-- Consulta 38: Cuenta el número total de actores en la tabla "actor"
SELECT COUNT(*) AS total_actores
FROM actor;

-- Consulta 39: Selecciona todos los actores y ordénalos por apellido en orden ascendente
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name ASC;

-- Consulta 40: Selecciona las primeras 5 películas de la tabla "film"
SELECT film_id, title, description, release_year, rental_rate
FROM film
LIMIT 5;

-- Consulta 41: Agrupa los actores por su nombre y cuenta cuántos tienen el mismo nombre
SELECT first_name AS nombre,
       COUNT(*) AS total
FROM actor
GROUP BY first_name
ORDER BY total DESC, nombre ASC;

-- Consulta 42: Encuentra todos los alquileres y los nombres de los clientes que los realizaron
SELECT r.rental_id AS id_alquiler,
       r.rental_date AS fecha_alquiler,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY r.rental_date DESC;

-- Consulta 43: Muestra todos los clientes y sus alquileres, incluyendo aquellos sin alquileres
SELECT c.customer_id AS id_cliente,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente,
       r.rental_id AS id_alquiler,
       r.rental_date AS fecha_alquiler
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.last_name ASC, c.first_name ASC, r.rental_date ASC;
---Revisar específicamente clientes sin alquiler si los hay
SELECT c.customer_id AS id_cliente,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL
ORDER BY c.last_name ASC, c.first_name ASC;

-- Consulta 44: CROSS JOIN entre las tablas film y category
SELECT f.title AS pelicula,
       c.name AS categoria
FROM film f
CROSS JOIN category c;

-- Respuesta:
-- ¿Aporta valor esta consulta?
-- No aporta valor directamente, ya que el CROSS JOIN genera un producto cartesiano 
-- que no refleja relaciones reales entre las películas y las categorías.
-- Si hay 1,000 películas y 10 categorías, se obtendrían 10,000 combinaciones, 
-- muchas de las cuales no tienen sentido práctico.
-- Este tipo de consulta solo podría ser útil en análisis teóricos o para explorar 
-- todas las combinaciones posibles, pero no para obtener información relevante 
-- sobre datos reales. Para un análisis más útil, sería mejor usar un INNER JOIN 
-- o LEFT JOIN entre las tablas film y category a través de la tabla intermedia film_category.

-- Consulta 45: Encuentra los actores que han participado en películas de la categoría 'Action'
SELECT DISTINCT a.first_name AS nombre,
                a.last_name AS apellido
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY a.last_name, a.first_name;

-- Consulta 46: Encuentra todos los actores que no han participado en películas
SELECT a.actor_id AS id_actor,
       a.first_name AS nombre,
       a.last_name AS apellido
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL
ORDER BY a.last_name, a.first_name;

-- Consulta 47: Nombre de los actores y la cantidad de películas en las que han participado
SELECT a.first_name AS nombre,
       a.last_name AS apellido,
       COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC, a.last_name ASC, a.first_name ASC;

-- Consulta 48: Crear una vista que muestre los nombres de los actores y la cantidad de películas en las que han participado
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name AS nombre,
       a.last_name AS apellido,
       COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC, a.last_name ASC, a.first_name ASC;

-- Consulta 49: Calcula el número total de alquileres realizados por cada cliente
SELECT c.customer_id AS id_cliente,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC, c.last_name ASC, c.first_name ASC;

-- Consulta 50: Calcula la duración total de las películas en la categoría 'Action'
SELECT c.name AS categoria,
       SUM(f.length) AS duracion_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE c.name = 'Action'
GROUP BY c.name;

-- Consulta 51: Crear una tabla temporal para almacenar el total de alquileres por cliente
CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT c.customer_id AS id_cliente,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Consulta 52: Crear una tabla temporal para películas alquiladas al menos 10 veces
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.film_id AS id_pelicula,
       f.title AS titulo,
       COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

-- Consulta 53: Encuentra las películas alquiladas por Tammy Sanders que no se han devuelto
SELECT DISTINCT f.title AS titulo_pelicula
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'TAMMY'
  AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL
ORDER BY f.title ASC;

-- Consulta 54: Encuentra los actores que han actuado en al menos una película de la categoría 'Sci-Fi'
SELECT DISTINCT a.first_name AS nombre,
                a.last_name AS apellido
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name ASC, a.first_name ASC;

-- Consulta 55: Encuentra los actores que han actuado en películas alquiladas después de 'Spartacus Cheaper'
SELECT DISTINCT a.first_name AS nombre,
                a.last_name AS apellido
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(rental.rental_date)
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    WHERE film.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name ASC, a.first_name ASC;

-- Consulta 56: Encuentra los actores que no han actuado en ninguna película de la categoría 'Music'
SELECT a.first_name AS nombre,
       a.last_name AS apellido
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
)
ORDER BY a.last_name ASC, a.first_name ASC;

-- Consulta 57: Encuentra el título de todas las películas que fueron alquiladas por más de 8 días
SELECT DISTINCT f.title AS titulo_pelicula
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
  AND r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY f.title ASC;

-- Consulta 57.1: Encuentra el título de las películas alquiladas por más de 8 días y cuántos días fueron alquiladas
SELECT DISTINCT f.title AS titulo_pelicula,
       (r.return_date - r.rental_date) AS dias_alquilados
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
  AND r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY f.title ASC;

-- Consulta 58: Encuentra los títulos de películas de la misma categoría que 'Animation'
SELECT DISTINCT f.title AS titulo_pelicula
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Animation'
)
ORDER BY f.title ASC;

-- Consulta 59: Encuentra las películas con la misma duración que 'Dancing Fever', excluyendo 'Dancing Fever' (redundancia)
SELECT DISTINCT f2.title AS titulo_pelicula
FROM film f1
JOIN film f2 ON f1.length = f2.length
WHERE f1.title = 'DANCING FEVER'
  AND f2.title != 'DANCING FEVER'
ORDER BY f2.title ASC;

-- Consulta 60: Encuentra los clientes que han alquilado al menos 7 películas distintas
SELECT c.first_name AS nombre,
       c.last_name AS apellido,
       COUNT(DISTINCT f.film_id) AS peliculas_distintas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT f.film_id) >= 7
ORDER BY c.last_name ASC, c.first_name ASC;

-- Consulta 61: Encuentra la cantidad total de películas alquiladas por categoría
SELECT c.name AS categoria,
       COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY total_alquileres DESC, c.name ASC;

-- Consulta 62: Encuentra el número de películas por categoría estrenadas en 2006
SELECT c.name AS categoria,
       COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.category_id, c.name
ORDER BY total_peliculas DESC, c.name ASC;

-- Consulta 63: Obtén todas las combinaciones posibles de trabajadores con las tiendas
SELECT s.staff_id AS id_trabajador,
       s.first_name AS nombre_trabajador,
       s.last_name AS apellido_trabajador,
       st.store_id AS id_tienda
FROM staff s
CROSS JOIN store st
ORDER BY s.staff_id, st.store_id;

-- Consulta 64: Encuentra la cantidad total de películas alquiladas por cada cliente
SELECT c.customer_id AS id_cliente,
       c.first_name AS nombre_cliente,
       c.last_name AS apellido_cliente,
       COUNT(r.rental_id) AS total_peliculas_alquiladas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_peliculas_alquiladas DESC, c.last_name ASC, c.first_name ASC;

































































