--Practice 다시풀기
--Practice01------------------------------------------------------------------------------
/*
문제 1
전체직원의 다음 정보를 조회하세요. 정렬은 (입사일 hire_date)의 오림차순(ASC)으로 가장
선임부터 출력이 되도록 하세요. 이름(first_name, last_name), 월급(salary),
전화번호(phone_number), 입사일(hire_date) 순서이고 "이름", "월급", "전화번호", "입사일",
로 컬럼이름을 대체해보세요.
*/
select   first_name||' '||last_name 이름,
         salary 월급,
         phone_number 전화번호,
         hire_date 입사일
from     employees
order by hire_date asc;
/*
문제 2
업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로
정렬하세요
*/
select   job_title,
         max_salary
from     jobs
order by max_salary desc;
/*
문제 3
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000 초과인 직원의 이름, 매니저아이디,
커미션 비율, 월급을 출력하세요
*/
select  first_name 직원이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from    employees
where   salary > 3000
and     commission_pct is null
and     manager_id is not null;
/*
문제 4
최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을
최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.
*/
select   job_title,
         max_salary
from     jobs
where    max_salary >= 10000
order by max_salary desc;
/*
문제 5(이부분 nvl 함수의 존재가 생각 안났음)
월급이 14000 미만 10000 이상의 직원 이름(first_name), 월급, 커미션퍼센트를
월급순(내림차순) 출력하세요. 단 커미션퍼센트가 null이면 0으로 나타내세요.
*/
select   first_name,
         salary,
         nvl(commission_pct, 0)
from     employees
order by salary desc;
/*
문제 6
부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
입사일은 1977-12 와 같이 표시하시오
*/
select  first_name 이름,
        salary 월급,
        to_char(hire_date,'YYYY-MM') 입사일,
        department_id 부서번호
from    employees
where   department_id in (10,90,100);
/*
문제 7
이름(first_name)에 S또는 s가 들어가는 직원의 이름, 월급을 나타내시오
*/
select  first_name,
        salary
from    employees
where   first_name like '%S%'
and     first_name like '%s%';
/*
문제 8
전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요
(length 공부)
*/
select   *
from     departments
order by length(department_name) desc;
/*
문제 9
지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
올림차순(ASC)으로 정렬해 보세요
*/
select   UPPER(country_name) 나라이름
from     countries
order by country_name asc;
/*
문제 10
입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화번호, 입사일을 출력하세요
전화번호는 545-343-3433 과 같은 형태로 출력하세요.
*/
select  first_name,
        salary,
        replace(phone_number,'.','-'),
        hire_date
from    employees
where   hire_date < '03/12/31';
--Practice02------------------------------------------------------------------------------
--practice집계(통계) SQL 문제입니다.
/*
문제1.
매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요
*/
select  count(*)
from    employees
where   manager_id is not null;
/*
문제2. 
직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 
두 임금의 차이는 얼마인가요?  “최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.
*/
select  max(salary) "최고임금",
        min(salary) "최저임금",
        (max(salary)-min(salary)) "최고임금-최저임금"
from    employees;
/*
문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일
*/
select  to_char(max(hire_date), 'YYYY"년" MM"월" DD"일"') "입사날"
from    employees;
/*
문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.
*/
select   department_id "부서번호", 
         round(avg(salary),0) "평균임금",
         max(salary) "최고임금",
         min(salary) "최저임금"
from     employees
group by department_id
order by department_id desc;
/*
문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 정렬순서는 최저임금 내림차순, 
평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
*/
select   job_id, 
         round(avg(salary),0) "평균임금",
         max(salary) "최고임금",
         min(salary) "최저임금"
from     employees
group by job_id
order by min(salary) desc, round(avg(salary),0) asc;
/*
문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2001-01-13 토요일 
*/
select  to_char(min(hire_date), 'YYYY-MM-DD DAY') "입사일"
from    employees;
/*
문제7.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 그리고 (
평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
*/
select   department_id,
         round(avg(salary),0) "평균임금",
         min(salary) "최저임금",
         round((avg(salary) - min(salary)),0) "평균임금-최저임금"
from     employees
having   (avg(salary) - min(salary)) < 2000
group by department_id
order by (avg(salary) - min(salary)) desc;
/*
문제8.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요? 
*/
select   job_id "업무",
         (max(salary)-min(salary)) "최고임금-최저임금"
from     employees
group by job_id
order by (max(salary)-min(salary)) desc;
/*
문제9
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
*/

/*
문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.
*/

--Practice03------------------------------------------------------------------------------
/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 
조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)
*/

/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 
현재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/

/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/

/*
문제3-1.
문제3에서 부서가 없는 도시도 표시합니다. 
(43건)
*/

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 
지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/

/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 
매니저입사일(hire_date)을 조회하세요.
(37건)
*/

/*
문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)
*/

/*
문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)
*/

/*
문제8.
각 부서(department)에 대해서 
부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 
이름(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)
*/

/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

--Practice04------------------------------------------------------------------------------
/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/

/*
문제2.
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 
오름차순으로 정렬하여 출력하세요 
(51건)
where절, 평균급여, 최대급여?
*/

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 
주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/

/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 
작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 
이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--1.조건절비교

--2.테이블조인
/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/

/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/
--Practice05------------------------------------------------------------------------------
/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 
급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/

/*
문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-V 매니저별 평균급여의 내림차순으로 출력합니다.
-V 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/

/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/

/*  
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/

/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/

/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/

                
