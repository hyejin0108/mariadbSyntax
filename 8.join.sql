-- inner join
select * from author inner join post on author.id = post.id;
select * from author a inner join post p on a.id=p.author_id;

--문제
select p.id, p.title,p.contents,a.email
from post p join author a on a.id = p.author_id;

select p.id, p.title,p.contents,a.email
from post p left join author a on p.author_id = a.id;

-- join된 상황에서 where조건: on 뒤에 where 조건이 나옴
select * from author;
select p.title, a.email
from post p left join author a on p.author_id = a.id
where a.age >= 25;

select p.title,a.email
from post p join author a on p.author_id = a.id
where date_format(p.created_time,'%Y-%m-%d') >= '2024-05-01';

-- union : 집합, 컬럼의 개수와 타입이 같아야함
-- union all : 중복 포함
-- 유지보수성 : 서비스 유지, 고치기. 간결성과 직관성

-- 서브쿼리 : select 문 안에 또다른 select 문을 서브쿼리라 한다
-- select, from, where 안에 서브쿼리가 들어감

-- select
select email, (select count(*) from post where author_id = author.id) count from author;

-- from
select a.name from (select * from author) as a;

-- where
select a.* from author a join post p on a.id=p.author_id;
select * from author a, post p where a.id = p.author_id;

-- 프로그래머스 - 없어진 기록~~

-- 집계함수
-- count(), max(), min(), sum(), avg(), round(값, 소수점자리),
-- group by 집계함수
select author_id, count(*), sum(price), round(avg(price),0) from post group by author_id;

-- 저자 email, 해당 저자가 작성한 글 수를 출력
select a.id, if(p.id is null,0, count(*)) from author a left join post p on a.id = p.author_id group by a.id;
select date_format(created_time,'%Y') year, count(*)
from post
where created_time is not null
group by year;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기