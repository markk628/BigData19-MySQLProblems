USE sakila;

SELECT *
  FROM (
  	SELECT f.title as film_title,
	   	   COUNT(f.title) AS rental_count
  	  FROM film f
	 INNER JOIN inventory i
 		ON f.film_id = i.film_id 
	 INNER JOIN rental r
 		ON i.inventory_id = r.inventory_id 
	 WHERE r.rental_date BETWEEN '2005-05-01' AND '2005-05-31'
	 GROUP BY f.title
  ) AS x
  WHERE x.rental_count = 5
;

SELECT f.title as film_title,
	   COUNT(f.title) AS rental_count
  FROM film f
 INNER JOIN inventory i
 	ON f.film_id = i.film_id 
 INNER JOIN rental r
 	ON i.inventory_id = r.inventory_id 
 WHERE r.rental_date BETWEEN '2005-05-01' AND '2005-05-31'
 GROUP BY f.title
HAVING rental_count = 5
;
