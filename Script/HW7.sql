USE sakila;

/*
문제 7: 특정 기간 동안 대여된 영화 목록
특정 기간(예: 2005년 5월 1일부터 2005년 5월 31일) 동안 5회 대여된 영화 목록과 대여 건수 조회
 - 기간 조건 추가:
   rental_date를 기준으로 특정 기간에 해당하는 대여 데이터를 필터링.
 - 인라인 뷰 사용 
 */

-- Inline View로 영화이름과 대여 건수 table을 만든후 대여 건수가 5인 영화만 나오게 조건문
-- 필요한 value들이 film과 rental table들에 있기때문에 film + inventory + rental table을 만들어야됨
SELECT *
  FROM (
  	SELECT f.title as film_title, -- 영화명
	   	   COUNT(f.title) AS rental_count -- 대여 개수
  	  FROM film f -- film이 어떤 inventory에 보관되어 있는지 찾기위해 film이랑 inventory를 film_id기준으로 합
	 INNER JOIN inventory i
 		ON f.film_id = i.film_id 
	 INNER JOIN rental r --  rental기록들에 어떤 inventory가 입력됬는지 찻기위해 (film + inventory)랑 rental을 inventory_id기준으로 합
 		ON i.inventory_id = r.inventory_id 
	 WHERE r.rental_date BETWEEN '2005-05-01' AND '2005-05-31' -- 대여된 날짜가 2005-05-01이랑 2005-05-31인 영화들만
	 GROUP BY f.title -- 영화명 기준으로 그룹화
  ) AS x -- inline view로 table을 먼저 만들고
  WHERE x.rental_count = 5 -- inline view로 만든 table애서 대여 개수가 5개인 것만
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
