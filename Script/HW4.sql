USE sakila;

/*
문제 4: 대여되지 않은 영화 목록 찾기
대여되지 않은 영화 조회
 - 대여된 영화와 대여되지 않은 영화 비교:
   inventory 테이블과 rental 테이블을 조인하여 대여되지 않은 영화를 찾음.
*/

-- 영화가 대여되지 않았으면 rental_id가 NULL
-- rental_id가 NULL인 영화들을 잦기위해 film + inventory + rental table을 LEFT JOIN의로 (rental table의 NULL값들을 봐야되니까) 만들어야됨
SELECT f.title -- film의 title 
  FROM film f -- film이 어떤 inventory에 보관되어 있는지 찾기위해 film이랑 inventory를 film_id기준으로 합
  LEFT JOIN inventory i
  	ON f.film_id = i.film_id
  LEFT JOIN rental r -- rental기록들에 어떤 inventory가 입력됬는지 찻기위해 (film + inventory)랑 rental을 inventory_id기준으로 합
  	ON r.inventory_id = i.inventory_id
 WHERE r.rental_id IS NULL -- rental_id가 NULL인 영화들만 (영화가 대여되지 않았으면 rental_id가 NULL이기 때문에)
;