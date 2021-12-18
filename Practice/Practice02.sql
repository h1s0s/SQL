--practice집계(통계) SQL 문제입니다.
/*
문제1.
매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요
*/
select  count(manager_id)
from    employees;
/*
문제2. 
직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요?  “최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.
*/
select  max_salary||'_'||min_salary 최고임금_최저임금,
        max_salary-min_salary 차이
from    jobs;
/*
문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일
*/
select      to_char(max(hire_date), 'YYYY"년" MM"월" DD"일"') as last_hire
from        employees;
/*
문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.
*/
select      department_id 부서아이디,
            round(avg(salary),0) 평균임금,
            max(salary) 최고임금,
            min(salary) 최저임금
from        employees
group by    department_id
order by    department_id desc;
/*
문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 정렬순서는 최저임금 내림차순, 
평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
*/
select      job_id 업무아이디,
            round(avg(salary),0) 평균임금,
            max(salary) 최고임금,
            min(salary) 최저임금
from        employees
group by    job_id
order by    min(salary) desc, avg(salary) asc;
/*
문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2001-01-13 토요일 
*/
select      to_char(min(hire_date), 'YYYY-MM-DD DAY')
from        employees;
/*
문제7.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 그리고 (
평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
*/
select      department_id,
            round(avg(salary),0) 평균임금,
            min(salary) 최저임금,
            round(avg(salary)-min(salary),0) 차이
from        employees
group by    department_id
order by    avg(salary)-min(salary) desc;
/*
문제8.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요? 
*/
select      job_id 업무아이디,
            avg(max_salary-min_salary) 최소최대차이
from        jobs
group by    job_id
order by    avg(max_salary-min_salary) desc;
/*
문제9
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
*/
select      manager_id,
            hire_date,
            avg(salary),
            min(salary),
            max(salary)            
from        employees
group by    manager_id, hire_date
having      hire_date >= '05/01/01';
/*
문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.
*/
select      first_name,
            CASE when hire_date < '02/12/31' THEN '창립멤버'
                 when hire_date >= '03/01/01' and hire_date < '04/01/01' THEN '03년입사'
                 when hire_date >= '04/01/01' and hire_date < '05/01/01' THEN '04년입사'
                 else '상장이후입사' 
            END optDate
from        employees
order by    hire_date;