



/* 10_view.sql */

/*
 * # view
 * - 물리적인 테이블을 이용한 논리적인 가상 테이블이라고 할 수 있습니다
 * - 실질적인 데이터를 저장하고 있지는 않더라도 사용자는 마치 테이블을 사용하는 것과 동일하게 view 를 사용할 수 있습니다
 * - view 는 기본 테이블에 대한 하나의 쿼리문이고, 실제 테이블에 저장된 테이터를 view 를 통해서 볼 수 있습니다
 * - CREATE VIEW view_name[ ( alias, ... ) ]
 *   AS
 *   SUBQUERY;
 */

/*
 * # 단순뷰                  복합뷰
 * - 하나의 테이블로 생성    여러개의 테이블로 생성
 * - 그룹함수 사용 가능      그룹함수 사용 불가
 * - DML 사용 가능           DML 사용 불가
 */

-- view 생성 권한 부여( SYSTEM 계정 )
-- GRANT CREATE VIEW TO 계정명;
GRANT CREATE VIEW TO scott;


-- 연습용 테이블
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT;
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;

SELECT * FROM DEPT_COPY;
SELECT * FROM EMP_COPY;


-- 부서번호 30번에 소속된 사원의 사원번호, 사원이름, 부서번호 확인
SELECT empno, ename, deptno
FROM EMP_COPY
WHERE deptno=30;


-- 부서번호 30번에 소속된 사원의 사원번호, 사원이름, 부서번호 확인하는 SELECT 문을 하나의 VIEW 로 정의
CREATE VIEW EMP_DEPT_30
AS
SELECT empno, ename, deptno
FROM EMP_COPY
WHERE deptno=30;

SELECT * FROM EMP_DEPT_30;


/*
 * # 복합뷰 
 */

-- 사원 테이블과 부서 테이블을 조인한 복합뷰 생성
-- 사원번호, 이름, 급여, 부서번호, 부서명, 지역명을 출력
CREATE VIEW EMP_DEPT_VIEW
AS
SELECT E.empno, E.ename, E.sal, E.deptno, D.dname, D.loc
FROM EMP E, DEPT D
WHERE E.deptno=D.deptno
ORDER BY empno DESC;

SELECT * FROM EMP_DEPT_VIEW;



/*
 * # ROWNUM
 * - 조회된 데이터에 번호를 부여할 때 사용합니다
 */

SELECT rownum, empno, ename, hiredate
FROM EMP;

SELECT rownum, empno, ename, hiredate
FROM EMP
ORDER BY hiredate;

-- 입사일을 기준으로 오름차순 정렬한 view 생성
CREATE OR REPLACE VIEW HIREDATE_VIEW
AS
SELECT empno, ename, hiredate
FROM EMP
ORDER BY hiredate;


-- 입사일이 빠른 사람 순서로 5명 조회
SELECT rownum, empno, ename, hiredate
FROM HIREDATE_VIEW
WHERE rownum <= 5;


/*
 * # 인라인 뷰
 * - 메인쿼리의 SELECT 문의 FROM 절 내부에 사용된 서브쿼리 입니다
 */

SELECT rownum, empno, ename, hiredate
FROM (SELECT empno, ename, hiredate
      FROM EMP
      ORDER BY hiredate)
WHERE rownum <= 5;



/* quiz */

-- 각 부서별 최대 급여와 최소 급여를 출력하는 'SAL_MAX_MIN' VIEW 를 생성하세요
CREATE OR REPLACE VIEW SAL_MAX_MIN
AS
SELECT D.dname "부서명", MAX(E.sal) "최대 급여", MIN(E.sal) "최소 급여"
FROM EMP_COPY E, DEPT_COPY D
WHERE E.deptno=D.deptno
GROUP BY D.dname;

SELECT * FROM SAL_MAX_MIN;

-- 인라인 뷰를 사용해서 급여를 많이 많는 순서대로 7명을 출력하세요
SELECT ROWNUM, empno, ename, sal
FROM (SELECT empno, ename, sal
      FROM EMP
      ORDER BY sal DESC)
WHERE ROWNUM <= 7;













































