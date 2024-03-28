/*07_테이블_DML.sql*/

/*
# INSERT
- 테이블에 새로운 데이터를 추가할 때 사용
- INSERT INT table_name
  (colum_name, .....)
  VALUES (column_value, .....);
*/

SELECT * FROM DEPT01;

-- 새로운 데이터를 추가하기 위해서 사용하는 명령어 INSERT INTO VALUES는
-- 괄호 안의 컬러명에 있는 목록수와 VALUES 다음에 오는 괄로에 작성한 값의 갯수가 일치해야함


INSERT INTO DEPT01
(deptno, dname, loc)
VALUES
(10, 'accounting', 'new york');

SELECT * FROM DEPT01;

-- 칼럼수와 VALUES 다음에 작성한 값의 수가 다르면 error
-- INSERT INTO PEPT01 (deptno, dname, loc) VALUES (10, 'accounting'); -- error
-- INSERT INTO PEPT01 (deptno, dname, loc) VALUES (10, 'accounting', 'seoul', 1); -- error


-- 컬럼명이 다르면 error
-- INSERT INTO DEPT01 (deptno, dname, lok) VALUES (10, 'accounting', 'seoul'); -- error

-- 컬럼에 입력할 값의 데이터 타입이 다르면 error
-- INSERT INTO DEPT01 (deptno, dname, lok) VALUES (10, 'accounting', seoul); -- error

-- 모든 컬럼에 데이터를 입력하는 경우에는 컬럼 목록을 작성하지 않다도 됨
-- 커럼 목록이 생략되면 VALUES 다름에 값들이 테이블테 순서대로 저장됨
INSERT INTO DEPT01 VALUES(50, 'programming', 'seoul');

SELECT * FROM DEPT01;

INSERT INTO DEPT01 (deptno, dname) VALUES (60, 'ai');

SELECT * FROM DEPT01;

INSERT INTO DEPT01 (loc, dname, deptno) VALUES ('busan', 'cloud', 70);

SELECT * FROM DEPT01;

/*
#NULL 값 추가
- NULL 또는 ''사용
*/

INSERT INTO DEPT01 VALUES (40, 'system', null);

SELECT * FROM DEPT01;

INSERT INTO DEPT01 VALUES (80, '', null);

SELECT * FROM DEPT01;

/*
# 서브쿼리를 사용해서 ROW복사
*/

CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 1=0;

SELECT * FROM DEPT02;

INSERT INTO DEPT02
SELECT * FROM DEPT;

SELECT * FROM DEPT02;

/*
# INSERT ALL 을 사용한 다중행 입력
*/

--사원번호, 사원명, 입사일자를 관리하는 EMP_HIRE 테이블 생성
CREATE TABLE EMP_HIRE
AS
SELECT empno, ename, hiredate
FROM EMP WHERE 1=0;

SELECT * FROM EMP_HIRE;

-- 사원번호, 사원명, 상사를 관리하는 EMP_MGR 테이블 생성
CREATE TABLE EMP_MGR
AS
SELECT empno, ename, mgr
FROM EMP WHERE 1=0;

SELECT * FROM EMP_MGR;

INSERT ALL
INTO EMP_HIRE VALUES (empno, ename, hiredate)
INTO EMP_MGR VALUES (empno, ename, mgr)
SELECT empno, ename, hiredate, mgr
FROM EMP
WHERE deptno=20;

SELECT * FROM EMP_HIRE;
SELECT * FROM EMP_MGR;

/*
#INSERT ALL ~ WHEN(조건)으로 다중 테이블에 다중행 입력
*/

--사원번호, 사원명, 입사일자를 관리하는 EMP_HIRE2 테이블 생성
CREATE TABLE EMP_HIRE2
AS
SELECT empno, ename, hiredate
FROM EMP WHERE 1=0;

SELECT * FROM EMP_HIRE2;

-- 사원번호, 사원명, 상사를 관리하는 EMP_SAL 테이블 생성
CREATE TABLE EMP_SAL
AS
SELECT empno, ename, sal
FROM EMP WHERE 1=0;

SELECT * FROM EMP_SAL;

-- EMP_HIRE2 테이블에는 1982년 1월 1일 이후에 입사한 사원의 정보 추가
-- EMP_SAL 테이블에는 급여가 2000원이산인 사원의 정보 추가
INSERT ALL
WHEN hiredate > '1982/01/01' THEN
INTO EMP_HIRE2 VALUES (empno, ename, hiredate)
WHEN sal >= 2000 THEN
INTO EMP_SAL VALUES(empno, ename, sal)
SELECT empno, ename, hiredate, sal
FROM EMP;

SELECT * FROM EMP_HIRE2;
SELECT * FROM EMP_SAL;

/*
#UPDATE 
- 테이블에 저장된 데이터를 수덩할 때 사용
- UPDATE table_name
  SET colum_name = value, ........
  WHERE conditions;
- WHERE 절을 지정하면 특정 행의 값이 수정되고, 사용하지 않으면 모든 행이 수정 됨
*/

-- 연습테이블
DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01 AS SELECT * FROM EMP;

SELECT * FROM EMP01;

-- 모든 사원의 부서번호를 30번으로 수정
UPDATE EMP01
SET deptno=30;

SELECT * FROM EMP01;

-- 모든 사원의 급여를 10% 인상
UPDATE EMP01
SET sal=sal*1.1;

SELECT * FROM EMP01;

/*
# 특정 행만 수정
*/
DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01 AS SELECT * FROM EMP;

SELECT * FROM EMP01;

-- 부서번호가 10번인 사원의 부서번호를 50번으로 수정
UPDATE EMP01
SET deptno=50
WHERE deptno=10;

SELECT * FROM EMP01;

-- 급여가 3000 이상인 사원의 급여를 10% 인상
UPDATE EMP01
SET sal=sal*1.1
WHERE sal >= 3000;

SELECT * FROM EMP01;

/*
#2개 이상의 컬럼값 변경
- 기존 SET절에 쉼표로 구문해서 '컬럼=값' 을 작성
*/

UPDATE EMP01
SET deptno=50, job='MANAGER'
WHERE ename='SMITH';

SELECT * FROM EMP01;

/*
#서브 쿼리를 사용한 데이터 수정
- UPDATE문의 SET 절에 서브쿼리를 적용하면, 서브쿼리를 실행한 내용이 변경됨
*/
DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;

-- 20번 부서의 지역명을 40번 부서의 지역명으로 변경
UPDATE DEPT01
SET loc=(SELECT loc
         FROM DEPT01
         WHERE deptno=40)
WHERE deptno=20;

SELECT * FROM DEPT01;

-- 부서번호 20번인 수서의 부서명과 지역명을 부서번호 30번과 동일하게 설정
UPDATE DEPT01
SET (dname, loc)=(SELECT dname, loc
                  FROM DEPT01
                  WHERE deptno=30)
WHERE deptno=20;

SELECT * FROM DEPT01;

/*
#DELETE
- 테이블에 저장되어 있는 데이터를 삭제
  DELETE FROM table_name
  WHERE conditions;
  
*/

DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;

-- DEPT01 테이블의 모든 데이터 삭제
DELETE FROM DEPT01;

SELECT * FROM DEPT01;

-- DEPT01 테이블의 30번 부서번호 삭제
DELETE FROM DEPT01
WHERE deptno = 30;
SELECT * FROM DEPT01;

/*
# MERGE
- 구조가 같은 두개의 테이블을 하나의 테이블로 합치는 기능을 함
  > 기존에 존재하는 행이 있으면 새로운 값으로 갱신(UPDATE) 하고
    존재하지 않으면 새로운 행으로 추가 (INSERT) 됨
*/

DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01 AS SELECT * FROM EMP;

SELECT * FROM EMP01;


DROP TABLE EMP02 PURGE;

CREATE TABLE EMP02 AS SELECT * FROM EMP WHERE job='MANAGER';

SELECT * FROM EMP02;

-- EMP02 테이블의 job을 'TEST' 로 변경
UPDATE EMP02
SET job='TEST';

SELECT * FROM EMP02;

-- EMP02 테이블에 데이터 추가
INSERT INTO EMP02
VALUES (7000, 'ROBOT', 'AI', 7777, '2024/01/01', 2000, 200, 90);

SELECT * FROM EMP02;

-- EMP01 테이블에 EMP02 테이블 병합
MERGE INTO EMP01
USING EMP02       -- 병합에 사용하는 데이터 테이블
ON(EMP01.empno=EMP02.empno) -- 테이블 연결조건 : empno 값이 일치하는 행을 기준
WHEN MATCHED THEN
UPDATE SET EMP01.ename=EMP02.emane,
           EMP01.job=EMP02.job,
           EMP01.mgr=EMP02.mgr,
           EMP01.hiredate=EMP02.hiredate,
           EMP01.sal=EMP02.sal,
           EMP01.comm=EMP02.comm,
           EMP01.detpno=EMP02.detpno
WHEN NOT MATCHED THEN
INSERT VALUES (EMP02.empno,
               EMP02.ename,
               EMP02.job,
               EMP02.mgr,
               EMP02.hiredate,
               EMP02.sal,
               EMP02.comm,
               EMP02.detpno
               );
SELECT * FROM EMP01;
SELECT * FROM EMP02;

/* quiz */
SELECT * FROM EMP;
SELECT * FROM DEPT;
-- EMP 테이블의 empno, ename, job, sal 컬럼 이름만 적용된 TEST01 테이블을 생성하세요
-- 이미 있는 테이블이면 삭제후에 생성하세요

DROP TABLE TEST01 PURGE;
DROP TABLE TEST02 PURGE;

CREATE TABLE TEST01 
AS 
SELECT empno, ename, job, sal 
FROM EMP 
WHERE 1=0;

SELECT * FROM TEST01;

-- TEST01 테이블에 데이터를 3개 추가하세요

INSERT INTO TEST01 (empno, ename, job, sal) VALUES (1, 'A', 'ANY', 100);
INSERT INTO TEST01 (empno, ename, job, sal) VALUES (2, 'B', 'ANY', 100);
INSERT INTO TEST01 (empno, ename, job, sal) VALUES (3, 'C', 'ANY', 100);
SELECT * FROM TEST01;

-- TEST01 테이블에 job 은 null 값을 가지는 데이터 2개를 추가하세요

INSERT INTO TEST01 (empno, ename, job, sal) VALUES (4, 'D', '', 100);
INSERT INTO TEST01 (empno, ename, job, sal) VALUES (5, 'E', null, 100);
SELECT * FROM TEST01;

-- TEST01 테이블에 EMP 테이블의 부서번호 10번의 사원 정보를 추가하세요

INSERT ALL
INTO TEST01 VALUES (empno, ename, job, sal)
SELECT empno, ename, job, sal
FROM EMP
WHERE deptno=10;

SELECT * FROM TEST01;

-- TEST01 테이블의 사원 중 급여가 5000 이상인 사원들의 급여를 3000씩 감소 시키세요

UPDATE TEST01
SET sal=sal-3000
WHERE sal >= 5000;

SELECT * FROM TEST01;

-- 서브쿼리를 사용해서 EMP 테이블의 저장된 ename, sal, hiredate, deptno 컬럼을 적용한 TEST02 테이블을 생성하세요

CREATE TABLE TEST02 AS SELECT ename, sal, hiredate, deptno FROM EMP;

SELECT * FROM TEST02;

-- TEST02 테이블의 DALLAS 에 위치한 부서 소속의 사원들 급여를 1000 씩 인상하세요

UPDATE TEST02
SET sal=sal+1000
WHERE deptno=(SELECT deptno
              FROM DEPT
              WHERE LOC = 'DALLAS');
SELECT * FROM TEST02;



-- 서브쿼리 문을 사용해서 TEST02 테이블의 모든 사원의 급여와 입사일을 KING 인 사원의 급여와 입사일로 변경하세요

UPDATE TEST02
SET (sal, hiredate) = (SELECT sal, hiredate
                       FROM TEST02
                       WHERE ename='KING');
         
SELECT * FROM TEST02;

-- TEST01 테이블에서 직급이 정해지지 않은 사원을 삭제하세요

DELETE FROM TEST01
WHERE JOB is null;
SELECT * FROM TEST01;

-- TEST02 테이블에서 RESEARCH 부소 소속 사원들만 삭제하세요

DELETE FROM TEST02
WHERE deptno = (SELECT deptno
                FROM DEPT
                WHERE dname = 'RESEARCH');
SELECT * FROM TEST02;











