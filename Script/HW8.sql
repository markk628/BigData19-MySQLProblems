USE sakila;

SELECT r.customer_id,
	   rt.customer_name,
	   (rt.rental_time / COUNT(r.rental_id)) AS avg_rental_interval 
  FROM (
  	SELECT c.customer_id,
  		   CONCAT(c.first_name, ' ', c.last_name) as customer_name,
  		   SUM(TIMESTAMPDIFF(HOUR, r.rental_date, r.return_date)) AS rental_time
  	  FROM customer c
 	 INNER JOIN rental r
 	    ON c.customer_id = r.customer_id
 	 WHERE r.return_date IS NOT NULL
     GROUP BY c.customer_id
  ) AS rt
 INNER JOIN rental r
 	ON r.customer_id = rt.customer_id
 GROUP BY r.customer_id 
 ORDER BY avg_rental_interval ASC
;

SELECT c.customer_id,
	   CONCAT(c.first_name, ' ', c.last_name) as customer_name,
	   (rt.time_diff / COUNT(rt.customer_id)) AS avg_rental_interval
  FROM (
  	SELECT r.customer_id,
  		   DATEDIFF(r.rental_date, r2.rental_date) AS time_diff
  	  FROM rental r
  	 INNER JOIN rental r2
  	 	ON r.customer_id = r2.customer_id
  	 GROUP BY r.customer_id
  ) as rt
 INNER JOIN customer c
 	ON c.customer_id = rt.customer_id
 GROUP BY c.customer_id
 ORDER BY avg_rental_interval
--  LIMIT 5
;


SELECT TIMESTAMPDIFF(HOUR, r.rental_date, r2.rental_date) 
  FROM rental r
 INNER JOIN rental r2
  	ON r.rental_id = r2.rental_id - 1
  	
SELECT r.rental_id,
	   r.rental_date,
	   r.customer_id,
	   r2.rental_id,
	   r2.rental_date,
	   r2.customer_id
  FROM rental r
 INNER JOIN rental r2
  	ON r.customer_id = r2.customer_id 

SELECT r.rental_id,
	   r2.rental_id,
	   r.customer_id,
	   r2.customer_id,
	   r.rental_date,
	   r2.rental_date
  FROM rental r
 INNER JOIN rental r2
  	ON r.customer_id = r2.customer_id 
 ORDER BY r.customer_id
;

SELECT r.rental_id,
	   r2.rental_id,
	   r.customer_id,
	   r2.customer_id,
	   r.rental_date,
	   r2.rental_date
  FROM rental r
 INNER JOIN rental r2
  	ON r.rental_id = r2.rental_id 
 ORDER BY r.customer_id
;

-- rental,rental,customer 