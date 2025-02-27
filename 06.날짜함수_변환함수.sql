--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다.

SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID AS 사원번호, FIRST_NAME || LAST_NAME AS 사원명,
HIRE_DATE AS 입사일자, TRUNC((SYSDATE - HIRE_DATE)/365, 0) AS 근속년수
FROM EMPLOYEES WHERE TRUNC((SYSDATE - HIRE_DATE)/365, 0) >= 10
ORDER BY 근속년수 DESC;

--------------------------------------------------------------------------------
--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘부장’ 
--120이라면 ‘과장’
--121이라면 ‘대리’
--122라면 ‘주임’
--나머지는 ‘사원’ 으로 출력합니다.
--조건 1) 부서가 50인 사람들을 대상으로만 조회합니다
--조건 2) DECODE구문으로 표현해보세요.
--조건 3) CASE구문으로 표현해보세요.
--------------------------------------------------------------------------------
--조건 2
SELECT FIRST_NAME, MANAGER_ID, DECODE( MANAGER_ID, 100, '부장',
                                                   120, '과장',
                                                   121, '대리',
                                                   122, '주임',
                                                        '사원')
AS 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

--조건3
SELECT FIRST_NAME, MANAGER_ID, CASE MANAGER_ID WHEN 100 THEN '부장'
                                               WHEN 120 THEN '과장'
                                               WHEN 121 THEN '대리'
                                               WHEN 122 THEN '주임'
                                               ELSE '사원'
                                               END AS 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
--------------------------------------------------------------------------------
--문제 3. 
--EMPLOYEES 테이블의 이름, 입사일, 급여, 진급대상 을 출력합니다. O
--조건1) HIRE_DATE를 XXXX년XX월XX일 형식으로 출력하세요.  O
--조건2) 급여는 커미션값이 퍼센트로 더해진 값을 출력하고, 1300을 곱한 원화로 바꿔서 출력하세요. O
--조건3) 진급대상은 5년 마다 이루어 집니다. 근속년수가 5의 배수라면 진급대상으로 출력합니다.
--조건4) 부서가 NULL이 아닌 데이터를 대상으로 출력합니다. O

SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME || LAST_NAME AS 이름, TO_CHAR(HIRE_DATE, 'YYYY"년"MM"월"DD"일"') AS 입사일,


TO_CHAR(NVL(SALARY + SALARY * COMMISSION_PCT, SALARY) * 1300, 'L999,999,999') AS 급여,
DECODE(MOD(TRUNC((SYSDATE - HIRE_DATE)/365), 5), 0, 'O', 'X')
AS 진급대상
FROM EMPLOYEES WHERE DEPARTMENT_ID IS NOT NULL;

