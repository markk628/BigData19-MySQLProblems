USE sakila;

/*
문제 3: 가장 신속한 대여 및 반환 서비스 제공 매장 분석
어떤 매장이 가장 신속하게 대여 및 반환 처리를 하는지 조회
해결 방법
 - 대여 및 반환 간의 시간 차이 계산: AVG(TIMESTAMPDIFF(대여일, 반환일)) 사용
   rental_date와 return_date를 사용해 반환까지 걸린 시간을 평균으로 계산.
*/

-- 필요한 value들이 store와 payment table들에 있기때문에 store + inventory + rental table을 만들어야됨
SELECT s.store_id, -- store의 store_id
	   AVG(TIMESTAMPDIFF(HOUR, r.rental_date, r.return_date)) as avg_return_time -- rental의 rental_date과 return_date을 이용해 대여 및 반환 간의 시간 차이들의 평균
  FROM store s -- store이 어떤 inventory에서 대여할 영화를 보냈는지 잦기위해 store와 inventory를 store_id 기준으로 합
 INNER JOIN inventory i
 	ON s.store_id = i.store_id 
 INNER JOIN rental r -- rental을 어떤 inventory에서 받았는지 찾기위해 (store + inventory_id)와 rental를 inventory_id 기준으로 합
 	ON i.inventory_id = r.inventory_id
 GROUP BY s.store_id -- 매장들의 서비스 제공 평균들을 보여주기위해 store의 store_id 기준으로 그룹화
 ORDER BY s.store_id DESC -- store의 store_id 기준 내립차순으로 정렬
;