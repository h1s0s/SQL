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
--group by에 참여한 컬럼이나 그룹함수만 올 수 있다.

select      department_id, avg(salary)
from        employees
group by    department_id -- 같은 값을 가진 애들을 알아서 묶음.
order by    department_id asc;

select      department_id, 
            count(*) 카운트, 
            avg(salary) 평균
from        employees
group by    department_id;

select      *
from        employees;

select      department_id, job_id, count(*), sum(salary)
from        employees
group by    department_id, job_id
order by    department_id asc, job_id desc;
--order by 아무것도 안쓰면 오름차순(asc)

--예제
--where절에는 그룹함수 사용 할 수 없다.
--having 절 사용 : 그룹함수와 group by 컬럼만 사용 가능
select   department_id, count(*), sum(salary)
from     employees
group by department_id
having   sum(salary) >= 20000
and      department_id = 100;

--CASE~END문
--'컬럼명' < 대소문자 구분이 중요함
select  employee_id,
        first_name,
        salary,
        CASE when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
             when job_id = 'SA_REP'     then salary + salary * 0.2
             when job_id = 'ST_CLERK'   then salary + salary * 0.3
             else salary
        end bonus -- 컬럼명
from    employees;

--DECODE()함수
select  employee_id,
        first_name,
        salary,
        job_id,
        decode ( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                         'SA_REP',     salary + salary * 0.2,
                         'ST_CLERK',   salary + salary * 0.3,
                salary ) bonus
from    employees;

--예제문제
select  first_name,
        department_id 부서,
        CASE when department_id >= 10 and department_id <= 50 then 'A-TEAM'
             when department_id >= 60 and department_id <= 100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'C-TEAM'
             Else '팀없음'
        END 팀
from    employees;

select  first_name,
        department_id 부서,
        CASE when department_id <= 50 then 'A-TEAM'
             when department_id <= 100 then 'B-TEAM'
             when department_id <= 150 then 'C-TEAM'
             Else '팀없음'
        END 팀
from    employees;
-------------------------------------------------------------------------------