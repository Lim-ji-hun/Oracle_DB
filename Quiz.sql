/* quiz */
SELECT *
FROM EMP;
-- emp 테이블에서 사원번호가 홀수인 사원을 출력하세요
SELECT *
FROM EMP
WHERE MOD(empno, 2)=1;

-- emp 테이블에서 소문자 manager 로 직급을 검색해서 출력하세요
SELECT *
FROM EMP
WHERE job=UPPER('manager');

-- emp 테이블에서 조회하는 이름을 소문자로 사용해서, 사원번호, 이름, 직급, 부서번호를 출력하세요
SELECT empno, ename, job, deptno
FROM EMP
WHERE LOWER(ename)='smith';

-- dept 테이블에서 첫글자만 대문자로 변환하여 모든 정보를 출력하세요
SELECT deptno, INITCAP(dname), INITCAP(loc)
FROM DEPT;

-- emp 테이블의 ename 컬럼의 마지막 문자 하나만 추출해서 이름이 E 로 끝나는 사원을 출력하세요
SELECT *
FROM EMP
WHERE SUBSTR(ename, -1, 1)='E';

-- emp 테이블에서 이름의 세번째 자리가 R 인 사원을 출력하세요
SELECT *
FROM EMP
WHERE SUBSTR(ename, 3, 1)='R';

-- emp 테이블에서 20번 부서의 사원번호, 이름, 이름의 글자수, 급여, 급여의 자릿수를 출력하세요
SELECT empno, ename, LENGTH(ename), sal, LENGTH(sal)
FROM EMP
WHERE deptno=20;

-- emp 테이블에서 현재까지 근무일수가 몇일 인지를 구하고, 근무일수가 많은 순서로 출력하세요
SELECT ename, hiredate, SYSDATE, TRUNC(SYSDATE-hiredate) "근무일수"
FROM EMP
ORDER BY TRUNC(SYSDATE-hiredate) DESC;










































