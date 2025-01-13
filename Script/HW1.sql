USE sakila;

/*
문제 1: 매장별 월별 매출 분석
매장의 월별 매출 조회.
 - 매장별, 월별 매출 데이터를 집계:
   payment 테이블에서 결제 금액을 집계하고, 결제 날짜를 기준으로 월별 데이터를 그룹화.
 */

-- 필요한 value들이 staff와 payment에 있기때문에 store + rental + payment table을 만들어야됨
SELECT s.store_id -- store의 store_id
	 , DATE_FORMAT(p.payment_date, '%Y-%m') AS month -- payment의 payment_date를 YYYY-MM형식으로 형변환
	 , SUM(p.amount) AS total_revenue -- payment의 amount 합
  FROM staff s -- staff table에 store_id가 있기때문에 꼭 store table이 필요하지 않음
 INNER JOIN rental r -- staff가 어떤 store에서 rental기록을 만들었는지 찻기위해 staff랑 rental을 staff_id 기준으로 합
 	ON s.staff_id = r.staff_id
 INNER JOIN payment p -- rental기록에 해당되는 payment기록을 찻기위해 payment랑 (staff + rental)을 rental_id 기준으로 합
 	ON p.rental_id = r.rental_id -- staff_id로 연결을 못하는 이유는 staff_id기준으로 payment랑 rental을 연결하면 payment에 틀린 rental기록이 붙기때문에 (more info on bottom) 
 GROUP BY s.store_id, month -- staff의 store_id와 month 기준으로 그룹화
 ORDER BY s.store_id, month -- staff의 store_id와 month 기준으로 정렬
; 
-- payment와 rental table각각에 여러 row들이 똑같은 staff가 있슬수있어서, staff_id로 연결하면 payment와 해당되지 않은 rental이 붙을수있기때문에 안됌 

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