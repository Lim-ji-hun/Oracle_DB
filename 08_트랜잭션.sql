



/* 08_트랜잭션.sql */

/*
 * # 트랜잭션 ( transaction )
 * - 데이터베이스 내에서 하나의 그룹으로 처리되어야 하는 명령문들을 모아 놓은 작업 단위입니다
 * - 여러개의 명령어의 집합이 정상적으로 처리되면 정상 종료하도록 하고,
 *   여러개의 명령어 중에서 하나의 명령이라도 잘 못 되었다면 전체를 취소해 버리게 됩니다
 */

/*
 * # 트랜잭션 명령어
 * - COMMIT
 *   ROLLBACK
 *   SAVEPOINT
 */

/*
 * # COMMIT
 * - 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어 입니다
 * - 트랜잭션의 처리 과정을 데이터베이스에 반영하기 위해서 변경된 내용을 모두 영구 저장합니다
 * - COMMIT 을 수행하면 하나의 트랜잭션 과정을 완료하게 됩니다
 */

/*
 * # ROLLBACK
 * - 작업중 문제가 발생했을 때, 트랜잭션의 처리 과정에서 발생한 변경 사항을 취소하고
 *   트랜잭션 과정을 종료합니다
 * - 이전 COMMIT 한 곳까지만 복구됩니다
 */

-- 연습테이블
DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;


-- DEPT01 테이블 내용 삭제
DELETE FROM DEPT01;

SELECT * FROM DEPT01;


-- ROLLBACK 을 수행해서 데이터 복구
ROLLBACK;
SELECT * FROM DEPT01;


-- 부서번호 20번 삭제
DELETE FROM DEPT01
WHERE deptno=20;

SELECT * FROM DEPT01;

-- 데이터 삭제한 결과를 영구 저장하기 위해서 COMMIT 수행
COMMIT;
SELECT * FROM DEPT01;

ROLLBACK;
SELECT * FROM DEPT01;



/*
 * 
 * # Auto commit
 * - DDL 문(ater, drop, rename) 은 자동으로 commit 을 진행합니다
 */

-- 연습테이블
DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;


-- 부서번호 40번 삭제
DELETE FROM DEPT01
WHERE deptno=40;

SELECT * FROM DEPT01;


DROP TABLE DEPT02 PURGE;

CREATE TABLE DEPT02 AS SELECT * FROM DEPT;

SELECT * FROM DEPT02;


ROLLBACK;

-- ROLLBACK 명령문을 실행했지만 DDL 문이 먼저 수행되면서 자동 COMMIT 이 진행되어 복구 되지 않습니다
SELECT * FROM DEPT01;



/*
 * # SAVEPOINT
 * - 현재의 트랜잭션을 분할하는 명령어 입니다
 * - 저장된 SAVEPOINT 는 'ROLLBACK TO SAVEPOINT' 문을 사용해서, 표시한 곳까지 ROLLBACK 할 수 있습니다
 */

-- 연습테이블
DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;


-- 40부서 삭제 -> COMMIT
DELETE FROM DEPT01 WHERE deptno=40;
COMMIT;
SELECT * FROM DEPT01;


-- 30부서 삭제 -> SAVEPOINT D30
DELETE FROM DEPT01 WHERE deptno=30;

SELECT * FROM DEPT01;

SAVEPOINT D30;


-- 20부서 삭제 -> SAVEPOINT D20
DELETE FROM DEPT01 WHERE deptno=20;

SELECT * FROM DEPT01;

SAVEPOINT D20;


-- 10부서 삭제 
DELETE FROM DEPT01 WHERE deptno=10;

SELECT * FROM DEPT01;


-- ROLLBACK;

ROLLBACK TO D20;

SELECT * FROM DEPT01;








































