USE sakila;

SELECT c.customer_id,
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	   COUNT(r.rental_id) AS rental_count,
	   AVG(p.amount) as avg_payment
  FROM customer c
 INNER JOIN rental r
 	ON c.customer_id = r.customer_id 
 INNER JOIN payment p
 	ON r.rental_id = p.rental_id
 GROUP BY c.customer_id
 ORDER BY rental_count DESC, avg_payment DESC
 LIMIT 5
;