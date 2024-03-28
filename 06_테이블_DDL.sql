



/* 06_테이블_DDL.sql */

/*
 * # DDL( Data Definition Language ) : 테이블 생성, 수정, 삭제
 * - CREATE TABLE
 *   : 데이터를 저장하는 새로운 테이블을 생성합니다
 * - CREATE TABLE table_name (
 *   column_name , data_type expr ,
 *   column_name , data_type expr ,
 *   .....
 *   );
 * 
 */

DESC EMP;
-- EMPNO    NOT NULL NUMBER(4)    
-- ENAME             VARCHAR2(10) 
-- JOB               VARCHAR2(9)  
-- MGR               NUMBER(4)    
-- HIREDATE          DATE         
-- SAL               NUMBER(7,2)  
-- COMM              NUMBER(7,2)  
-- DEPTNO            NUMBER(2)   


-- 사원번호, 사원이름, 급여 3개의 컬럼으로 구성된 EMP01 테이블 생성
CREATE TABLE EMP01(
empno NUMBER(4),
ename VARCHAR2(10),
sal NUMBER(7, 2)
);

DESC EMP01;
SELECT * FROM EMP01;


-- CREATE TABLE 문에서 서브쿼리를 사용하여
-- 기존 테이블과 동일한 구조의 내용을 갖는 새로운 테이블을 생성할 수 있습니다
CREATE TABLE EMP02
AS
SELECT * FROM EMP;

DESC EMP02;
SELECT * FROM EMP02;


-- 기존 테이블에서 원하는 컬럼만 선택적으로 복사해서 생성할 수도 있습니다
CREATE TABLE EMP03
AS
SELECT empno, ename FROM EMP;

DESC EMP03;
SELECT * FROM EMP03;


-- 기존 테이블의 구조만 복사
-- : WHERE 조건에 항상 거짓이되는 조건을 지정합니다
CREATE TABLE EMP04
AS
SELECT * FROM EMP WHERE 1=0;

DESC EMP04;
SELECT * FROM EMP04;



/*
 * # ALTER TABLE
 * - 기존 테이블의 구조를 변경하기 위해서 사용되는 DDL 명령문 입니다
 * - ADD COLUMN    : 새로운 컬럼 추가
 *   MODIFY COLUMN : 기존 컬럼 수정
 *   DROP COLUMN   : 기존 컬럼 삭제
 */

/*
 * # ALTER TABLE ADD
 * - 기존 테이블에 새로운 컬럼을 추가합니다
 * - 새로운 컬럼은 테이블의 마지막에 추가되며, 자신이 원하는 위치에 만들어 넣을 수 없습니다
 * - ALTER TABLE table_name
 *   ADD ( column_name, data_type, ... );
 */

-- EMP01 테이블에 job 컬럼 추가
ALTER TABLE EMP01
ADD(job VARCHAR2(9));
 
DESC EMP01;


-- 컬럼 이름 수정
-- ALTER TABLE table_name
-- RENAME COLUMN '현재 컬럼명' to '수정 컬럼명';
ALTER TABLE EMP02
RENAME COLUMN mgr to mgrno;

DESC EMP02;
SELECT * FROM EMP02;


/*
 * # ALTER TABLE MODIFY
 * - 기존 컬럼의 속성을 변경합니다
 * - 속성을 변경한다는 것은 컬럼에 대한 데이터 타입이나 크기를 변경하는 것입니다
 * - ALTER TABLE table_name
 *   MODIFY ( column_name, data_type, ... );
 */

DESC EMP01;

-- job 컬럼을 최대 30글자까지 저장할 수 있게 변경
ALTER TABLE EMP01
MODIFY(job VARCHAR2(30));

DESC EMP01;


/*
 * # ALTER TABLE DROP
 * - 테이블에서 사용중인 컬럼을 삭제합니다
 * - ALTER TABLE table_name
 *   DROP COLUMN column_name;
 */

-- EMP01 테이블의 job 컬럼 삭제
ALTER TABLE EMP01
DROP COLUMN job;

DESC EMP01;


/*
 * # 테이블 삭제
 * - DROP TABLE table_name;
 */

-- EMP01 테이블 삭제( 휴지통 보관 )
DROP TABLE EMP01;   

SELECT * FROM TAB;


-- 휴지통 조회
SELECT * FROM recyclebin;

-- 휴지통에 있는 테이블 복구
-- FLASHBACK TABLE '복구 테이블명' TO BEFORE DROP;
FLASHBACK TABLE EMP01 TO BEFORE DROP;

SELECT * FROM TAB;


-- 휴지통 거치지 않고 삭제
-- DROP TABLE '삭제 테이블명' PURGE;
DROP TABLE EMP01 PURGE;

SELECT * FROM recyclebin;


/*
 * # 테이블의 모든 행(ROW) 삭제
 * - TRUNCATE TABLE table_name;
 */

SELECT * FROM EMP02;

-- EMP02 테이블의 모든 행 삭제
TRUNCATE TABLE EMP02;

SELECT * FROM EMP02;


/*
 * # 테이블 이름 변경
 * - RENAME '기존 테이블명' TO '새로운 테이블명'
 */

SELECT * FROM TAB;

-- EMP02 테이블 이름 변경
RENAME EMP02 TO NEWEMP02;

SELECT * FROM TAB;



/* quiz */

-- 아래와 같은 구조를 가진 dept01 테이블을 생성하세요
-- deptno   NUMBER(2)
-- dname    VARCHAR2(14)
-- loc      VARCHAR2(13)
CREATE TABLE DEPT01(
deptno   NUMBER(2),
dname    VARCHAR2(14),
loc      VARCHAR2(13)
);

DESC DEPT01;
SELECT * FROM TAB;

-- emp 테이블의 사원번호, 사원이름, 급여 컬럼을 복사해서 empcopy 테이블을 생성하세요
CREATE TABLE EMPCOPY
AS
SELECT empno, ename, sal FROM EMP;

SELECT * FROM EMPCOPY;

-- dept 테이블과 동일한 구조의 빈 테이블 dept02 를 생성하세요
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 1=0;

SELECT * FROM DEPT02;

-- dept02 테이블을 삭제하세요
DROP TABLE DEPT02;

SELECT * FROM TAB;

-- dept 테이블과 동일한 구조의 빈 테이블 dept03 을 생성하세요
-- dept03 테이블에 문자 타입의 부서장(dmgr) 컬럼을 추가하세요 ( 크기 자유 )
CREATE TABLE DEPT03
AS
SELECT * FROM DEPT WHERE 1=0;

ALTER TABLE DEPT03
ADD (dmgr VARCHAR2(10));

DESC DEPT03;

-- dept03 테이블의 부서장 컬럼을 삭제하세요
ALTER TABLE DEPT03
DROP COLUMN dmgr;

DESC DEPT03;
















