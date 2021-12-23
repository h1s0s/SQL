--
--DDL 테이블 관리
--기본문법
--1.CREATE
--webdb 계정에 book 테이블 만들기
--create table '테이블명'(
--'컬럼명' '자료형');
create table book(--create table '테이블명( *테이블에 예약어 x
    book_id number, --컬럼명 자료형
    title varchar2(50),
    author varchar2(10),
    pub_date date
);
--2. Alter
--ㅇ컬럼 추가
--alter table '테이블명' add('컬럼명' '자료형'); 
alter table book add (pubs varchar2(50));
--ㅇ컬럼 수정
--alter table '테이블명' Modify();
alter table book modify(title varchar2(100));
--alter table '테이블명' Rename column '컬럼명' to '수정할이름';
alter table book rename column title to subject;
--ㅇ컬럼 삭제
--alter table '테이블명' drop('컬럼명');
alter table book drop(author);

--3.Rename~to~
--ㅇ테이블명 수정
--rename '테이블명' to '수정할테이블명';
rename book to article;
--ㅇ테이블 삭제
--drop table '테이블명'
drop table article;

select * from article;

/*
테이블 생성시 제약조건(옵션, 있어도되고 없어도 됨)
not null : null값 입력 불가 ex)이름 등
unique : 중복값 입력 불가(null값은 허용) ex) 주민번호 등
primary key : not null + unique, 테이블당 1개만 설정 가능
foreign key : 외래키
*/

--ㅇauthor 테이블 만들기
create table author(
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);
select * from author;
--ㅇbook 테이블 만들기
create table book(
    book_id     number(10),
    title       varchar2(100)   not null,
    pubs        varchar2(100),
    pub_date    date,
    author_id   number(10),
    primary key(book_id),
    constraint book_fk foreign key  (author_id) -- constraint 테이블명_fk foreign key (본인테이블의 fk 컬럼)
    references author(author_id));--참조 pk가 있는 테이블명(컬럼명) 

------------------------------------------------------------------------------------------------------------------
--DML 데이터 제어
--insert 데이터추가
--1.묵시적 방법
insert into author
values (1, '박경리', '토지 작가');
--2.명시적 방법
insert into author(author_id, author_name)
values (2, '이문열');

insert into author
values(3, '기안84', '웹툰 작가');
------------------------------------------------------------------------------------------------------------------
--UPDATE 데이터 수정
update  author
set     author_name = '김경리'
where   author_id = 1;
--delete 데이터 삭제
delete  from author
where   author_id = 1;
--전부 지우기
delete from author; --주의 다지움
------------------------------------------------------------------------------------------------------------------
--시퀀스(번호표) (많이 사용함)
--연속적인 일련번호 -> pk에 주로 사용됨
--1. 무조건 건들여지면 숫자가 카운트됨, 에러가 나도 숫자가 올라감.
--허나 pk는 꼭 번호가 연속되지 않을 수 있음, 겹치지만 않아도 되기 때문에 문제 없음.
--ㅇ시퀀스 생성
create sequence seq_author_id
increment by 1 -- 몇씩 올라갈건지
start with 1 --몇번부터 시작하는지
;
--ㅇ시퀀스를 사용해 데이터 추가
--insert into 테이블명
--values (시퀀스이름(알아서 번호가 매겨짐), 데이터, 데이터);
insert into author
values (seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values (seq_author_id.nextval, '이문열', '삼국지 작가');

--모든 시퀀스 조회
select  *
from    user_sequences;
--현재 시퀀스 조회
select  seq_author_id.currval
from    dual;
--다음 시퀀스 조회
select  seq_author_id.nextval
from    dual;
--시퀀스 삭제
drop sequence seq_author_id;
------------------------------------------------------------------------------------------------------------------
select * from book;
select * from author;
select * from all_tables;
------------------------------------------------------------------------------------------------------------------
--실습문제 풀기전 오늘 만들어 둔거 삭제
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