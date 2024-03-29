



/* 12_시스템권한.sql */

/*
 * # 데이터베이스 보안을 위한 권한
 * - 시스템 권한, 객체 권한으로 나우어 집니다
 * 
 * # 시스템 권한
 * - 사용자 생성과 제거, DB 접근 및 여러가지 객체를 생성할 수 있는 권한 등의 부여입니다
 * 
 * # 객체 권한
 * - 테이블, 뷰 등의 객체
 */


/*
 * # 사용자 생성
 * - 사용자 계정을 생성하기 위해서는 시스템 권한을 가진 system 으로 접속해야 합니다
 * - CREATE USER '사용자 이름'
 *   IDENTIFIED BY '사용자 암호'
 *   [ WITH ADMIN OPTION ]
 */

-- SYSTEM 계정 연결

-- TEST 계정 생성
CREATE USER TEST
IDENTIFIED BY TEST1234;


-- 생성된 계정 목록 확인
SELECT * FROM ALL_USERS;



/*
 * # GRANT
 * - 사용자에게 시스템 권한을 부여할 때 사용하는 명령어 입니다
 * - GRANT privilege_name, .....
 *   TO user_name;
 */

-- SYSTEM 계정 연결

-- CREATE SESSION : 데이터베이스에 접속할 수 있는 권한
GRANT CREATE SESSION TO TEST;

CONN TEST/TEST1234;


/*
 * # WITH ADMIN OPTION
 * - 사용자에게 시스템 권한을 WITH ADMIN OPTION 과 함께 부여하면,
 *   시스템 권한을 다른 사용자에게도 부여 할 수 있습니다
 */

-- SYSTEM 계정 연결

-- USER01 계정 생성
CREATE USER USER01 IDENTIFIED BY USER01;

-- USER02 계정 생성
CREATE USER USER02 IDENTIFIED BY USER02;


-- USER02 계정에 연결 권한 부여
GRANT CREATE SESSION TO USER02 WITH ADMIN OPTION;

-- USER02 계정 연결
CONN USER02/USER02;


-- USER02 계정에서 USER01 계정에 연결 권한 부여
GRANT CREATE SESSION TO USER01;

CONN USER01/USER01;



/*
 * # 객체 권한
 * - 특정 객체의 조작을 할 수 있는 권한입니다
 * - 객체의 소유자는 객체에 대한 모든 권한을 가집니다
 * - GRANT privileage_name [ column_name ] | ALL -> 권한
 *   ON object_name | role_name | public         -> 객체 선택
 *   TO user_name;                               -> 사용자
 */

-- USER01 계정 연결
CONN USER01/USER01;


-- SCOTT 계정의 EMP 테이블 조회
-- SELECT * FROM SCOTT.EMP; error


-- SCOTT 계정 연결
CONN SCOTT/tiger;


-- SCOTT 소유의 EMP 테이블을 조회할 수 있는 권한을 USER01 계정에 부여
GRANT SELECT ON EMP TO USER01;


-- USER01 계정 연결
CONN USER01/USER01;

-- SCOTT 계정의 EMP 테이블 조회
-- 자신이 소유한 객체가 아닌 경우에는 그 객체를 소유한 사용자명(스키마)를 반드시 지정해야 합니다
-- > 스키마( schema ) : 객체를 소유한 사용자명
SELECT * FROM SCOTT.EMP;



/*
 * # 사용자에게 부여된 권한 조회
 * - 자신에게 부여된 사용자 권한 조회
 *   SELECT * FROM USER_TAB_PRIVS_RECD;
 * 
 *   다른 사용자에게 부여한 권한 조회
 *   SELECT * FROM USER_TAB_PRIVS_MADE;
 */

-- SCOTT 계정 연결
CONN SCOTT/tiger;

SELECT * FROM USER_TAB_PRIVS_RECD;

SELECT * FROM USER_TAB_PRIVS_MADE;


/*
 * # REVOKE
 * - 사용자에게 부여한 객체 권한을 데이터베이스 관리자나 소유자로부터 철회 할 때에는 REVOKE 명령어를 사용합니다
 * - REVOKE privileage_name | ALL             -> 철회하는 객체 권한
 *   ON object_name                          -> 객체 지정
 *   FROM user_name | role_name | public     -> 부여한 사용자명
 */

-- SCOTT 계정 연결
CONN SCOTT/tiger;

-- USER01 사용자에게서 EMP 테이블에 대한 SELECT 권한 철회
REVOKE SELECT ON EMP FROM USER01;


-- USER01 계정 연결
CONN USER01/USER01;

-- 권한 철회 되어서 조회 불가
-- SELECT * FROM SCOTT.EMP; error



/*
 * # 롤 ( role )
 * - 사용자에게 보다 효율적으로 권한을 부여할 수 있도록 여러개의 권한을 묶어 놓은 것입니다
 * - CONNECT 롤
 *   > 사용자가 데이터베이스에 접속 가능하도록 하는 시스템 권한을 묶어 놓았습니다
 * 
 *   RESOURCE 롤
 *   > 사용자가 객체를 생성할 수 있도록 하는 권한을 묶어 놓았습니다
 * 
 *   DBA 롤
 *   > 사용자들이 소유한 데이터베이스 객체를 관리하고, 
 *     사용자들을 생성, 변경, 제거할 수 있는 모든 권한을 가집니다
 */



/* quiz */

-- DBTEST_A 계정을 생성하고, 기본 2개의 롤 권한( CONNECT, RESOURCE ) 을 부여합니다
-- > 1. 계정생성
--   2. 생성된 계정에 권한 부여
--   3. ALTER USER 계정명 DEFAULT TABLESPACE USERS; -> 데이터베이스 저장되는 공간 지정
--   4. ALTER USER 계정명 QUOTA UNLIMITED ON USERS; -> tablespace 용량 지정

CREATE USER DBTEST IDENTIFIED BY a1234;
SELECT * FROM ALL_USERS;

GRANT connect, resource, dba TO DBTEST;
ALTER USER DBTEST DEFAULT TABLESPACE USERS;
ALTER USER DBTEST QUOTA UNLIMITED ON USERS;

-- DBTEST 계정에 회원 정보를 관리하는 MEMBER 테이블을 생성 합니다
-- > SEQ          - 회원수    : 시퀀스 적용
--   ID(30)       - 회원 ID   : 중복 X, NULL 값 사용 불가
--   NAME(30)     - 회원 이름 : NULL 값 사용 불가
--   AGE(3)       - 회원 나이
--   HEIGHT       - 회원 키   : 전체 10자리, 소수점 2번째 자리까지 가능
--   LOGTIME      - 생성일자

-- member 테이블 생성
CREATE TABLE MEMBER(
seq NUMBER NOT NULL,
id VARCHAR2(30) PRIMARY KEY,
--id VARCHAR2(30) CONSTRAINT MEMBER_ID PRIMARY KEY,
name VARCHAR2(30) NOT NULL,
age NUMBER(3),
height NUMBER(10, 2),
logtime DATE
);

DESC MEMBER;

-- 회원수 시퀀스 객체 생성
CREATE SEQUENCE MEMBER_SEQ NOCACHE NOCYCLE;

-- MEMBER 테이블에 데이터 추가, 삭제
INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'U001', 'USER_A', 100, 123.45, SYSDATE);
INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'U002', 'USER_B', 50, 123.45, SYSDATE);

DELETE FROM MEMBER;


SELECT * FROM MEMBER;

-- 시퀀스 삭제
DROP SEQUENCE MEMBER_SEQ;

-- MEMBER 테이블 삭제
DROP TABLE MEMBER;

-- SYSTEM 계정 연결
CONN SYSTEM/oracle;

-- DBTEST 계정 삭제
DROP USER DBTEST CASCADE;

SELECT * FROM ALL_USERS;













