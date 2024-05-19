-- 데이터베이스 접속
mariadb -u root -p

-- 스키마 목록 조회
show databases;

--데이터베이스 생성
CREATE DATABASE board;

--데이터베이스 선택
USE board;

--테이블 조회
SHOW tables;

--author table 생성
CREATE TABLE author(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE posts(
    id INT,
    title VARCHAR(255),
    content VARCHAR(255),
    author_id INT,
    PRIMARY KEY(id),
    foreign key(author_id) references author(id)
);

--테이블 컬럼 조회
DESCRIBE author;
--컬럼 상세조회
SHOW FULL columns FROM author;

--테이블 생성문 조회
show CREATE table author;

--외래키 : not null, unique 아님
--fk delete, update restrict ->set null(null 셋), cascade(둘다 삭제)
