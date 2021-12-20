-------------------------------------------------------
--sub Query                                         ---
--하나의 sql 질의문 속에 다른 sql 질의문이 포함되어 있는 형태---
-------------------------------------------------------
--단일행 Query
--Q. Den의 급여는?
select  *
from    employees
where   first_name = 'Den';

--Q. Den보다 급여가 많은 사람의 이름은?
select  first_name,
        salary
from    employees
where   salary >= 11000;

--두질문을 하나로
--(두개의 구문이 있는 구조)
select  first_name,
        salary
from    employees
where   salary >= (select   salary
                    from    employees
                    where   first_name='Den');
                    --이런식으로 정렬하는게 일반적임
--예제) 급여를 가장 적게받는 사람의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from    employees
where   salary = (select min(salary)
                    from employees);
                    
--예제) 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요.
select  first_name,
        salary
from    employees
where   salary < (select avg(salary)
                    from employees);


