-- 1. test 계정을 생성하세요   
CREATE USER test IDENTIFIED BY test;
SELECT * FROM ALL_USERS;
DROP USER test CASCADE;

-- test 계정에 접속, 데이터 작업 권한 롤을 부여하세요
GRANT connect, resource, dba TO test;

-- test 계정에 tabllespace를 users 로 설정하세요
-- test 계정의 tablespace 사용 용량을 제한 없음으로 설정하세요
ALTER USER test DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
 

-- 2. test 계정에 회원 정보 테이블(member) 생성
-- 회원수 - 시퀀스 적용
-- 회원 ID - (중복 X, 유일키)
-- 회원이름 - null 값 사용불가
-- 회원나이
-- 회원키 - 전체 10자리, 소수점 2번째 자리까지
-- 생성일자
CREATE TABLE MEMBER(
num NUMBER,
id VARCHAR2(10) PRIMARY KEY,
name VARCHAR2(10)  NOT NULL,
old NUMBER,
height NUMBER(10, 2),
cret DATE
);

DROP TABLE MEMBER;

-- 3. 회원 정보 테이블(member)의 항목을 확인
SELECT * FROM MEMBER;

-- 4. 회원 정보 테이블(member)의 회원수에 사용하는 시퀀스 객체 생성
CREATE SEQUENCE MEMBER_num NOCACHE NOCYCLE;
DROP SEQUENCE MEMBER_num;

-- 5. 회원 정보 테이블(member) 시퀀스 객체를 사용한 데이터 추가
INSERT INTO MEMBER VALUES(MEMBER_num.NEXTVAL, 'id', 'name', 100, 170.10, SYSDATE);
DELETE FROM MEMBER;





















