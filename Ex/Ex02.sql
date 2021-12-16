--단일행 함수

--1. 문자함수 
--INITCAP(컬럼명)
--영어의 첫 글자만 대문자로 출력하고 나머지는 소문자
select email 이메일, initcap(email) 이메일2, department_id 부서번호
from employees
where department_id = 100;

--LOWER(컬럼명)
--입력되는 값을 전부 소문자로 변경하는 함수
--UPPER(컬럼명)
--입력되는 값을 전부 대문자로 변경하는 함수
select  first_name 이름, 
        lower(first_name) 이름소문자, 
        upper(first_name) 이름대문자
from employees
where department_id = 100;

--SUBSTR(컬럼명, 시작위치, 글자수)
--주어진 문자열에서 특정길이의 문자열을 구하는 함수
select  first_name, 
        substr(first_name,1,3), 
        substr(first_name,-3,2)
from employees
where department_id = 100;

--LPAD(컬럼명,자리수,'채울문자') 자리수만큼 지정한 문자를 채움
--LPAD():왼쪽 공백에 특별한 문자로 채우기
--RPAD(컬럼명,자리수,'채울문자') 자리수만큼 지정한 문자를 채움
--RPAD():오른쪽 공백에 특별한 문자로 채우기.
select  first_name,
        lpad(first_name,10,'*'),
        rpad(first_name,10,'*')
from employees;

--REPLACE(컬럼명, 문자1, 문자2)
--컬럼명에서 문자1을 문자2로 바꾸는 함수
select  first_name,
        replace(first_name, 'a', '*')
from employees
where department_id = 100;

select  first_name,
        replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***')
        --substr을 활용가능
        --실무 응용법 : 당첨자 아이디의 일부를 *로 가림
from employees
where department_id = 100;

--2. 숫자함수
--ROUND(숫자, 출력을 원하는 자리수)
--주어진 숫자의 반올림을 하는 함수
select  round(123.346, 2) "r2",
        round(123.556, 0) "r0",
        round(123.556, -1) "r-1" -- -되면 정수 첫번째자리 반올림
from dual;

--Trunc(숫자, 출력을 원하는 자리수)
--주어진 숫자의 버림을 하는 함수
select  trunc(123.346, 2) "r2",
        trunc(123.456, 0) "r0",
        trunc(123.456, -1) "r-1"
from dual;

--mod(숫자, 자리수)
--주어진 숫자의 나머지를 주는 함수
select  mod(123.346, 2) "r2",
        mod(123.456, 0) "r0",
        mod(123.456, -1) "r-1"
from dual;

--3.날짜함수
--sysdate
--현재 날짜를 출력해주는 함수
select sysdate
from dual;

--months_between(d1,d2)
--d1날짜와 d2날짜의 개월수를 출력하는 함수
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date),
        round(months_between(sysdate, hire_date), 0),
        trunc(months_between(sysdate, hire_date), 0)
from employees
where department_id = 100;

--4. 변환함수
--문자, 숫자, date간의 변환

--to_char(숫자, '출력모양') 숫자형->문자형
--출력모양 
-- 9 : 9의 개수 자리수 만큼 표시, 0 : 자리수 채우고 빈자리를 0으로 채우기, $ $표시를 붙여서 표시
-- . 소수점 이하 표시, , 천단위 이하 표시

select  first_name,
        salary,
        to_char(salary*12, '999999') "기본형",
        to_char(salary*12, '000000') "0을 사용",
        to_char(salary*12, '999999') "$를 사용",
        to_char(salary*12, '$999,999.99') ",와.을사용"
from employees
where department_id = 100;

--to_char(숫자, '출력모양') 날짜형->문자형
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') 날짜,
        to_char(sysdate, 'MON') 월,
        to_char(sysdate, 'DD') 일,
        to_char(sysdate, 'ddth') 몇번째날,
        to_char(sysdate, 'hh') 몇시,
        to_char(sysdate, 'mi') 몇분,
        to_char(sysdate, 'ss') 몇초
from dual;

select  sysdate,
        to_char(sysdate, 'dd'),
        hire_date,
        to_char(hire_date, 'MM')
from employees;

--예제문제
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') 날짜,
        to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') 날짜,
        to_char(sysdate, 'YY"년"MM"월"DD"일"(Dy) HH24"시"MI"분"SS"초"') 날짜,
        to_char(sysdate, 'Day') 요일
from dual;

--일반함수>NVL(컬럼명, null일때값)
--NVL2(컬럼명, null이 아닐때 값, null일때 값)
select  first_name,
        commission_pct,
        nvl(commission_pct, 0),
        nvl2(commission_pct, 100, 0)
from employees;

