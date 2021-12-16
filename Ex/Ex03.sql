-------------------------------------------------------------------------------
--DML_SELECT_02
--1. 그룹함수(집계함수, 복수행함수): 여러건의 데이터를 한꺼번에 처리후 1개의 결과로 처리
--그룹함수는 하나의 row에 값이 나옴(많은 row를 가진 컬럼을 같이 출력하면 오류남. 오라클에서는 안되는 개념)

--count()
--row의 갯수를 세주는 함수
--1. 괄호에 *를 넣으면, 모든 row를 출력함. (Null이 포함됨)
--2. 특정 컬럼의 이름을 넣으면, 그 컬럼에 null을 제외한 row를 출력함. (Null이 제외됨)
select  count(*),
        count(commission_pct)
from employees;

--월급이 16000 이상인 사람을 카운트 해라
select count(*)
from employees
where salary >= 16000;

--부서번호가 100번인 사람의 갯수
select count(*)
from employees
where department_id = 100;

--sum()
--입력된 데이터들의 합계 값을 구하는 함수
--숫자만 있는 컬럼만 가능.
select sum(salary), count(*), avg(salary)
from employees;

select sum(salary), count(*), avg(salary)
from employees
where salary > 16000;

--avg(컬럼명)
--컬럼명의 모든 값의 평균을 계산해주는 함수
--널값이 있는경우 빼고 계산함. 
--null값을 포함하고 싶다면 nvl함수와 같이 사용.
select  avg(salary),
        round(avg(salary), 2)
from employees;

select  count(*),
        sum(salary),--합계
        avg(salary)--평균
from employees;

select  count(*),
        sum(salary),
        avg(nvl(salary, 0))
from employees;

--max() / min()
--최대값/최소값을 구하는 함수
select  count(*), 
        max(salary), 
        min(salary)
from employees;

-------------------------------------------------------
--GROUP by 절
--그룹함수가 있을때만 쓴다.
select  avg(salary), department_id
from employees
group by department_id; -- 같은 값을 가진 애들을 알아서 묶음.