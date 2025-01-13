USE sakila;

/*
문제 5: 고객의 활동성 분석
고객의 대여 횟수와 평균 결제 금액을 기반으로 상위 5명의 VIP 고객을 식별 조회.
 - 고객별 대여 횟수와 평균 결제 금액 계산:
   rental과 payment 테이블을 조인하여 고객별 데이터를 집계.
*/

-- 필요한 value들이 customer, rental, 그리고 payment table들에 있기때문에 customer + rental + payment table을 만들어야됨
SELECT c.customer_id, -- customer의 customer_id
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name, -- customer의 first_name이랑 last_name
	   COUNT(r.rental_id) AS rental_count, -- customer의 대여 개수
	   AVG(p.amount) as avg_payment -- customer의 평균 대여 값
  FROM customer c -- customer가 한 rental 기록들을 찻기위해 customer이랑 rental을 customer_id기준으로 합
 INNER JOIN rental r
 	ON c.customer_id = r.customer_id 
 INNER JOIN payment p -- customer가 한 rental들의 payment기록들을 찻기위해 (customer + rental)이랑 payment를 rental_id기준으로 합
 	ON r.rental_id = p.rental_id -- customer_id로 연결을 못하는 이유는 customer_id기준으로 payment랑 rental을 연결하면 payment에 틀린 rental기록이 붙기때문에 (more info on bottom)
 GROUP BY c.customer_id -- customer_id기준으로 그룹화
 ORDER BY rental_count DESC, avg_payment DESC -- rental_count로 먼저 내림순으로 정렬후 avg_payment로 내림순으로 정렬
 LIMIT 5 -- 5개만
;
-- payment와 rental table각각에 여러 row들이 똑같은 customer가 있슬수있어서, customer_id로 연결하면 payment와 해당되지 않은 rental이 붙을수있기때문에 안됌