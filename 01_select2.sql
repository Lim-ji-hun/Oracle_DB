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

/*
#오라클 자료형
-NUMBER : 숫자 데이터를 저장
        > MUNBER(precision, scale)
          : precisiom은 소수점을 포함한 전체 자릿수를 의미
          : scale은 소수점 자릿수를 지정
          정수 : NUMBER(5)
          실수 : NUMBER(10, 2) -> 10 : 소주점을 포함한 전체 자릿수
                                  2  : 소수점 이하 자릿수
          VARCHAR2 : 가변길이의 문자열 저장
          > VARCHAR2 ( 가변형 )
            VARCHAR2(10) -> 최대 10글자 까지만 가능하고, 저장되는 문자수 만큼 사용
            
          CHAR : 고정실이의 문자 데인터 저장
          > CHAR( 고정형 )
          CHAR(10) -> 10글자 확정
            
          DATE : 날짜 및 시간

*/

/*
   #select
   - 데이터를 조회하기 위한 SQL명령어
   - SELECT [DISTINCT] { * ,  colume , .......}
     FROM table_name;
     > SELECT 절 뒤에는 출력하고자 하는 컬럼의 이름을 기술
     특정 컬럼 이름 대신 * 을 기술할수있는데, 
     * 은 테이블 내의 모든 컬럼을 풀력하는 경우에 사용
     FROM 절 다음에는 조회하려고 하는 테이블 이름을 기술

*/

--DEPT 테이블의 전체 목록
select * from dept;
--10	ACCOUNTING	NEW YORK -> 회계
--20	RESEARCH	DALLAS      연구
--30	SALES	    CHICAGO     영업
--40	OPERATIONS	BOSTON      운영

-- 특정 데이터만 보기
-- : DEPT 터이블의 부서번호, 부서이름 조회
SELECT DEPTNO, DNAME
FROM DEPT;

SELECT * FROM EMP;

-- 산술 연산
SELECT sal + comm FROM EMP; -- NULL 값은 계산이 안됨
SELECT sal - 100 FROM EMP;
SELECT sal * 12 FROM EMP;
SELECT sal / 20 FROM EMP;

/*
# NULL
- 어떠한 특정 행의 데이터 값이 없는 경우, 해당 값이 null이거나, 
null을 포함함
- 모든 데이터 유형은 null을 포함할수있음
- NULL은 0이 아니고 빈공간도 아님
  미확정, 알 수 없는 값을 의미
  ? 혹은 무한의 의미로 연산, 할당, 비교가 불가능 함

*/

SELECT ename, sal, job, comm, sal*12, sal*12+comm
FROM EMP;

/*
# NVL 함수
  - 칼람의 값이 NULL인경우 지정한 값으로 출력되고, 
    null이 아닌면 원래 값을 그래로 출력
  - NVL(컬럼명, 지정값)
*/
SELECT ename, sal, comm, NVL(comm, 0), sal*12+NVL(comm, 0)
FROM EMP;

/*
# alias
- 열 머리글의 이름을 변경할때 사용
- 컬럼의 이름 대신 별칭을 출력하고가 하면, 
컬럼을 기술한 바로 뒤에 AS키 워드를 사용 한 후 별칭을 기술
*/

SELECT ename, sal*12+NVL(comm, 0) AS Annsal FROM EMP;

SELECT ename, sal*12+NVL(comm, 0) AS "A n n s a l" FROM EMP;

SELECT ename, sal*12+NVL(comm, 0) AS "연봉" FROM EMP;

/*
 * # 연결 연산자 - ||
 * - 여러개의 칼럼을 연결할 때 사용
 * - 리터럴은  SELECT리스트에 포함된 문자, 숫자 또는 날짜 임
 *   숫자 리터럴은 그양 사용해도 되지만, 문자 및 날짜 리터럴은 외따옴표' '로 작성해야함
 */

SELECT ename || ' is a ' || job FROM EMP;

SELECT ename || ' 은(는) ' || job || '이다' AS "업무" FROM EMP;

/*
# DISTNCT
- 기본적으로 쿼리 결과에는 중복 행을 포함한 모든 행이 표시됨
- 이떄 중복행을 제거하여면 SELECT키워드 바로 뒤에 DISTINCT 키워드를 사용
*/

SELECT deptno FROM EMP;

SELECT DISTINCT deptno FROM EMP;

/* Quiz */
-- emp 테이블에서 사원의 이름, 급여, 입사일자만 출력하세요

select * from EMP;
SELECT ENAME,  SAL, HIREDATE
from EMP;

-- 부서정보 테이블의 deptno 는 부서번호, dname 은 부서명으로 별칭을 부여해서 출력하세요

select * from dept;
SELECT deptno AS "부서번호" FROM EMP;
SELECT job AS "부서명" FROM EMP;

SELECT deptno AS "부서번호", dname AS "부서명" FROM dept;

-- 사원정보 테이블의 담당업무가 중복되지 않고, 한번씩 나열되도록 출력하세요
SELECT DISTINCT job FROM EMP;

/*
# where 조건
- 원하는 행만 검색할때에는 행을 제한하는 조건을 SELECT문에 WHERE절을 추가함
- SELECT * [ column, ...]
- FROM table_name
  WHERE 조건식;
- <, >, <=, >=, =, !=
*/

SELECT * FROM EMP;

-- 부서번호 10인 항목
SELECT * 
FROM EMP
WHERE DEPTNO=10;

-- 이름이 FORD인 사원의 사원번호, 사원이름, 급여 확인
-- > SQL문에서 문자열이나 날짜는 반드시 외따옴표 안에서 작성해야함
-- 테이블 내에 저장된 값은 대소문자를 구별함
SELECT empno, ename, sal
FROM EMP
WHERE ename='FORD';

-- 1982년 1월 1일 이전에 입사한 사람
SELECT*
FROM EMP
WHERE hiredate<'1982/01/01';


/*
 #논리 연산자
  and, or, not

*/
-- 부서번호가 10이면서, 직급이 MANAGER인 사람
SELECT *
FROM EMP
WHERE deptno=10 AND job = 'MANAGER';

-- 부서번호가 10번 이거나, 직급이 MANAGER인 사람
SELECT *
FROM EMP
WHERE deptno=10 OR job='MANAGER';

-- 부서번호가 10번 아닌 사람
SELECT *
FROM EMP
WHERE NOT deptno=10;

SELECT *
FROM EMP
WHERE deptno!=10;

-- 2000~4000 사이의 급여를 받는 사람
SELECT *
FROM EMP
WHERE sal>=2000 AND sal<=4000;

-- BETWEEN AND 연산자
-- > 특정 범위의 값 확인
-- column_name BEATWEEN a and b
SELECT *
FROM EMP
WHERE sal BETWEEN 2000 AND 4000;

-- 1981년도에 입사한 사람
SELECT*
FROM EMP
WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';

/*
in 연산자
- 테이블안에 해당 값이 있는지 확인
- column_name IN (a, b, c ....)
*/
-- 커미션이 300 이거나, 500 인 사원
SELECT*
FROM EMP
WHERE comm IN(300, 500);

/*
# LIKE 연산자와 와일드 카드
- 검색하는 값을 정확히 모를때에 검색이 가능
- column_name LIKE pattern
  > % : 0개 이상의 문자
    _ : 임의의 단일 문자
*/
--emp 테이블에서 이름이 M으로 시작하는 모든사원
SELECT*
FROM EMP
WHERE ename LIKE 'M%';

--emp 테이블에서 이름이 O가 들어있는 모든사원
SELECT*
FROM EMP
WHERE ename LIKE '%O%';

--emp 테이블에서 이름이 K으로 시작하는 이름이 4글자인 모든사원
SELECT*
FROM EMP
WHERE ename LIKE 'K___';

--emp 테이블에서 이름이 A가 들어있지 않은 모든사원
SELECT*
FROM EMP
WHERE ename NOT LIKE '%A%';

--emp 테이블에서 comm 컬럼의 값이 null인 모든 사원
SELECT*
FROM EMP
WHERE comm IS null;
--WHERE comm = null; null은 비교할수있는 대상이 아니기에 '=' 사용할시 안나옴

/*
# ORDER BY
- 데이터를 정렬할때 사용
- 정렬방식을 지정하지 않으며, 기본적으로 오름차순 정렬함
*/
--emp테이블의 급여를 기준으로 오름차순 정렬
SELECT*
FROM EMP
ORDER BY sal ASC;

--emp테이블의 급여를 기준으로 내림차순 정렬
SELECT*
FROM EMP
ORDER BY sal DESC;

--emp테이블의 급여를 기준으로 내림차순 정렬하고, 
-- 급여가 같으면 이름을 기준으로 내림차순 정렬
SELECT*
FROM EMP
ORDER BY sal DESC, ename DESC;

/* quiz */
-- emp 테이블에서 급여가 3000 이상인 사원의 사원번호, 이름, 직급, 급여를 출력하세요
select * from EMP;

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE sal>=3000;

-- emp 테이블에서 직급이 MANAGER 인 사원의 사원번호, 이름, 직급, 급여, 부서번호를 출력하세요

SELECT EMPNO, ENAME, JOB, SAL, deptno
FROM EMP
WHERE job='MANAGER';

-- emp 테이블에서 사원번호가 7902, 7782, 7566 인 사원의 사원번호, 성명, 직급, 급여, 입사일자를 출력하세요
SELECT EMPNO, ENAME, JOB, SAL, hiredate
FROM EMP
WHERE EMPNO=7902 OR EMPNO=7782 OR EMPNO=7566;
--WHERE EMPNO IN (7902, 7782, 7566);

-- emp 테이블에서 직급이 MANAGER, CLERK 이 아닌 사원의 사원번호, 성명, 직급, 급여, 부서번호를 출력하세요
SELECT EMPNO, ENAME, JOB, SAL, deptno
FROM EMP
WHERE job !='MANAGER' ANd job !='CLERK';
--WHERE EMPNO NOT IN ('MANAGER', 'CLERK');

-- emp 테이블을 부서번호로 오름차순 정렬한 후에
-- 부서번호가 같으면 급여가 많은 순서로 정렬하여 사원번호, 성명, 직급, 부서번호, 급여을 출력하세요

SELECT EMPNO, ENAME, JOB, deptno, SAL
FROM EMP
ORDER BY deptno ASC, SAL DESC;











