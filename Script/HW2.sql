USE sakila;

SELECT a.first_name, -- actor의 first_name
	   a.last_name, -- actor의 last_name 
	   f.title, -- film의 title
	   SUM(p.amount) AS total_revenue -- payment의 amount 합
  FROM actor a -- actor와 film_actor를 actor_id 기준으로 합
 INNER JOIN film_actor fa
 	ON a.actor_id = fa.actor_id
 INNER JOIN film f -- film_actor와 film을 film_id 기준으로 합
 	ON f.film_id = fa.film_id
 INNER JOIN inventory i -- film와 inventory를 film_id 기준으로 합
    ON i.film_id = f.film_id
 INNER JOIN rental r -- inventory와 rental를 film_id 기준으로 합
 	ON r.inventory_id = i.inventory_id
 INNER JOIN payment p -- rental와 payment를 film_id 기준으로 합
 	ON p.rental_id = r.rental_id
 WHERE a.first_name = 'Tim' -- actor의 first_name가 Tim이고
   AND a.last_name = 'Hackman' -- last_name이 Hackman인 row만
 GROUP BY f.title -- film의 title로 그롭화
 ORDER BY total_revenue DESC -- total_revenue를 내림차순으로 정렬
;