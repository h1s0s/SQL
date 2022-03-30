--SQL 
--select문 select, from절---------------------------------------------------

select * --전체 데이터 가져오기
from employees; --employees의

select * --전체 데이터 가져오기
from departments; --departments의

select employee_id, first_name, Last_name, Email -- 이것만 가져와줘
from employees; --employees의

--예제1
select first_name, phone_number, hire_date, salary
from employees;

--예제2, 출력할 컬럼명에 별명 적용하기
select employee_id as empNo,--2. as 방식 무조건 대문자로 적용됨.
        first_name 성,--1. 띄워쓰고 쓰는 방식 -> 무조건 대문자로 적용됨
        salary "이름" --3 따옴표 방식, 대소문자, 공백, 특수문자 가능.
from employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기
select first_name ||' '||last_name-- ' ' 중간에 공백을 줌, 홑따옴표를 이용해 데이터를 줄 수 있을거 같음.
from employees;

select first_name ||' '||last_name name -- 연결된 컬럼들을 하나의 이름으로 정리됨.
from employees;

--산술 연산자 사용
--값이 숫자면 +, -, *, /를 사용 할 수 있음.
--문자열에 사칙연산은 불가. 에러남.
select  first_name as 이름,
        salary as 월급,
        salary*12 as 연봉, -- 같은 컬럼을 두개 가져올 수 있음, 하지만 겹치는 이름은 _번호 가 매겨짐.
        (salary+300)*12
from employees;

--예제
select  first_name||'-'||last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 연봉2,
        phone_number 전화번호  
from employees;
--Where절----------------------------------------------------------------------
--비교연산자
--부서번호(department_id)가 "10인(=10)" 사원의 정보를 구하시오.
select  first_name,
        last_name,
        salary,
        department_id
from employees
where department_id = 10;--
--예제문제 1 9page
--연봉이 15000이상의 정보 출력
select  first_name||'-'||last_name 이름,
        salary 월급,
        salary*12 연봉
from employees
where salary*12 > 15000;

--예제문제 2 9page
select  first_name||'-'||last_name 이름,
        hire_date 입사일
from employees
where hire_date >= '07/01/01';--연월일순, 이 표기법을 변경 할 수 있다.

--예제문제 3 9page
select  first_name||'-'||last_name 이름,
        salary*12 연봉
from employees
where first_name = 'Lex';--문자열은 대소문자를 구분함.

--조건이 2개이상 일때 한꺼번에
--and, or    
select first_name, salary
from employees
where salary >= 14000
and salary <= 17000;

select first_name, salary
from employees
where salary <= 14000
or salary >= 17000;

--예제문제 1 10page
select first_name||'-'||last_name 이름,
        hire_date 연봉
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31'
;
--between 연산자(x and y) x와 y의 사이의 값
--특정구간 값 출력하기
--양쪽 값을 포함할때만 가능(이상, 이하만 가능)

select first_name, salary
from employees
where salary between 14000 and 17000;

--in 연산자
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John'); 
--예제문제
--연봉이 2100, 3100, 4100, 5100인 사원의 이름과 연봉을 구하시오
select first_name, salary
from employees
where salary in (2100, 3100, 4100, 5100);

--like 연산자
--이것을 포함한 값을 가지고있는 열을 띄워라
-- % 임의의 길이의 문자열
-- - 한글자 길이
select *
from employees
where first_name like 'L%';

--예제
--이름에 am을 포함한 사원의 이름과 연봉을 출력하세요
select first_name, salary
from employees
where first_name like '%am%';
--이름의 두번째 글자가 a인 사원의 이름과 연봉을 출력하세요
select first_name, salary
from employees
where first_name like '_a%';
--이름의 네번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';
--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요.
select first_name
from employees
where first_name like '__a_';
-------------------------------------------------------------------------------
--NULL
--null은 어떠한 값이 한번도 들어온 적이 없는것임. 아무런 값도 정해지지 않음.
--0은 값이 0인것, 누군가가 의도적으로 0을 넣은것.
--테이블을 만들때 (컬럼에) null을 넣게 할지 말지를 지정 해줄 수 있다.
--기본키나 not null 속성에는 null을 사용 할 수 없음.
--값에 null을 곱하면 null이 됨. null을 포함한 산술식은 null이 된다.
select first_name, salary, commission_pct, salary*commission_pct 
from employees
where salary between 13000 and 15000;
--is null/is not null
--is null : null인 애들만 가져와라.
select first_name, salary, commission_pct
from employees
where commission_pct is null;
--예제문제
--커미션비율이 있는 사원의 이름과 연봉 커미션 비율을 출력하세요
select first_name, salary 연봉, commission_pct*salary 연봉커미션비율
from employees
where commission_pct is not null;
--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
--복수는 and로 구분

select first_name, manager_id, commission_pct
from employees
where manager_id is null
and commission_pct is null;
-------------------------------------------------------------------------------
--Order by 절
--오름차순, 
-- asc 작은것에서 큰것 순으로 정렬.
select first_name, salary
from employees
where salary >= 9000
order by salary asc;
--예제문제
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select employee_id, department_id, salary, first_name
from employees
order by employee_id asc;
--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name, salary
from employees
where salary >= 10000
order by salary desc;
--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select department_id, salary, first_name
from employees
order by department_id asc, salary desc;
