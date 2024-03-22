-- 01_select.sql

show user;

--테이블 목록
select * from tab;

--테이블 구조 확인
--desc 테이블명
-- : 테이블의 컬럼이름, 데이터 타입, 길이, NULL 허용 유무 등과 같은 특정데이터 정보를 알려줌

desc dept;
-- DEPT 테이블 : 부서정보
-- DEPTNO NOT NULL NUMBER(2)  -> 부서 번호
-- DNAME        VARCHAR2(14)  -> 부서명
-- LOC          VARCHAR2(13)  -> 부서 지역

desc emp;
-- EMP 테이블 : 사원 정보
-- EMPNO    NOT NULL NUMBER(4)     -> 사원 번호
-- ENAME             VARCHAR2(10)  -> 사원명
-- JOB               VARCHAR2(9)   -> 담당 업무
-- MGR               NUMBER(4)     -> 상사 사원 번호
-- HIREDATE          DATE          -> 입사일
-- SAL               NUMBER(7,2)   -> 급여
-- COMM              NUMBER(7,2)   -> 커미션
-- DEPTNO            NUMBER(2)     -> 부서번호



























