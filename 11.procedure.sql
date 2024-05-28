-- 프로시저 생성
DELIMITER // --시작
CREATE PROCEDURE test_procedure()
BEGIN
    -- 쿼리 들어오는 자리
    select 'hello world';
END
// DELIMITER ; -- 끝

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성

DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- 게시글 1건 조회 동적 프로그래밍

DELIMITER //
CREATE PROCEDURE 게시글단건조회(in postId int)
BEGIN
    select * from post where id = postId;
END
// DELIMITER ;
call 게시글단건조회(2);


DELIMITER //
CREATE PROCEDURE 작가id조회(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post where author_id = 저자id and title = 제목;
END
// DELIMITER ;
call 작가id조회(8,'test');

-- 글쓰기
DELIMITER //
CREATE PROCEDURE 글쓰기(in title varchar(255), in contents varchar(255), in emailinput varchar(255))
BEGIN
    declare authorId int;
    select id into authorId from author where email = emailinput;
    insert into post(title, contents, author_id) values (title, contents, authorId);
END
//DELIMITER ;

-- sql에서 문자열 합치는 concat()
-- 글 상세조회 : input 값이 postId
-- title, contents, author_id + '님'

DELIMITER //
CREATE PROCEDURE 게시글조회(in postId int)
BEGIN
    declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님')
    select title, contents, authorName from post where id = postId;
END
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE 게시글조회2(in postId int)
BEGIN
    select p.title, p.contents, concat(a.name,'님') name from post p join author a on p.author_id=a.id where p.id = postId;
END
//DELIMITER ;

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다 10개이상 100개 미만 중수 그외 초보
-- input email
DELIMITER //
CREATE PROCEDURE 등급조회(in emailIn varchar(255))
BEGIN
    declare postCnt int;
    select count(*) into postCnt from post where author_id = (select id from author where email=emailIn);
    select case 
        when postCnt >= 100 then '고수입니다'
        when postCnt >=10 then '중수입니다'
        else '초보입니다'
    end 등급;
END
//DELIMITER ;

-- if else문
DELIMITER //
CREATE PROCEDURE 등급조회(in emailIn varchar(255))
BEGIN
    declare postCnt int;
    select count(*) into postCnt from post where author_id = (select id from author where email=emailIn);
    IF postCnt >= 100 then
        select '고수입니다'
    ELSEIF postCnt >= 10 then
        select '중수입니다.'
    else
        select '초보입니다.'
    end if;
END
//DELIMITER ;

-- 반복문을 통해 post 대량 생산
-- 사용자가 입력한 반복 횟수에 따라 글이 도배가됨 title 안녕하세요
DELIMITER //
CREATE PROCEDURE 글도배(in cnt int)
BEGIN
    declare a int default 0;
    WHILE a<cnt DO
        insert into post(title) values ('안녕하세요');
        set a = a+1;
    END WHILE;
END
//DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';

-- 숙제: 주문 DB 설계 구축 테스트 코드
-- my.ini network 최대 연결시간, 트랜잭션 최대처리개수 등