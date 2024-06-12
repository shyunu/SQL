--WHERE 조건절
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David';
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID <> 90; --<>같지않다.
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '06/03/07'; --날짜 비교도 문자열로 한다.
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '06/03/01'; --날짜도 대소비교가 된다.

--BETWEEN AND연산자 사이에
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 5000 AND 10000; --이상 이하
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN'03/01/01' AND '03/12/31';

--IN 연산자
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN(50, 60, 70);
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');

--LIKE 연산자 - 검색에 사용됨, 리터럴문자 : % _
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%'; --03으로 시작하는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03'; --03으로 끝나는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03%'; --03이 포함되는
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';

SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '_a%'; --a가 둘쨋자리인 데이터

--NULL값 찾기 IS NULL, IS NOT NULL
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL; --데이터 안나옴
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

-- AND, OR - AND가 OR보다 빠름
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR';
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY >= 5000;
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 5000;

SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR') AND SALARY >= 6000;

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'FI_MGR';

--NOT 부정의 의미 - 연산키워드와 사용됨
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID NOT IN (50, 60);
SELECT * FROM EMPLOYEES WHERE JOB_ID NOT LIKE '%MAN%';

--------------------------------------------------------
--ORDER BY
SELECT * FROM EMPLOYEES ORDER BY SALARY; --아무것도 안적으면 ASC 입니다.
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC;
SELECT FIRST_NAME, SALARY * 12 AS 연봉 FROM EMPLOYEES ORDER BY 연봉;
--정렬을 2개 이상칼럼으로 시킬 수 있다.
--부서번호가 높은 사람들 중에서 급여가 높은 사람들 기준으로 정렬
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC, SALARY DESC;

SELECT * FROM EMPLOYEES WHERE JOB_ID IN('IT_PROG', 'SA_MAN') ORDER BY FIRST_NAME ASC;






