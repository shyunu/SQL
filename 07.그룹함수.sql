--�׷��Լ�
--NULL�� ���ܵ� �����͵鿡 ���ؼ� ����ȴ�.
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM EMPLOYEES;
--MIN, MAX : ��¥, ���ڿ��� ����ȴ�.
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

--COUNT() 2���� �����
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--�μ��� 80�� ����� �� COMMISSION_PCT�� ���� ���� ���
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--�׷��Լ��� �Ϲ�Į���� ���ÿ� ����� �Ұ����ϴ�.
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES; --XX
SELECT FIRST_NAME, AVG(SALARY) OVER() FROM EMPLOYEES; --OO

--------------------------------------------------------------------------------
--group by�� 
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY),
       MIN(SALARY),
       MAX(SALARY),
       COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--GROUPȭ ��Ų �÷���, SELECT������ ���� �� �ִ�.
SELECT DEPARTMEMT_ID,
       FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --����

--2���̻��� �׷�ȭ
SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY) AS "�μ��������޿���",
       AVG(SALARY) AS "�μ��������޿����",
       COUNT(*) AS �μ��ο���,
       COUNT(*) OVER() ��üī��Ʈ -- COUNT(*) OVER() ����ϸ� �� ���� ���� ���
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;
--
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 5000 -- �׷��� ������ ���� ���� HAVING�̶�� ���� �ִ�.
GROUP BY DEPARTMENT_ID;
--------------------------------------------------------------------------------
--HAVING�� : GROUP BY ����
SELECT DEPARTMENT_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 100000 OR COUNT(*) >= 5;

--
--------------------------------------------------------------------------------
--HAVING�� : GROUP BY ����
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

--�μ����̵� NULL�� �ƴ� �������߿��� �Ի����� 05�⵵�� ������� �μ��� �޿����, �޿����� ���ϰ�
--��ձ޿��� 5000�̻��� �����͸� ���ϰ� �μ����̵�� ��������
SELECT DEPARTMENT_ID AS �μ����̵�,
       AVG(SALARY) AS �޿����,
       SUM(SALARY) AS �޿���
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID DESC;

--------------------------------------------------------------------------------
--�������
-- ROLLUP : GROUP BY���� �Բ� ���ǰ� �����׷��� �հ�, ��Ż ���� ���Ѵ�.
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID); -- ��ü �׷쿡 ���� �Ѱ�

SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID) -- �Ѱ�, �ֱ׷쿡 ���� �Ѱ�
ORDER BY DEPARTMENT_ID;

--CUBE - ROLLUP + ����׷쿡 �Ѱ谡 �߰���
SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING�Լ� : GROUP BY�� ������� ���� 0��ȯ, ROLLUP �Ǵ� CUBE�� ������� ���� 1��ȯ
SELECT DECODE( GROUPING(DEPARTMENT_ID), 1, '�Ѱ�', DEPARTMENT_ID)AS DEPARTMENT_ID,
       DECODE( GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID)AS JOB_ID,
       AVG(SALARY),
       GROUPING(DEPARTMENT_ID),
       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--------------------------------------------------------------------------------
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
--�ÿ� ���̺��� JOB_ID�� ���� ���� �Ի����� ���ϼ���. JOB_ID�� �������� �����ϼ���.

SELECT JOB_ID,
       COUNT(*) AS �����,
       AVG(SALARY) AS ��տ���
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY ��տ��� DESC;

SELECT JOB_ID,
       MIN(HIRE_DATE) AS �Ի���
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY �Ի���;

--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.

SELECT * FROM EMPLOYEES;
--
SELECT TO_CHAR(HIRE_DATE, 'YY') AS �Ի�⵵,
       COUNT(*) AS �����
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');

--
--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID AS �μ�,
       AVG(SALARY) AS �μ�����ձ޿�
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 2000;

--
--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID AS �μ�,
       TRUNC(AVG(SALARY + SALARY * COMMISSION_PCT),2) AS �޿����,
       SUM(SALARY) AS �޿��հ�,
       COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;

--���� 5.
--�μ����̵� NULL�� �ƴϰ�, �Ի����� 05�⵵ �� ������� �μ� �޿���հ�, �޿��հ踦 ��ձ��� ���������մϴ�
--����) ����� 10000�̻��� �����͸�

SELECT * FROM EMPLOYEES;
--
SELECT DEPARTMENT_ID,
       AVG(SALARY) AS �޿����,
       SUM(SALARY) AS �޿��հ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL  AND TO_CHAR(HIRE_DATE, 'YY') = 05
GROUP BY DEPARTMENT_ID, HIRE_DATE
HAVING AVG(SALARY) >= 10000
ORDER BY �޿���� DESC;

--���� 6.
--������ ������, ���հ踦 ����ϼ���

SELECT * FROM EMPLOYEES;
--
SELECT DECODE(GROUPING(JOB_ID), 1, '�հ�', JOB_ID), SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);


--���� 7.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���

SELECT * FROM EMPLOYEES;
--
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) AS DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID),
       COUNT(*) AS TOTAL,
       SUM(SALARY) AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;