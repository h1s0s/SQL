------------------------------
--rownum
--질의의 결과에 가상으로 부여되는 Oracle의 가상의 일련번호
------------------------------
--급여를 가장 많이받는 5명의 직원의 이름을 출력하시오.
--1. rownum. 질의 결과에 순서로 가상의 일련번호가 데이터로 출력됨. 
select   rownum,
         first_name,
         salary
from     employees;
--2. 급여순으로 정렬을 하면, rownum이 섞여버림.
-- 순서: 1. 테이블로 한 row를 읽음 -> 2.row가 where절을 만족하는가?(반복, true=3, false=1) 
---> 3. 임시결과 생성 -> 4. select절을 이용하여 Projection -> 5. order by절을 이용 정렬.
--정렬이 가장 나중에 실행됨.
select   rownum,
         first_name,
         salary
from     employees
order by salary desc;

select   rownum,
         first_name,
         salary
from     employees;
-------------------------------------------------------------------------------
--1.급여의 내림차순으로 정렬된 테이블
select   first_name,
         salary
from     employees
order by salary desc;

--2.from에 급여의 내림차순으로 "정렬된 테이블"을 from으로 가져옴
-- 1) from절 테이블에 컬럼에 별명을 지었을경우 그 별명을 select 해야함.
-- 2) 또한 select된 컬럼만 사용할 수 있음.
-- 3) *은 가급적 안쓰는게 나음.(드물게 오류가 날 수 있기 때문에)
--    처음에 코드 짤때는 *를 써도 되지만, 마무리 할때는 사용할 컬럼만 셀렉트.
select  rownum,
        first_name,
        salary
from    (select   employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
         from     employees
         order by salary desc)
where   rownum <= 5;

--3. where절 문제(rownum 1을 제외하고 2번부터 가져오면 안됨.)
--조건절이 먼저 실행된 후 찍어내기 때문에 rownum 1이 생성되지 않으면 다음 번호또한 생성되지 않음.
--안되는 쿼리문
select  rownum,
        o.first_name,
        o.salary
from    (select   *
         from     employees
         order by salary desc) o
where   rownum <= 3;

--맞는 쿼리.
--1. 급여순으로 정렬된 테이블을 테이블로 조인 한후 rownum을 순차적으로 찍어냄
--2. 이 테이블을 조인해 rownum을 where절로 끊어줌, (rownum에 별명을 주어 구분함)

select  rno,
        first_name,
        salary
from (select  rownum rno,
              first_name,
              salary
        from    (select   *
                from     employees
                order by salary desc))
where   rno>=3
and     rno<=5;

--예제문제1
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
select rno,
       first_name,
       salary,
       hire_date
from (select rownum rno,
             first_name,
             salary,
             hire_date
        from (select *
                from employees
            order by salary desc))
where   rno>=3
and     rno<=5;
            
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일, 부서명은?
select o.rno,
       o.first_name,
       o.salary,
       o.hire_date,
       de.department_name
from (select rownum rno,
             first_name,
             salary,
             hire_date,
             department_id
        from (select *
                from employees
            order by salary desc)) o, departments de
where   o.department_id = de.department_id
and     o.rno>=3
and     o.rno<=5;