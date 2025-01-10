USE sakila;

SELECT s.store_id, -- store의 store_id
	   AVG(TIMESTAMPDIFF(HOUR, r.rental_date, r.return_date)) as avg_return_time -- rental의 rental_date과 return_date을 이용해 대여 및 반환 간의 시간 차이
  FROM store s -- store와 inventory를 store_id 기준으로 합
 INNER JOIN inventory i
 	ON s.store_id = i.store_id 
 INNER JOIN rental r -- rental와 inventory_id를 inventory_id 기준으로 합
 	ON i.inventory_id = r.inventory_id
 GROUP BY s.store_id -- store의 store_id 기준으로 그룹화
 ORDER BY s.store_id DESC -- store의 store_id 기준 내립차순으로 정렬
;