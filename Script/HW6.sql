USE sakila;

/*
문제 6: 특정 카테고리의 대여 트렌드 분석
특정 카테고리(예: "Action"에 대해)의 대여 트렌드를 분석하여 월m별 대여 횟수 조회.
 - 카테고리 ID 조회:
   category 테이블에서 해당 카테고리 ID를 조회.
 - 월별 대여 횟수 집계:
   film_category와 rental을 연결하여 대여 데이터를 분석.
*/

-- 필요한 value들이 category와 rental에 있기때문에 category + film_category + film + inventory + rental table을 만들어야됨
SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS month, -- rental_date를 연과 달로 format
	   COUNT(r.rental_id) AS rental_count -- 대여 개수
  FROM category c -- cateogry에 해당되는 film_category를 찻기위해 category를 film_category랑 category_id기준으로 합
 INNER JOIN film_category fc
 	ON c.category_id = fc.category_id
 INNER JOIN film f -- film_category에 해당되는 film들을 찻기위해 (category + film_category)를 film랑 film_id기준으로 합
 	ON fc.film_id = f.film_id
 INNER JOIN inventory i -- film이 어떤 inventory에 보관되있는지 찻기위해 (category + film_category + film)을 inventory랑 film_id기준으로 합
 	ON f.film_id = i.film_id
 INNER JOIN rental r -- rental을 어떤 inventory에서 했는지 찻기위해 (category + film_category + film + inventory)를 rental이랑 inventory_id기준으로 합
 	ON i.inventory_id = r.inventory_id
 WHERE c.name = 'Action' -- category의 name이 Action인 것만
 GROUP BY month -- month기준으로 그룹화
 ORDER BY month -- month기준으로 정렬
;