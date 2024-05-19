alter table author modify column id bigint auto_increment;

--조회
select * from information_schema.key_column_usage where table_name='post';
--삭제
alter table post drop foreign key post_ibfk_1;
alter table author modify column id bigint auto_increment;
--추가
alter table post add constraint post_ibfk_1
foreign key(author_id) references author(id);

--uuid
alter table post add column user_id char(36) default (UUID());
insert into post(title) values('abc');
select * from post;

--unique, pk, fk -> index 생성
--unique 제약조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 - 부모 테이블 id를 수정하면? 수정안됨
alter table post drop foreign key post_ibfk_1;
alter table post add constraint post_ibfk_1
foreign key(author_id) references author(id) on delete cascade;
alter table post add constraint post_ibfk_1
foreign key(author_id) references author(id) on update cascade;

-- 부모 테이블 변경/삭제하면서 에러 확인, 자식테이블의 변경 삭제는 부모테이블에 영향이 없음

--실습 delete 는 set null, update cascade
alter table post add constraint
fk1 foreign key(author_id) references author(id) on delete set null on update cascade;

-- fk 생성 제약조건, index 생성 