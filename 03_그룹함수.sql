/* 03_그룹함수.sql */

/*
#그룹함수
- 하나이상의 행을 그룹으로 묶어서 결과를 나타냄
- SELECT 문 뒤에 작성하고, 여러 그룹 함수를 쉼표로 구분하여 함께 사용할수있음
- SELECT group_function(column), ......
  FROM table_name
- 그룹 함수는 해당 컬럼 값이 null인 것을 제외하고 계산
*/

/*
#SUM
- 해당 칼럼 값들에 대한 총합을 구함
*/

-- 급여 총액
SELECT SUM(sal)
FROM EMP;

/*
#AVG
- 해당 칼럼 값들에 대한 평균을 구함
*/

SELECT trunc(AVG(sal), 2) "평균 급여"
FROM EMP;

/*
#MAX, MIN
- 최대, 최소값을 구함
*/

-- 가장 높은 급여와 낮은 급여
SELECT MAX(sal) "높은 급여", MIN(sal) "낮은 급여"
FROM EMP;

/*
#COUNT
- 행의 수를 반환
*/

-- 전체 사원수와 커미션 받는 사원수
SELECT COUNT(*) "전체 사원수", COUNT(comm) "커미션 대상"
FROM EMP;

-- 업무종류
SELECT COUNT(DISTINCT job) "업무수" -- 중복제거를 해줘야 함
FROM EMP;

/*
#GROUP BY
- 어떤 컬럼값을 기준으로 그룹 함수를 적용할 수 있습니다
- SELECT 컬럼값, 그룹함수
  FROM 테이블명
  WHERE 조건
  GROUP BY 컬럼명;
*/

-- 부서번호 그룹
SELECT deptno
FROM EMP
GROUP BY deptno;

-- 부서별 평균 급여
SELECT deptno, AVG(sal)
FROM EMP
GROUP BY deptno;

-- 부서별 가장 높은 급여와 낮은 급여
SELECT deptno, MAX(sal) "높은 급여", MIN(sal) "낮은 급여"
FROM EMP
GROUP BY deptno;

-- ORDER BY 절은 마지막에 작성
SELECT deptno, COUNT(*), COUNT(comm)
FROM EMP
GROUP BY deptno
ORDER BY deptno;

/*
#HAVING
- 그룹의 결과를 제한할때 HAVING절을 사용
*/

-- 부서별 평균 급여를 구하고, 부서별 평균 급여가 2000이상인 부서만 출력
SELECT deptno, TRunc(AVG(sal), 1)
FROM EMP
GROUP BY deptno
HAVING AVG(sal) >= 2000;

/* quiz */
SELECT *
FROM EMP;
-- 가장 최근에 입사한 사원의 입사일과 가장 오래된 사원의 입사일을 출력하세요
SELECT MAX(hiredate) "최근에 입사한 사원", MIN(hiredate) "가장 오래된 사원"
FROM EMP;

-- 부서별 커미션을 받는 사원의 수를 출력하세요
SELECT deptno, COUNT(comm) "커미션을 받는 사원"
FROM EMP
GROUP BY deptno;

-- SALESMAN   의 급여에 대해서 평균, 최고액, 최저액, 합계를 구하세요
SELECT trunc(AVG(sal), 2) "평균", MAX(sal) "최고액", MIN(sal) "최저액", SUM(sal) "합계"
FROM EMP
WHERE JOB LIKE 'SALESMAN';

-- 각 부서별로 인원수, 급여 평균, 최저 급여, 최고 급여, 급여의 합을 구하고
-- 급여의 합이 높은 순서로 출력하세요
SELECT deptno, COUNT(*), TRunc(AVG(sal), 1) "평균", MAX(sal) "최고 급여", MIN(sal) "최저 급여", SUM(sal) "급여의 합"
FROM EMP
GROUP BY deptno
ORDER BY SUM(sal) DESC;

-- 직급별 급여의 평균이 3000 이상인 직급에 대해서 직급, 평균 급여, 급여의 합을 출력하세요
SELECT job, AVG(sal), SUM(sal)
FROM EMP
GROUP BY job
HAVING AVG(sal) >= 3000;

-- 전체 월급이 4000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력하세요
-- 단, SALESMAN 은 제외하고 월급여 합계로 내림차순 정렬합니다
SELECT job, SUM(sal)
FROM EMP
WHERE job NOT LIKE 'SALESMAN'
GROUP BY job
HAVING AVG(sal) >= 4000
ORDER BY SUM(sal) DESC;



