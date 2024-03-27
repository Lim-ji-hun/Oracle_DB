-- 05_서브쿼리.sql

/*
서브 쿼리(subquery)
- 서브 쿼리는 하나의 SELECT문장안에 또 하나의 select문을 사용한는 것이다
- 서브 쿼리는 비교연산의 오른쪽에 작성해야 하고, 반드시 괄호()로 묶어줘야한다
- 서브 쿼리는 메인 쿼리가 실행되기 전에 한번만 실행된다
- 하나의 테이블에서 검색한 결과를 다른 테이블에 전달하여 새로운 결과를 검색한다
*/

-- query 1
SELECT deptno
FROM EMP
WHERE ename = 'SMITH';

-- query 2
SELECT dname
FROM DEPT
WHERE deptno=20;

-- query 1(서브쿼리)의 실행 결과를 query 2(메인쿼리)에게 반환
-- 서브쿼리는 메인쿼리가 필요한값을 제공

--SMITH 사원의 부서명
SELECT dname
FROM DEPT
WHERE deptno=(SELECT deptno
              FROM EMP
              WHERE ename = 'SMITH');

-- SMITH 와 같은 부서에 근무하는 사원의 이름과 부서번호
SELECT ename, deptno
FROM EMP
WHERE deptno=(SELECT deptno
              FROM EMP
              WHERE ename = 'SMITH')
AND ename!='SMITH';

--평균 급여보다 더 많은 급여를 받는 사원
--서브쿼리에 그룹 함수 사용
SELECT ename, sal
FROM EMP
WHERE sal>(SELECT AVG(sal)
           FROM EMP);
           
-- 특정 사원의 급여와 동일하거나 더 많이 받는 사원의 이름, 급여 조회
SELECT ename, sal
FROM EMP
WHERE sal>=(SELECT deptno
            FROM EMP
            WHERE ename = 'ALLEN')
AND ename!='ALLEN';

/* quiz */
SELECT *
FROM EMP;
SELECT *
FROM DEPT;
-- DALLAS 에서 근무하는 사원의 이름, 부서번호를 출력하세요
SELECT ename, deptno
FROM EMP
WHERE deptno = (SELECT deptno
                FROM  DEPT
                WHERE LOC='DALLAS');



-- SALES 부서에서 근무하는 모든 사원의 이름, 급여를 출력하세요
SELECT ename, sal
FROM EMP
WHERE deptno = (SELECT deptno
                FROM  DEPT
                WHERE DNAME='SALES');
-- 직속 상관이 KING 인 사원의 이름, 급여를 출력하세요
SELECT ename, sal
FROM EMP
WHERE mgr = (SELECT empno
                FROM  EMP
                WHERE ename='KING');

-- 사원 테이블에서 최대 급여를 받는 사원을 출력하세요
SELECT ename
FROM EMP
WHERE sal >= (SELECT  MAX(sal)
              FROM EMP);

-- 사원 테이블에서 20번 부서의 최소 급여보다 많은 부서를 출력하세요
SELECT deptno, MIN(sal)
FROM EMP
GROUP BY deptno
HAVING MIN(sal) > (SELECT MIN(sal)
                   FROM  EMP
                   WHERE deptno=20);
                   
                   
/*
다중 서브쿼리
- 서브쿼리에서 반환되는 결과가 하나 이상일때 사용하는 서브쿼리
- 다중행 서브쿼리는 반드시 다중행 연산자와 함꼐 사용해야함
  > IN, ANY, ALL, EXISTS
*/

/*
# IN
- 메인쿼리의 비교조건이 서브쿼리 결과중에서 하나라도 일치하면 참이다
*/

-- 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원
SELECT ename, sal, deptno
FROM EMP
WHERE deptno IN (SELECT DISTINCT deptno
                 FROM EMP
                 WHERE sal >= 3000);
                 
/*
# ANY
- 메인 퀴리의 비교 조건이 서브퀴리의 결과와 하나 이상이 일치하면 참이다
  > ANY : 검색결과에 대해서 하나라도 크면 참
  < ANY : 검색결과에 대해서 하나라도 작으면 참
*/

-- 30번 부서에서 가장 작은 급여를 받는 사원보다 많은 급여를받는 사원의 이름, 급여를 출력
SELECT ename, sal
FROM EMP
WHERE sal > ANY(SELECT sal
                FROM EMP
                WHERE deptno = 30);
                
                
/*
# ALL
- 메인 퀴리의 비교 조건이 서브퀴리의 검색 결과와 모두 일치하면 참이다
*/
-- 30번 부서에서 가장 많은 급여를 받는 사원보다 많은 급여를받는 사원의 이름, 급여를 출력
SELECT ename, sal
FROM EMP
WHERE sal > All(SELECT sal
                FROM EMP
                WHERE deptno = 30);
                
/*
# EXISTS
- 메인퀴리의 비교조건이 서브퀴리의 결과 중에서 만족하는 값이 하나라도 있으면 참
  IN과의 차이점 -> IN연산자는 실제 존제하는 데이터들의 모든 값을 확인하지만
                   EXISTS 연산자는 해당 행이 존재하는지의 여부만 확인함
*/

-- EMP 테이블에 있는 deptno와 서브퀴리에 있는 DEPT테이블의 deptno를 조인해서
-- deptno 10, 20이 있으면 EMP테이블의 이름, 부서번호, 급여 출력
SELECT 1
FROM EMP E, DEPT D
WHERE D.deptno IN (10, 20)
AND E.deptno=D.deptno;

SELECT ename, deptno, sal
FROM EMP E
WHERE EXISTS (SELECT 1
              FROM EMP E, DEPT D
              WHERE D.deptno IN (10, 20)
              AND E.deptno=D.deptno);
              
              
/* quiz */
SELECT *
FROM EMP;
SELECT *
FROM DEPT;
-- 부서별로 가장 급여를 많이 받는 사원의 정보(사원번호, 사원이름, 급여, 부서번호) 를 출력하세요
SELECT empno, ename, sal, deptno
FROM EMP
WHERE sal IN (SELECT MAX(sal)
              FROM EMP
              GROUP BY deptno);

-- job 이 MANAGER 인 사람이 속한 부서의 부서번호, 부서명, 지역을 출력하세요
SELECT deptno, dname, loc
FROM DEPT
WHERE deptno IN (SELECT deptno
                FROM  EMP
                WHERE job='MANAGER');
                
-- SALESMAN 의 최소 급여보다 많이 받는 사원들의 이름, 급여, 직급을 출력하세요
SELECT ename, sal
FROM EMP
WHERE sal > ANY(SELECT sal
                FROM EMP
                WHERE job = 'SALESMAN');
                
-- SALESMAN 보다 급여를 많이 받는 사원들의 이름, 급여, 직급을 출력하세요
SELECT ename, sal, job
FROM EMP
WHERE sal > ALL(SELECT sal
                FROM EMP
                WHERE job='SALESMAN');
                
-- emp 테이블에서 적어도 한명의 사원으로부터 보고를 받을 수 있는
-- 사원의 정보(사원번호, 이름, 업무, 입사일자, 급여)를 사원번호 순으로 내림차순 정렬해서 출력하세요              
SELECT empno, ename, job, hiredate, sal
FROM EMP E
WHERE EXISTS (SELECT *
              FROM EMP
              WHERE E.empno=mgr)
ORDER BY empno;      
              
              
              
              
              
              
              

















