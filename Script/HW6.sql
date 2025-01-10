USE sakila;

SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS month,
	   COUNT(rental_id) AS rental_count
  FROM category c
 INNER JOIN film_category fc
 	ON c.category_id = fc.category_id
 INNER JOIN film f
 	ON fc.film_id = f.film_id
 INNER JOIN inventory i
 	ON f.film_id = i.film_id
 INNER JOIN rental r
 	ON i.inventory_id = r.inventory_id
 WHERE c.name = 'Action'
 GROUP BY month
 ORDER BY month
;