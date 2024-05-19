-- blob 실습
insert into author(id,email,pofile) values (10,'zz',LOAD_FILE('C:\\a.jpeg'));

--enum :삽입할 수 있는 데이터 종류를 한정하는 데이터 타입
--role컬럼
alter table author add column role varchar(10);
alter table author add column role enum('user','admin') not null;

--enum 컬럼 실습
--user1을 insert

--user 또는 admin insert => 정상

--DATETIME 
alter table author add column role enum('admin', 'user') not null default;
alter table author add column birth_day date;
insert into author(id, email, birth_day) values(13,'zz','2000-01-08');

--datetime 타입
--author, post 둘다 datetime 으로 created_time 컬럼추가

alter table post modify column created_time datetime default current_timestamp;  --default 옵션 주기
select * from author;

-- and 또는 &&
-- or 또는 ||
-- NOT 또는 !
select * from post where id >=2 and id<=4;
select * from post where id between 2 and 4;
select * from post where !(id < 2 or id >4);

-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;

-- in (list)
select * from post where id in (1,2,3,4);

-- like : 특정 문자를 포함
select * from post where title like '%o';
select * from post where title like 'h%'; -- h로 시작하는
select * from post where title not like '%llo%'; --단어의 중간에 llo라는 키워드가 있는 경우 검색

-- ifnull(a,b) a가 null이면 b 반환
select ifnull(title,'no title') as title from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';
-- 날짜 변환 : 숫자 --> 날짜, 문자 -> 날짜
select cast(20200108 AS DATE);
select cast('20200102' AS DATE);
select convert(20200108 , DATE);
select convert('20200102' , DATE);

-- datetime 조회 방법
select * from post where created_time like '2024-05%';
select * from post where date_format(created_time,'%Y')='2024';
select * from post where created_time between '1999-01-01' and '2024-12-31';
select date_format(created_time, '%Y-%m') from post; -- Y, m, d, H,i,s

--오늘날짜
select now();
select date_format(now(),'%Y.%m.%d');
