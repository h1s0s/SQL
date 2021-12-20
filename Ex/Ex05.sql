--Join

--직원관리 테이블에 부서관리 테이블의 컬럼도 가져오기.
--카디젼 프로덕트:
--아무런 조건 없이 두개의 테이블을 붙일경우, 두개의 row를 하나하나 곱해(붙은) row가 생김.
select  *
from    employees, departments;

--EQUI Join
/*1. select에 테이블.컬럼명을 명확하게 적어주는게 방식,
2. 굳이 써주지 않아도 알아서 찾아 주지만 두 테이블에 있을경우 에러가 생기므로.
from 뒤에 별명을 적어주고(2,3글자 정도의 짧은 단어), select에 테이블명은 그 별명을 적는게
일반적임*/
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.salary 월급,
        de.department_name 부서이름,
        em.department_id 부서번호,
        de.department_id 부서번호
from    employees em, departments de
where   em.department_id = de.department_id;
------------------------------------------------------------------------------------------------인강한번더
--department_id가 null인 row를 제외하고 출력됨
--row값은 출력이 안됨을 알수 있음

--예제문제
--모든 직원이름, 부서이름, 업무명을 출력하세요
--여러개 쪼인
select   em.first_name 직원이름,
         de.department_name 부서이름,
         jo.job_title 업무명
from     employees em, departments de, jobs jo
where    em.department_id = de.department_id 
and      em.job_id = jo.job_id
order by em.first_name asc;

