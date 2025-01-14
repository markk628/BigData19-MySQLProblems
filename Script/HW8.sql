USE sakila;

/*
문제 8: 고객의 평균 대여 간격 분석
고객들이 평균적으로 얼마나 자주 영화를  대여하는지 분석하여 평균 대여 시간 가장 짧은 고객 5명 조회.
 - 대여 간격 계산:
   동일 고객의 대여 날짜(rental_date)를 기준으로 대여 간격을 계산.
 - 인라인 뷰 사용

 */

-- 필요한 value들이 customer와 rental table에 있기때문에 customer + rental table을 만들어야됨
SELECT c.customer_id, -- 고객의 ID
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name, -- 고객의 이름
	   AVG(DATEDIFF(x.rental_date, x.last_rental_date)) AS time_diff -- 고객의 평균 대여 시간
  FROM ( -- Inline view에  
  	SELECT r.customer_id,
	       r.rental_date,
  		   LAG(r.rental_date) 
  		   OVER ( -- rental_date기준으로 rental_date 있는 row의 이전 row를 접근할수있게 LAG
    			 PARTITION BY r.customer_id -- PARTITION BY써서 customer_id기준으로 분할과 rental_date기준으로 정렬후
			     ORDER BY r.rental_date
			    ) AS last_rental_date 
	 FROM rental r
  ) AS x
 INNER JOIN customer c -- 고객의 성명을 customer_name에 삽입할수있게 JOIN
 	ON x.customer_id = c.customer_id
 GROUP BY x.customer_id -- 고객의 ID순으로 그룹화
 ORDER BY time_diff
 LIMIT 5
;

WITH x AS (
	SELECT r.customer_id,
	       r.rental_date,
  		   LAG(r.rental_date) 
  		   OVER (
    			 PARTITION BY r.customer_id
			     ORDER BY r.rental_date
			    ) AS last_rental_date 
	 FROM rental r
)
SELECT c.customer_id,
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	   AVG(DATEDIFF(x.rental_date, x.last_rental_date)) AS time_diff
  FROM x
 INNER JOIN customer c
 	ON x.customer_id = c.customer_id
 GROUP BY x.customer_id
 ORDER BY time_diff
 LIMIT 5
;

WITH x AS (
	SELECT r.customer_id,
	       r.rental_date,
  		   LAG(r.rental_date) 
  		   OVER (
    			 PARTITION BY r.customer_id
			     ORDER BY r.rental_date
			    ) AS last_rental_date 
	 FROM rental r
),
y AS (
	SELECT c.customer_id,
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	   AVG(DATEDIFF(x.rental_date, x.last_rental_date)) AS time_diff
  	 FROM x
	INNER JOIN customer c
 	   ON x.customer_id = c.customer_id
    GROUP BY x.customer_id
)
SELECT RANK()
	   OVER(ORDER BY y.time_diff) AS customer_rank,
	   y.customer_name,
	   y.time_diff
  FROM y
;