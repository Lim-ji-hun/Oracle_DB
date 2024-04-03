-- 1. 테이블 생성 – userinfo
-- - ID : 숫자, null 값을 허용하지 않음, PRIMARY KEY
-- - PWD : 문자열 20자, null 값을 허용하지 않음
-- - NAME : 문자열 20자, null 값을 허용하지 않음

CREATE TABLE userinfo(
ID NUMBER PRIMARY KEY,
PWD VARCHAR2(20) NOT NULL,
NAME VARCHAR2(20) NOT NULL
);

SELECT * FROM userinfo;
DROP TABLE userinfo;

-- 2. 테이블 userinfo 에 열(컬럼) 추가
-- - EMAIL : 문자열 30자, null 값 허용

ALTER TABLE userinfo ADD EMAIL VARCHAR(30);

SELECT * FROM userinfo;

-- 3. userinfo 테이블에 데이터 입력
-- - 1, ‘1234’, ‘홍길동’, ‘hong@it-kys.com’
-- - 2, ‘1234’, ‘이순신’, ‘lee@it-kys.com’
-- - 3, ‘1234’, ‘유관순’
-- - 4, ‘1234’, ‘신사임당’, ‘shin@it-kys.com’
-- - 5, ‘1234’, ‘김유신’

INSERT INTO userinfo VALUES (1, '1234', '홍길동', 'hong@it-kys.com');
INSERT INTO userinfo VALUES (2, '1234', '이순신', 'lee@it-kys.com');
INSERT INTO userinfo VALUES (3, '1234', '유관순', null);
INSERT INTO userinfo VALUES (4, '1234', '신사임당', 'shin@it-kys.com');
INSERT INTO userinfo VALUES (5, '1234', '김유신', null);

-- 4. scott 계정의 EMP, DEPT 테이블을 join 해서, SMITH 사원의 사원명, 부서명, 부서번호 확인

SELECT ename, dname, EMP.deptno
FROM EMP, DEPT
WHERE EMP.deptno=DEPT.deptno
AND ename='SMITH';

-- 5. scott 계정에 veiw 생성 권한을 부여하고, 30번 부서에 소속된 사원들의 사원번호, 이름, 부서번호를 출력하기 위한 SELECT 문을 하나의 뷰로 정의
GRANT CREATE VIEW TO scott;
CREATE TABLE EMPVIEW AS SELECT * FROM EMP;
  
CREATE VIEW about30
AS
SELECT empno, ename, deptno
FROM EMPVIEW
WHERE deptno=30;

SELECT * FROM about30;



