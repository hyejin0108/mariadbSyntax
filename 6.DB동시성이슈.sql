-- dirty read 실습
-- auto commit 해제 후 워크 벤치 update, 터미널 read
-- 격리수준 uncommited read > commited read

-- phantom read  동시성 이슈 실습
-- 워크벤치에서 select 2개를 날림. 터미널에서 중간에 insert 실행
-- commited read > repeatable read(다른 트랜잭션의 insert/update를 막음, 한 트랜잭션에서 같은 select 결과 보장)
START TRANSACTION
select * from author;
do sleep(15);
select * from author;
commit;

insert into author(email) values ('svivs@ooo.ooo');

-- insert/update가 됏음에도 트랜잭션에 반영되지 않는 문제
-- lost update문제를 해결하기 위한 공유락
-- 워크벤치에서 아래 코드실행
start transaction;
select post_cnt from author where id =8 lock in share mode;
do sleep(15);
select post_cnt from author where id =8 lock in share mode;
commit;

-- 터미널
select post_cnt from author where id =8 lock in share mode; -- 허용
update author set post_cnt=0 where id=8; -- update, insert 허용 x

-- 배타적 락
start transaction;
select post_cnt from author where id =8 for update;
do sleep(15);
select post_cnt from author where id =8 for update;
commit;

-- 터미널
select post_cnt from author where id =8 for update; -- 허용 X
update author set post_cnt=0 where id=8; -- update, insert 허용 x

-- serializable : 모든 트랜잭션 순차실행, 배타락은 특정 쿼리를 지정하지만, 이 수준은 데이터베이스 전체에 걺

