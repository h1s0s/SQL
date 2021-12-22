/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/
select  count(*)
from    employees
where   salary < (select    avg(salary)
                    from    employees);
/*
문제2.
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 
오름차순으로 정렬하여 출력하세요 
(51건)
where절, 평균급여, 최대급여?
*/
select   employee_id 직원번호,
         first_name 이름,
         salary 급여,
         round(sem.asa, 0) 평균급여,
         sem.msa 최대급여
from     employees, (select  avg(salary) asa,
                             max(salary) msa
                       from  employees) sem
where    salary between asa and msa
order by salary asc;
/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 
주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/
-- 1. steven king이 소속된 부서
select  de.department_id
from    employees em, departments de
where   em.department_id = de.department_id
and     em.first_name = 'Steven'
and     em.last_name = 'King';
-- 2. 합치기
select  lo.location_id 도시아이디,
        lo.street_address 거리명,
        lo.postal_code 우편번호,
        lo.city 도시명,
        lo.state_province 주,
        lo.country_id 나라아이디
from    departments de, locations lo
where   de.location_id = lo.location_id   
and     de.department_id = (select  de.department_id
                            from    employees em, departments de
                            where   em.department_id = de.department_id
                            and     em.first_name = 'Steven'
                            and     em.last_name = 'King');
/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 
작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/
select      employee_id 사번,
            first_name 이름,
            salary 급여
from        employees
where       salary <any (select salary
                         from   employees
                         where  job_id = 'ST_MAN')
order by    salary desc;
/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 
이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--1.조건절비교
select      employee_id,
            first_name,
            salary,
            department_id
from        employees
where       (department_id, salary) in (select      department_id, max(salary)
                                        from        employees
                                        group by    department_id)
order by    salary desc;
--2.테이블조인
/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
select      jo.job_title 업무명,
            sum(salary) 연봉총합
from        employees em, jobs jo
where       em.job_id = jo.job_id
group by    jo.job_title
order by    sum(salary) desc;
/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/
select  employee_id 직원번호,
        first_name 이름,
        salary 급여
from    employees, (select   department_id,
                             avg(salary) sa
                    from     employees
                    group by department_id) aem
where   salary > aem.sa 
and     department_id = eme.departmenet_id;
/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/
select  ro,
        employee_id,
        first_name,
        salary,
        hire_date
from    (select     rownum ro,
                    eo.employee_id,
                    eo.first_name,
                    eo.salary,
                    eo.hire_date
         from       (select     employee_id, first_name, salary, hire_date
                    from        employees
                    order by    hire_date asc) eo)
where   ro between 11 and 15;
;