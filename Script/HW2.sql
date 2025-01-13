USE sakila;

/*
문제 2: 특정 배우가 출연한 영화의 매출 기여도 분석
특정 배우(예: "TIM HACKMAN")가 출연한 영화가 총 매출에 얼마나 기여했는지 조회
해결 방법
 - 배우 ID 조회: actor 테이블에서 해당 배우의 ID를 조회.
 - 영화 목록 조회: film_actor와 film 테이블을 연결하여 해당 배우가 출연한 영화 목록을 확인.
 - 매출 기여도 계산: 대여와 결제를 연결하여 총 매출 기여도를 계산.
*/

-- 필요한 value들이 actor, film, 그리고 payment table들에 있기때문에 actor + film_actor + film + inventory + rental + payment table을 만들어야됨
SELECT a.first_name, -- actor의 first_name
	   a.last_name, -- actor의 last_name 
	   f.title, -- film의 title
	   SUM(p.amount) AS total_revenue -- payment의 amount 합
  FROM actor a -- actor의 특정한 film_actor의 row를 찾기위해 actor와 film_actor를 actor_id 기준으로 합
 INNER JOIN film_actor fa
 	ON a.actor_id = fa.actor_id
 INNER JOIN film f -- film_actor의 특정한 film의 row를 찾기위해 (actor + film_actor)와 film을 film_id 기준으로 합
 	ON f.film_id = fa.film_id
 INNER JOIN inventory i -- film의 특정한 inventory의 row를 찾기위해 (어떤 inventory에서 대여를 했는지 찾기위해) (actor + film_actor + film)와 inventory를 film_id 기준으로 합
    ON i.film_id = f.film_id
 INNER JOIN rental r -- inventory의 특정한 rental의 row를 찾기위해 (어떤 inventory가 특정한 rental 기록에 입력됬는지 찾기위해) (actor + film_actor + film + inventory)와 rental를 film_id 기준으로 합
 	ON r.inventory_id = i.inventory_id
 INNER JOIN payment p -- rental의 특정한 payment의 row를 찾기위해 (어떤 rental 기록이 특정한 payment 기록에 입력됬는지 찾기위해) (actor + film_actor + film + inventory + rental)와 payment를 film_id 기준으로 합
 	ON p.rental_id = r.rental_id
 WHERE a.first_name = 'Tim' -- actor의 first_name가 Tim이고
   AND a.last_name = 'Hackman' -- last_name이 Hackman인 row만
 GROUP BY f.title -- Tim Hackman이 출연한 영화들의 매출 기여도들을 보여주기 위해 film의 title로 그롭화
 ORDER BY total_revenue DESC -- total_revenue를 내림차순으로 정렬
;