USE sakila;

SELECT s.store_id -- store의 store_id
	 , DATE_FORMAT(p.payment_date, '%Y-%m') AS month -- payment의 payment_date를 YYYY-MM형식으로 형변환
	 , SUM(p.amount) AS total_revenue -- payment의 amount 합
  FROM staff s
 INNER JOIN rental r -- staff랑 rental을 staff_id 기준으로 합
 	ON s.staff_id = r.staff_id
 INNER JOIN payment p -- payment랑 rental을 rental_id 기준으로 합
 	ON p.rental_id = r.rental_id
 GROUP BY s.store_id, month -- staff의 store_id와 month 기준으로 그룹화
 ORDER BY s.store_id, month -- staff의 store_id와 month 기준으로 정렬
; 

SELECT s.store_id
	 , DATE_FORMAT(x.payment_date, '%Y-%m') AS month
	 , SUM(x.amount) AS total_revenue
  FROM staff s
 INNER JOIN (
 	SELECT p.payment_date,
 		   p.amount,
 		   r.staff_id
 	  FROM payment p
 	 INNER JOIN rental r
 	  	ON p.rental_id = r.rental_id
 ) as x
 	ON s.staff_id = x.staff_id
 GROUP BY s.store_id, month
 ORDER BY s.store_id, month
; 