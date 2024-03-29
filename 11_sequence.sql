



/* 11_sequence.sql */

/*
 * # 시퀀스 ( sequence )
 * - 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 생성기 입니다
 * - CREATE SEQUENCE sequence_name
 *   START WITH            -> 시퀀스 번호의 시작값 설정
 *   INCEMENT BY           -> 연속적인 시퀀스 번호의 증가치
 *   MAXVALUE | NOMAXVALUE -> 최대값 지정
 *   MINVALUE | NOMINVALUE -> 최소값 지정
 *   CYCLE | NOCYCLE       -> 시퀀스 최대값까지 완료되면 시작값에 다시 시작
 *   CACHE | CACHE         -> 메모리상의 시퀀스 값 관리
 */

-- 시퀀스 객체 생성
CREATE SEQUENCE TEST_SEQ
START WITH 1
INCREMENT BY 1;


-- NEXTVAL 로 새로운 값을 생성
SELECT TEST_SEQ.NEXTVAL
FROM DUAL;


-- 시퀀스 객체의 현재값
SELECT TEST_SEQ.CURRVAL
FROM DUAL;


-- 시퀀스 객체 삭제
DROP SEQUENCE TEST_SEQ;


-- 연습용 테이블
DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01(
empno NUMBER(4) CONSTRAINT PK_SEQ_EMPNO PRIMARY KEY,
ename VARCHAR2(10),
hiredate DATE
);

DESC EMP01;


-- EMP01 테이블의 empno 컬럼 시퀀스 객체 생성
CREATE SEQUENCE EMP01_EMPNO_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 1000;


-- 데이터 추가
INSERT INTO EMP01 VALUES (EMP01_EMPNO_SEQ.NEXTVAL, 'MAN_A', SYSDATE);
INSERT INTO EMP01 VALUES (EMP01_EMPNO_SEQ.NEXTVAL, 'MAN_B', SYSDATE);

SELECT * FROM EMP01;

DROP SEQUENCE EMP01_EMPNO_SEQ;



/*
 * # 시퀀스 수정
 * - ALTER SEQUNCE 는 START WITH 절 빼고, CREATE SEQUENCE 와 구조가 동일합니다
 * - START WITH 옵션은 변경할 수 없고, 다시 시작하려면 시퀀스를 삭제하고 다시 생성해야 합니다
 */

-- 연습용 테이블
CREATE TABLE SEQTEST(
sno NUMBER(2) PRIMARY KEY
);

DESC SEQTEST;

-- SEQTEST 테이블 sno 컬럼에 적용하는 시퀀스 객체 생성
CREATE SEQUENCE SEQTEST_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 3;


-- 데이터 추가
INSERT INTO SEQTEST VALUES (SEQTEST_SEQ.NEXTVAL);
INSERT INTO SEQTEST VALUES (SEQTEST_SEQ.NEXTVAL);
INSERT INTO SEQTEST VALUES (SEQTEST_SEQ.NEXTVAL);

SELECT * FROM SEQTEST;

-- INSERT INTO SEQTEST VALUES (SEQTEST_SEQ.NEXTVAL); ERROR


-- 시퀀스 최대값 수정
ALTER SEQUENCE SEQTEST_SEQ MAXVALUE 10;

INSERT INTO SEQTEST VALUES (SEQTEST_SEQ.NEXTVAL);

SELECT * FROM SEQTEST;


DROP TABLE SEQTEST PURGE;
DROP SEQUENCE SEQTEST_SEQ;



/*- quiz -*/

-- 부서정보를 가지는 테이블을 생성하세요 : 부서번호, 부서명, 지역
-- > 부서번호는 sequence 를 사용해서 적용 합니다( 초기값 10, 10씩 증가 )
CREATE TABLE QDEPT(
deptno NUMBER(2) PRIMARY KEY,
dname VARCHAR2(10),
loc VARCHAR2(10)
);

DESC QDEPT;

CREATE SEQUENCE QDEPT_SEQ
START WITH 10
INCREMENT BY 10;

INSERT INTO QDEPT VALUES (QDEPT_SEQ.NEXTVAL, '부서-A', '지역-A');
INSERT INTO QDEPT VALUES (QDEPT_SEQ.NEXTVAL, '부서-B', '지역-B');
INSERT INTO QDEPT VALUES (QDEPT_SEQ.NEXTVAL, '부서-C', '지역-C');

SELECT * FROM QDEPT;

DROP TABLE QDEPT PURGE;
DROP SEQUENCE QDEPT_SEQ;




























