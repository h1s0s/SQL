------------------------------------------------------------------------------------------------------------------
--ㅇ시퀀스 보기
select * from user_sequences;
--ㅇ시퀀스 삭제
drop sequence seq_author_id;
drop sequence seq_book_id;
--ㅇ데이터 삭제
delete from author;
delete from book;
--ㅇ테이블 삭제
drop table book;
drop table author;
-------------------------------------------------------------------------------------------------------------------
--실습문제
--1. book과 author 테이블 만들기
create table author(
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);
create table book (
    book_id     number(10),
    title       varchar2(100),
    pubs        varchar2(100),
    pub_date    date,
    author_id   number(10),
    primary key(book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id)); 
);
--2. 시퀀스 만들기
create sequence seq_book_id
increment by 1
start with 1;
create sequence seq_author_id
increment by 1
start with 1;
--3. 데이터 추가하기
insert into author
values (seq_author_id.nextval, '김문열', '경북 영양');
insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');
insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');
insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');
insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');
insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);
insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);
insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);
insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);
insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

-- 4. 테이블 출력
select  bo.book_id, bo.title, bo.pubs, bo.pub_date, au.author_id, au.author_name, author_desc
from    book bo, author au
where   au.author_id = bo.author_id;

-- 5. 강풀정보 변경
update  author
set     author_desc = '서울특별시'
where   author_id = 5;