--1. insert into : 데이터 삽입
-- ex) insert into 테이블명 (컬럼1, 컬럼2, 컬럼3) values (데이터1, 데이터2, 데이터3);
INSERT INTO author(id, name, email) values (1,'이혜진','svivs@ooo.com');
insert into posts(id, title, content) values (1,'gg','gg');

--테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

--테이블 index조회
show index from author;
show index from posts;

--Alter문 : 테이블 구조 변경
--테이블 이름 변경
alter table posts rename post;
--테이블 컬럼 추가
alter table author add column test1 varchar(50);
--테이블 컬럼 삭제
alter table author drop column test1;
--테이블 컬럼 변경
alter table post change column content contents varchar(25);
--테이블 컬럼 제약조건 변경
alter table author modify column email varchar(255) not null;

--테이블 삭제
drop table 테이블명;

--테이블명추가

update author set email='';

delete from author where id =3;

drop table abc if exists abc; --쿼리 한번에 돌릴때 에러가 안남

--특정 컬럼만을 조회할때 
SELECT name, email from author where id =1;
--중복제거 조회
SELECT distinct title from post;
--정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬 조건 없이 조회될 경우에는 pk기준을 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;
select * from post order by title; --asc/desc 생략시 오름차순

select * from post order by title;
select * from post order by title, id desc;

--limit : 결괏값 개수 제한
select * from author order by id desc limit 1;

--alias select 
select id, name as 이름, email as 이메일, password as PW from author; 
select a.name, a.email from author a; 

-- null을 조회조건으로
select * from post where author_id is null;
select * from post where author_id is not null;

--tinyint -128~127
--insert 200 > 125
alter table author modify column age tinyint unsigned;

-- 고정소수점 > 정확한 값, 부동소수점 > 근사값
-- 고정소수점 decimal(m,d)
-- 65자리까지 표현가능


--decimal 실습
alter table post add column price decimal(10,3);

--char 고정길이, varchar 가변길이 > 미리 차지하냐 안하냐
