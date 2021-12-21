-------------------------------------------------------
--sub Query                                         ---
--하나의 sql 질의문 속에 다른 sql 질의문이 포함되어 있는 형태---
-------------------------------------------------------
--단일행 Query
--subQuery의 결과가 한 Row일 경우 사용합니다.
--연산자: -, >, >-=, <, <=, <>(같지않다)

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
------------------------------
--sub Query다중행
------------------
--다중행 (IN)
select  employee_id,
        first_name,
        salary
from    employees
where   salary in (select salary
                    from employees
                    where department_id=110)
                    
--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
--1. 부서번호가 110인 직원의 급여리스트를 구한다.
select  employee_id, first_name, salary
from    employees
where   department_id = 110;

--2. 급여가 12008, 8300인 직원 리스트를 구한다
select  employee_id, first_name, salary
from    employees
where   salary = 12008
or      salary = 8300;

select  employee_id, first_name, salary
from    employees
where   salary in (12008, 8300);

--3. 두식을 조합한다.
select  department_id, employee_id, first_name, salary
from    employees
where   salary in (select  salary
                    from    employees
                    where   department_id = 110);
                    
--예제) 각 부서별로 최고급여를 받는 사원을 출력하세요
--1.각 부서별 최고급여
select      department_id, 
            max(salary)
from        employees
group by    department_id;

--2.합친다

--그룹(부서별) 최고급여를 구하는 문제
--그룹넘버와 급여가 같은 직원을 구한다.(Where절)
select      first_name, 
            salary, 
            department_id
from        employees
where       (department_id, salary) in (select      department_id, 
                                                    max(salary)
                                        from        employees
                                        group by    department_id);
                                    
--다중행(ANY)
--부서번호가 110인 직원의 급여보다 큰 모든 직원의
--사번, 이름, 급여를 출력하세요.
--ANY(or) (12008 또는(or) 8300)보다 큰 = 8300보다 큰
--조건중 하나만 만족하는 값을 출력하라

--1. 부서번호가 110인 직원의 급여
select  salary
from    employees
where   department_id = 110;

--2. 부서번호가 110인 사람보다 급여가 큰 직원(12008, 8300) 리스트(사번, 이름, 급여)를 출력
select  employee_id,
        first_name,
        salary
from    employees
where   salary  > 12008
or      salary  > 8300;

--3. 1과 2를 합치자
select  employee_id,
        first_name,
        salary
from    employees
where   salary  >any    (select  salary
                            from employees
                            where   department_id = 110);
                            
--ALL (AND)
--둘다 만족해야하는 연산
--부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.
--ALL(and) 12008 and(과) 8300 보다 큰(12008보다 큰)
--조건을 다 만족하는 값을 출력해라
--3. 합치기
select  employee_id,
        first_name,
        salary
from    employees
where   salary  >ALL (select    salary
                        from    employees
                        where   department_id = 110);
                        
------------------------------------------------------------------------------
--조건절에서 비교 vs 테이블에서 조인
------------------------------------------------------------------------------
--각 부서별로 최고 급여를 받는 사원을 출력하세요
--1. 조건절에서 비교(서브쿼리)
select  department_id,
        employee_id,
        first_name,
        salary
from    employees
where   (department_id, salary) in (select   department_id, max(salary)
                                    from     employees
                                    group by department_id);
--2. 테이블에서 조인(테이블 서브쿼리)
--특징(1) 서브쿼리문의 컬럼을 출력할수 있음.
select  e.department_id, 
        e.employee_id, 
        e.first_name, 
        e.salary
from    employees e, (select     department_id, max(salary) salary
                        from     employees
                        group by department_id) s
where   e.department_id = s.department_id
and     e.salary = s.salary;