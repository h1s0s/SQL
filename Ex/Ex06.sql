/*
직원이름과 직원이 속한 부서명을 함께 가져오고 싶다.
employees에 department의 데이터를 가져오고 싶다.

Equi join(등가조인) : 양쪽다 만족하는 경우만 조인됨.(null값인 row는 조인 안됨)
1. from에 필요한 테이블을 모두 기입한다(또 3글자 이내의 별명을 적는다)
2. where절에 테이블에 겹치는 컬럼을 =로 묶는다.(여러개면 and절 사용)
3. from의 가장 앞에있는 테이블이 불러오는 조인이 빠르다.
*/
select  first_name, 
        salary, 
        de.department_id
from    employees em, departments de
where   em.department_id = de.department_id
;

--예)
select  em.first_name,
        de.department_name,
        jo.job_title
from    employees em, departments de, jobs jo
where   em.department_id = de.department_id
and     em.job_id = jo.job_id;

--outer join
--null을 포함하여 결과를 생성

--left outer join
--왼쪽 테이블의 모든 row를 결과 테이블에 나타냄
select  e.department_id, e.first_name, d.department_name
from    employees e left outer join departments d
on      e.department_id = d.department_id;

--오라클에서만 쓰이는 문법(위의 sql문과 같은 표현)
select  e.department_id, e.first_name, d.department_name
from    employees e, departments d
where   e.department_id = d.department_id(+);

--right outer join
--오른쪽 테이블의 모든 row를 결과 테이블에 나타냄
--오른쪽의 데이터로 만들어낸 row 106개,
--사용되지 않은 row 16개가 더해진 값이 나옴
--왼쪽의 null로우는 안나옴.
select  e.first_name,
        e.salary,
        e.department_id,
        d.department_id,
        d.department_name
from    employees e right outer join departments d
on      e.department_id = d.department_id;

--right outer join --> left outer join
select  e.first_name,
        e.salary,
        e.department_id,
        d.department_id,
        d.department_name
from    departments d left outer join employees e
on      e.department_id = d.department_id;

-- full outer join 
-- 양쪽의 null row를 출력함.
select  *
from    employees em full outer join departments de
on      em.department_id = de.department_id;

--self join
--자기자신을 조인
--1. from절에 자기 테이블을 2번 불러옴(별명은 다르게 구분)
select  em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        em.manager_id,
        ma.employee_id,
        ma.first_name,
        ma.phone_number
from    employees em, employees ma
where   em.manager_id = ma.manager_id;

--잘못된 조인
select  em.employee_id,
        em.first_name,
        em.salary,
        lo.location_id,
        lo.city
from    employees em, locations lo
where   em.salary = lo.location_id;