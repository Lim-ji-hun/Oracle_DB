/* 08_트랜잭션.sql */

/*
# 트랜잭션(transaction)
- 데이터베이스 내에서 하나의 그룹을 처리되어야 하는 명령문들을 모아 놓은 작업 단위
- 여러개의 명령어의 집합이 정상적으로 처리되면 정상 종료하도록 하고, 
  여러개의 명령어 중에서 하나의 명령이라도 잘 못 되었다면 전체를 취소해버림
*/

/*
#트랜잭션 명령어
- COMMIT
  ROLLBACK
  SAVEPOINT
*/

/*
# COMMIT
- 모든 작업을 정상적으로 처리하겠다고 확정하는 명력어
- 트랜잭션의 처리과정을 게이터베이스에 반영하기 위해서 변경된 내용을 모두 영구 저장함
- COMMIT을 수행하면 하나의 트랜잭션 과정을 완료하게 됨
*/

/*
ROLLBACK
- 작업중 문제가 발생했을때 트랜잭션의 처리과정에서 발생한 변경사항을 취소하고
  트랜잭션 과정을 종료
- 이전 COMMIT 한 곳까지만 복구됨
*/

DROP TABLE DEPT01 PURGE;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;

--DEPT01 테이블 내용 삭제
DELETE FROM DEPT01;

SELECT * FROM DEPT01;

-- ROLLBACK 을 수행하여 데이터 복구
ROLLBACK;
SELECT * FROM DEPT01;

-- 부서번호 20번 삭제
DELETE FROM DEPT01
WHERE DEPTNO=20;

SELECT * FROM DEPT01;

-- 데이터 삭제한 결과를 영구 저장하기 위해 commit 수행
COMMIT;
SELECT * FROM DEPT01;

ROLLBACK;
SELECT * FROM DEPT01;











