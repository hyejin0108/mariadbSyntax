-- 흐름제어 : case문 
select 컬럼1, 컬럼2,
case 컬럼4
    when 조건문 then 결과
    when 조건문 then 결과
    else 
end
from 테이블명;

select id,title,contents,
case author_id
    when 1 then 'first author'
    when 2 then 'second author'
    else 'others'
end author_id
from post;

--문제
SELECT id, title, contents, ifnull(author_id,'익명사용자') author_id
from post;

select id,title,contents,
case 
    when author_id is null then '익명사용자'
    else author_id
end author_id
from post;

select id,title,contents,if(author_id is null, '익명사용자',author_id) author_id
from post;
-- end

--post에 글 쓴후 cnt +1 > 트랜잭션
start transaction;
update author set post_cnt = post_cnt+1 where id = 8; -- 성공
insert into post(title, author_id) values ('zz',9); --실패
commit;
--또는
rollback;

-- 프로시저 : 성공하면 ~~, 실패하면 ~~ 정의 -> 분기처리
-- stored 프로시저를 활용한 트랜잭션 테스트

DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_cnt = post_cnt + 1 WHERE id = 8;
    -- UPDATE가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN
        ROLLBACK;
    END IF;
    -- INSERT 구문
    INSERT INTO post (id, title, contents, author_id) VALUES (9, 'ERAWE', '2231', 2);
    -- INSERT가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN
        ROLLBACK;
    END IF;
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();


-- stored 프로시저를 활용한 트랜잭션 테스트
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 5);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;

-- 