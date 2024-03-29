



/* 09_무결성 제약조건.sql */

/*
 * # 데이터 무결성 제약 조건 ( Data Integrity Constraint Rule )
 * - 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해 테이블을 생성할 때,
 *   각 컬럼에 대해서 정의하는 규칙입니다
 * 
 * # 무결성 제약 조건
 * - NOT NULL
 *   > NULL 값을 허용하지 않습니다
 * 
 *   UNIQUE
 *   > 중복된 값을 허용하지 않고, 항상 유일한 값을 갖도록 합니다
 * 
 *   PRIMARY KEY
 *   > NULL 을 허용하지 않고, 중복된 값도 허용하지 않습니다
 * 
 *   FOREIGN KEY
 *   > 참조되는 테이블의 컬럼에 같이 있으면 허용됩니다
 * 
 *   CHECK
 *   > 저장 가능한 데이터의 값을 범위나 조건을 지정하여 설정한 값만을 허용합니다          
 *                                                                                                                                              
 */

/*
 * # NOT NULL
 * - 특정 컬럼은 반드시 값이 입력되도록 필수 입력 컬럼으로 지정하는 것입니다
 */

-- NOT NULL 제약 조건을 사용하지 않는 테이블\
DROP TABLE EMP01;

CREATE TABLE EMP01(
empno NUMBER(4),
ename VARCHAR2(10),
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC EMP01;


-- 데이터 추가
INSERT INTO EMP01 VALUES(NULL, NULL, 'SALESMAN', 30);

SELECT * FROM EMP01;



-- NOT NULL 제약 조건을 사용하는테이블
DROP TABLE EMP02;

CREATE TABLE EMP02(
empno NUMBER(4) NOT NULL,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC EMP02;


-- 데이터 추가
INSERT INTO EMP02 VALUES(NULL, NULL, 'SALESMAN', 30);



/*
 * # UNIQUE
 * - 특정 커럼에 대해서 중복된 데이터가 저정된지 않게 합니다
 */

-- UNIQUE 제약 조건을 사용하는 테이블
DROP TABLE EMP03;

CREATE TABLE EMP03(
empno NUMBER(4) UNIQUE,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC EMP03;

-- 데이터 추가
INSERT INTO EMP03 VALUES(1100, 'ORACLE', 'DB', 50);

SELECT * FROM EMP03;


-- 동일한 사원번호가 들어가면 error
-- INSERT INTO EMP03 VALUES(1100, 'MARIA', 'DB', 50);


-- UNIQUE 제약 조건 설정된 컬럼에 NULL 값을 사용할 수 있습니다
INSERT INTO EMP03 VALUES(NULL, 'MARIA', 'DB', 50);

SELECT * FROM EMP03;



/*
 * # PRIMARY KEY
 * - NOT NULL 과 UNIQUE 를 결합한 제약 조건입니다
 */

-- PRIMARY KEY 제약 조건을 사용하는 테이블
DROP TABLE EMP04;

CREATE TABLE EMP04(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC EMP04;

-- 데이터 추가
INSERT INTO EMP04 VALUES(1100, 'ORACLE', 'DB', 50);

SELECT * FROM EMP04;

INSERT INTO EMP04 VALUES(1100, 'MARIA', 'DB', 50);
INSERT INTO EMP04 VALUES(NULL, 'MARIA', 'DB', 50);



/*
 * # 참조 무결성
 * - 테이블과 테이블 사이에서 발생하는 개념입니다
 *  
 * # FOREIGN KEY
 * - 사원 정보 테이블의 부서번호는 반드시 부서 테이블의 존재하는 부서번호만 사용되게 할 때,
 *   사원 정보 테이블이 부서 테이블의 부서번호를 참조 가능하도록 합니다
 * - 부모 키가 되기 위한 컬럼은 반드시 부모 테이블의 PIRMARY KEY 또는 UNIQUE 로 설정되어 있어야 합니다
 *
 */

-- FOREIGN KEY 제약 조건을 사용하는 테이블
DROP TABLE EMP05;

CREATE TABLE EMP05(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2) REFERENCES DEPT(deptno)
);

DESC EMP05;


-- 데이터 추가
INSERT INTO EMP05 VALUES(1100, 'ORACLE', 'DB', 40);

SELECT * FROM EMP05;

INSERT INTO EMP05 VALUES(1100, 'MARIA', 'DB', 50);



/*
 * # CHECK
 * - 입력되는 값을 확인하여 설정된 값 이외의 값이 들어오면 명령이 수행되지 않습니다
 * - 조건으로 데이터 값의 범위나 특정 패턴의 숫자나 문자 값을 설정할 수 있습니다
 */

-- CHECK 제약 조건을 사용하는 테이블
DROP TABLE EMP06;

CREATE TABLE EMP06(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
sal NUMBER(7, 2) CHECK(sal BETWEEN 500 AND 10000),
gender VARCHAR2(1) CHECK(gender IN ('M', 'F'))
);

DESC EMP06;


-- 데이터 추가
INSERT INTO EMP06 VALUES(1100, 'JAVA', 300, 'F');

INSERT INTO EMP06 VALUES(1100, 'JAVA', 2000, 'F');

SELECT * FROM EMP06;


INSERT INTO EMP06 VALUES(1100, 'PYTHON', 3000, 'm');

INSERT INTO EMP06 VALUES(1100, 'PYTHON', 2000, 'M');

SELECT * FROM EMP06;



/*
 * # DEFAULT
 * - 아무런 값이 입력되지 않으며, DEFAULT 설정한 값이 들어갑니다
 */

--  DEFAULT 제약 조건을 사용하는 테이블
-- 연습테이블
DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01(
deptno NUMBER(2) PRIMARY KEY,
dname VARCHAR2(10) NOT NULL,
loc VARCHAR2(10) DEFAULT 'SEOUL'
);

DESC EMP01;

-- 데이터 추가
INSERT INTO DEPT01 (deptno, dname) VALUES(50, 'DATABASE');

SELECT * FROM DEPT01;



/*
 * # 제약 조건명을 작성해서 제약 조건 설정
 * - 제약 조건명을 설정할 때 제약 조건명을 지정할 수 있습니다
 *   제약 조건명을 지정하지 않으면 자동으로 제약 조건명을 부여합니다
 *   오라클이 부여하는 제약 조건명은 SYS_ 다음에 숫자를 나열합니다
 */


-- 제약 조건명을 사용하는 테이블
DROP TABLE EMP07;

CREATE TABLE EMP07(
empno NUMBER(4) CONSTRAINT EMP07_PK_EMPNO PRIMARY KEY,
ename VARCHAR2(10) CONSTRAINT EMP07_NN_ENAME NOT NULL,
job VARCHAR2(9),
deptno NUMBER CONSTRAINT EMP07_FK_DEPTNO REFERENCES DEPT(deptno)
);

DESC EMP07;

-- 제약 조건 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP07');






























