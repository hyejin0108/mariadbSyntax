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
