--그룹함수
--NULL이 제외된 데이터들에 대해서 적용된다.
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM EMPLOYEES;
--MIN, MAX : 날짜, 문자에도 적용된다.
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

--COUNT() 2가지 사용방법
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--부서가 80인 사람들 중 COMMISSION_PCT가 가장 높은 사람
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--그룹함수는 일반칼럼과 동시에 사용이 불가능하다.
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES; --XX
SELECT FIRST_NAME, AVG(SALARY) OVER() FROM EMPLOYEES; --OO

--------------------------------------------------------------------------------
--group by절 
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY),
       MIN(SALARY),
       MAX(SALARY),
       COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--GROUP화 시킨 컬럼만, SELECT구문에 적을 수 있다.
SELECT DEPARTMEMT_ID,
       FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --에러

--2개이상의 그룹화
SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY) AS "부서직무별급여합",
       AVG(SALARY) AS "부서직무별급여평균",
       COUNT(*) AS 부서인원수,
       COUNT(*) OVER() 전체카운트 -- COUNT(*) OVER() 사용하면 총 행의 개수 출력
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;
--
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 5000 -- 그룹의 조건을 적는 곳은 HAVING이라고 따로 있다.
GROUP BY DEPARTMENT_ID;
--------------------------------------------------------------------------------
--HAVING절 : GROUP BY 조건
SELECT DEPARTMENT_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 100000 OR COUNT(*) >= 5;

--
--------------------------------------------------------------------------------
--HAVING절 : GROUP BY 조건
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

--부서아이디가 NULL이 아닌 데이터중에서 입사일은 05년도인 사람들의 부서별 급여평균, 급여합을 구하고
--평균급여는 5000이상인 데이터만 구하고 부서아이디로 내림차순
SELECT DEPARTMENT_ID AS 부서아이디,
       AVG(SALARY) AS 급여평균,
       SUM(SALARY) AS 급여합
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID DESC;

--------------------------------------------------------------------------------
--시험대비용
-- ROLLUP : GROUP BY절과 함께 사용되고 상위그룹의 합계, 토탈 등을 구한다.
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID); -- 전체 그룹에 대한 총계

SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID) -- 총계, 주그룹에 대한 총계
ORDER BY DEPARTMENT_ID;

--CUBE - ROLLUP + 서브그룹에 총계가 추가됨
SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING함수 : GROUP BY로 만들어진 경우는 0반환, ROLLUP 또는 CUBE로 만들어진 행은 1반환
SELECT DECODE( GROUPING(DEPARTMENT_ID), 1, '총계', DEPARTMENT_ID)AS DEPARTMENT_ID,
       DECODE( GROUPING(JOB_ID), 1, '소계', JOB_ID)AS JOB_ID,
       AVG(SALARY),
       GROUPING(DEPARTMENT_ID),
       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--------------------------------------------------------------------------------
--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
--시원 테이블에서 JOB_ID별 가장 빠른 입사일을 구하세요. JOB_ID로 내림차순 정렬하세요.

SELECT JOB_ID,
       COUNT(*) AS 사원수,
       AVG(SALARY) AS 평균월급
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY 평균월급 DESC;

SELECT JOB_ID,
       MIN(HIRE_DATE) AS 입사일
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY 입사일;

--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.

SELECT * FROM EMPLOYEES;
--
SELECT TO_CHAR(HIRE_DATE, 'YY') AS 입사년도,
       COUNT(*) AS 사원수
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');

--
--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID AS 부서,
       AVG(SALARY) AS 부서별평균급여
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 2000;

--
--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID AS 부서,
       TRUNC(AVG(SALARY + SALARY * COMMISSION_PCT),2) AS 급여평균,
       SUM(SALARY) AS 급여합계,
       COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;

--문제 5.
--부서아이디가 NULL이 아니고, 입사일은 05년도 인 사람들의 부서 급여평균과, 급여합계를 평균기준 내림차순합니다
--조건) 평균이 10000이상인 데이터만

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID,
       AVG(SALARY) AS 급여평균,
       SUM(SALARY) AS 급여합계
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL  AND TO_CHAR(HIRE_DATE, 'YY') = 05
GROUP BY DEPARTMENT_ID, HIRE_DATE
HAVING AVG(SALARY) >= 10000
ORDER BY 급여평균 DESC;

--문제 6.
--직업별 월급합, 총합계를 출력하세요

SELECT * FROM EMPLOYEES;
--
SELECT DECODE(GROUPING(JOB_ID), 1, '합계', JOB_ID), SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);


--문제 7.
--부서별, JOB_ID를 그룹핑 하여 토탈, 합계를 출력하세요.
--GROUPING() 을 이용하여 소계 합계를 표현하세요

SELECT * FROM EMPLOYEES;
--
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1, '합계', DEPARTMENT_ID) AS DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID), 1, '소계', JOB_ID),
       COUNT(*) AS TOTAL,
       SUM(SALARY) AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;