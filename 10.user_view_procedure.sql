-- 계정 관리법
-- 사용자 조회
SELECT * FROM musql.user;

-- 주문서비스, 게시판 > ERD, DB, 쿼리
-- 주문서비스 - product, user, order, order_list..

-- %는 원격 포함한 anywhere 접속
--  사용자 생성
create user 'test1'@'localhost' identified by '1234';

-- 처음들어가면 아무것도 없음. 권한 부여 필요
-- 사용자에게 권한부여
grant select on board.author to 'test1'@'localhost';
grant update on ~~;
revoke select on board.author from 'test1'@'localhost';
--환경설정 변경 후 확정
flush privileges;

select * from board.author;

show grants for 'test1'@'localhost';

drop user 'test1'@'localhost';

-- view -> 다른 사용자가 볼 수 있는 테이블 or 쿼리를 만들어 보여줌
-- view 생성
create view author_for_marketing_team as 
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- view 권한 부여
grant select on board.author_for_marketing_team to 'test1'@'localhost';

-- view 변경(대체)
create or replace view board.author_for_marketing_team as 
select name, email, age, role from author;

-- 삭제
drop view author_for_marketing_team;
