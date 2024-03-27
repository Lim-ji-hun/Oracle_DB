-- 04.join

/*
# join
- 하나 이상의 터이블에서 한번의 질의문으로 우너하는 자료를 검색할때 사용
*/


/*
# equi join
- 가장 많이 사용되는 조인 방식으로 조인 대상이 되는 두 테이블에서
  공통적으로 존제하는 컬럼의 값이 일치되는 행을 연결해서 결과를 생성
*/

SELECT * FROM DEPT;
-- DEPTON   DNAME       LOC
-- 10   	ACCOUNTING	NEW YORK
-- 20   	RESEARCH	DALLAS
-- 30   	SALES   	CHICAGO
-- 40   	OPERATIONS	BOSTON
SELECT * FROM EMP;
-- EMPNO    ENAME   JOB         MGR     HIREDATE    SAL     COMM    DEPTNO
-- 7369 	SMITH	CLERK	    7902	80/12/17	800		        20
-- 7499 	ALLEN	SALESMAN	7698	81/02/20	1600	300 	30
-- 7521 	WARD	SALESMAN	7698	81/02/22	1250	500 	30
-- 7566	    JONES	MANAGER	    7839	81/04/02	2975		    20
-- 7654 	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
-- 7698 	BLAKE	MANAGER	    7839	81/05/01	2850	    	30
-- 7782 	CLARK	MANAGER  	7839	81/06/09	2450		    10
-- 7839 	KING	PRESIDENT	    	81/11/17	5000	    	10
-- 7844 	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
-- 7900 	JAMES	CLERK	    7698	81/12/03	950		        30
-- 7902 	FORD	ANALYST	    7566	81/12/03	3000	    	20
-- 7934 	MILLER	CLERK	    7782	82/01/23	1300    		10

-- 사원 정보 출력시에 각 사원들이 소속된 부서의 상세 정보 확인
SELECT *
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno;

-- 위 결과에서 특정 컬럼만 확인
SELECT ename, dname
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno;

-- 이름이 JAMES인 사람의 부서명 확인
SELECT ename, dname
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno
AND ename='JAMES';

-- 두개의 테이블에서 동일하게 존재하는 컬럼을 확인할때에는, 컬럼명 앞에 테이블 명을 작성함 
SELECT ename, dname, EMP.deptno
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno
AND ename='JAMES';

-- 테이블에 별칭 지정
-- FROM 절 뒤에 테이블 이름을 명시하고, 공백을 작성한 다음에 별칭을 지정
SELECT E.ename, D.dname, E.deptno
FROM EMP E, DEPT D
WHERE E.deptno=D.deptno
AND ename='JAMES';

/*
# Non-Equi join
- 조인 조건에 특정 범위에 있는지를 비교연산자를 사용해 join한다
*/

-- SALGRADE : 급여 등급 테이블
DESC SALGRADE;
-- GRADE    NUMBER 
-- LOSAL    NUMBER 
-- HISAL    NUMBER 
SELECT * FROM salgrade;

-- 각 사원의 급여 등급 확인
SELECT ename, sal, grade
FROM EMP, SALGRADE
WHERE sal BETWEEN losal AND hisal;

-- 사원 이름과 소속 부서, 급여의 등급 확인
SELECT E.ename, D.dname, E.sal, S.grade
FROM EMP E, DEPT D, SALGRADE S
WHERE E.deptno=D.deptno
AND E.sal BETWEEN losal AND hisal;

/*
# self join
- 하나의 테이블에서 조인을 해서 원하는 결과를 얻을수있다
*/

-- 사원의 MANAGER 확인
SELECT EMPLOYEE.ename || ' 의 MANAGER는 ' || MANAGER.ename || ' 입니다'
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.mgr=MANAGER.empno; -- 상사가 없는 1명은 값이 안나옴

/*
#Outer join
- 조인 조건에 만족하지 않는 행도 나타내는 조인
- 조인될 때 어는 한쪽의 테이블에는 해당하지 않는 데이터가 있지만
  다른쪽 테이블에는 데이터가 없을 경우 그 데이터가 출력되지 않는 것을 해결할 수 있다
- '+' 기호를 조인 조건에서 정보가 부족한 컬럼 이름 뒤에 붙인다
*/

SELECT EMPLOYEE.ename || ' 의 MANAGER는 ' || MANAGER.ename || ' 입니다'
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.mgr=MANAGER.empno(+);

/* quiz */

-- 'NEW YORK' 에서 근무하는 사원의 이름과 급여를 출력하세요
SELECT ename, SAL
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno
AND LOC='NEW YORK';

-- SMITH 사원과 동일한 근무지에서 근무하는 사원의 이름을 출력하세요
SELECT EA.ename, EB.ename
FROM EMP EA, EMP EB
WHERE EA.deptno=EB.deptno
AND EA.ename = 'SMITH'
AND EA.ename != EB.ename;
-- 왼쪽과 오른쪽에 같은 이름을 가진 컬럼 제거















