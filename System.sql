
-- 한줄 주석
-- 실행 : Cral + Enter

show user;

-- 전체 계정 확인
select * FROM all_users;

-- system 계정 : 사용자 계정 관리


-- system 계정 연결해서 scott계정 생성
-- create user 계정명 identified by 비밀번호;
CREATE USER scott IDENTIFIED by tiger;

-- 권한 부여 
grant CONNECT, RESOURCE, dba to scott;


-- 계정 삭제
-- DROP user 계정명
drop user scott;

-- 데이터가 있는 계정 삭제
drop user scott CASCADE;

-- 사용자 계정 비밀번호 변경
-- system 계정 연결
-- alter user 계정명 identified by 새비밀번호
alter user scott identified by tiger;















