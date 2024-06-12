--1. ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����ϼ���.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES; --1��
--2. ��� ����� �̸��� ���� �ٿ� ����ϼ���. �� ��Ī�� name���� �ϼ���.
SELECT LAST_NAME || FIRST_NAME AS name FROM EMPLOYEES; --2��
--3. 50�� �μ� ����� ��� ������ ����ϼ���.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50; --3��
--4. 50�� �μ� ����� �̸�, �μ���ȣ, �������̵� ����ϼ���.
SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = (50); --4��
--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT FIRST_NAME, SALARY, SALARY + 300 FROM EMPLOYEES; --5��
--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY >= 10000; --6��
--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT FIRST_NAME, JOB_ID, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL; --7��
--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31'; --8��
--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%'; --9��
--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC; --10��
--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 60 ORDER BY SALARY DESC; --11��
--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG','SA_MAN'); --12��
--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME || ' ����� �޿��� ' || SALARY || '�޷� �Դϴ�'
FROM EMPLOYEES WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King'; --13��
--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%_MAN'; --14��
--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���.
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%_MAN' ORDER BY JOB_ID; --15��
--? ���ѽð� : 50��
--? EMPLOYEES ���̺� �����͸� ����ؾ� �մϴ�

SELECT * FROM EMPLOYEES;














