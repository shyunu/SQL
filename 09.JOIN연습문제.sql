--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)

SELECT * FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --106��

SELECT * FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --107��

SELECT * FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --122��

SELECT * FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --123��

--------------------------------------------------------------------------------
--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�

SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID AS �μ����̵�
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE EMPLOYEE_ID = 200;

--------------------------------------------------------------------------------
--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��

SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�,
       EMPLOYEE_ID AS �������̵�,
       JOB_TITLE AS ����Ÿ��Ʋ
FROM EMPLOYEES E INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY �̸� ASC;

--------------------------------------------------------------------------------
--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.

SELECT * FROM JOBS;--JOB ID  JOB TITLE  MIN SALARY  MAX SALARY
SELECT * FROM JOB_HISTORY; --EMPLOYEE ID  START DATE  END DATE  JOB ID+  DEPARTMENT ID

SELECT * 
FROM JOB_HISTORY H
LEFT OUTER JOIN JOBS J
ON H.JOB_ID = J.JOB_ID;

--------------------------------------------------------------------------------
--���� 5.
--Steven King�� �μ����� ����ϼ���.

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT D.DEPARTMENT_NAME AS �μ���
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';

--------------------------------------------------------------------------------
--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���

SELECT *
FROM EMPLOYEES
CROSS JOIN DEPARTMENTS;

--------------------------------------------------------------------------------
--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)

SELECT * FROM EMPLOYEES; --EMPLOYEE ID  JOB ID  SALARY  DEPARTMENT ID
SELECT * FROM DEPARTMENTS; --DEPARTMENT ID  DEPARTMENT NAME  LOCATION ID
SELECT * FROM LOCATIONS;
SELECT E.EMPLOYEE_ID AS �����ȣ,
       CONCAT(E.FIRST_NAME || ' ', E.LAST_NAME) AS �̸�,
       E.SALARY AS �޿�,
       D.DEPARTMENT_NAME AS �μ���,
       D.LOCATION_ID AS �ٹ���
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.JOB_ID = 'SA_MAN';

--------------------------------------------------------------------------------
--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.

SELECT * FROM JOBS;

SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE IN('Stock Manager', 'Stock Clerk');
--------------------------------------------------------------------------------
--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * FROM EMPLOYEES;
select * from departments;

SELECT *
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE EMPLOYEE_ID IS NULL;
--------------------------------------------------------------------------------
--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT CONCAT(E.FIRST_NAME || ' ', E.LAST_NAME) AS ����̸�
FROM EMPLOYEES E
LEFT OUTER JOIN EMPLOYEES E1
ON E.JOB_ID = E1.JOB_ID
WHERE E.JOB_ID LIKE '%_MAN';
--------------------------------------------------------------------------------
--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT * FROM JOBS;

SELECT E1.MANAGER_ID AS �Ŵ���,
       CONCAT(E1.FIRST_NAME || ' ', E1.LAST_NAME) AS �̸�,
       SALARY AS �޿�
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.MANAGER_ID
WHERE E1.MANAGER_ID IS NOT NULL
ORDER BY �޿� DESC;
--------------------------------------------------------------------------------
--���ʽ� ���� 12.
--���������̽�(William smith)�� ���޵�(�����)�� ���ϼ���.
SELECT * FROM DEPARTMENTS;