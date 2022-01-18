use demo;
select * from emp;

desc emp;
-- insert into문 : 레코드 추가
-- 모든 필드의 정보가 있을 때
insert into emp values(7777, 'hong', '총무부', 7369, now(), 4000, 100, 40 );

-- 사원번호, 이름만 있을때
insert into emp(empno, ename)values (8888, 'park');
insert into emp(empno, ename, sal) values (9999, 'choi', 5000);

-- 테이블 복사
create table emp2 as
select empno, ename, job, sal
from emp
where job = 'MANAGER' ;
SELECT * FROM emp2;

-- EMP의 테이블에 있는 레코드선택중에 급여가 3000이상인 사원을 EMP2에 추가하라
insert into emp2(empno, ename, job, sal)
select empno, ename, job, sal
from emp where sal >=3000;

-- update : 테이블 안의 데이터를 수정한다.
update emp2 set job='인사부' where empno=9999;

-- ford 사원이  job을 기획부, 급여를 1000을 인상하라
update emp2 set job='기획부', sal=sal+1000 where ename = 'ford';

-- emp2의 모든 사원의 급여 10% 인상한 급여로 수정하라.
update emp2 set sal = sal + sal*0.1;

-- delete문 : 레코드 삭제
delete from emp2 where empno=7777;
SELECT * FROM emp2;

delete
from emp2
where job = '인사부';
SELECT *
FROM emp
order by ENAME;

-- 사원등록
insert into emp(empno, ENAME) values(1111, 'lee');
delete from emp where empno=8888;
delete from emp where ENAME='choi';


-- update, insert, delete의 레코드 변경된경우 작업을 완료하는 기능이다.
commit;

-- rollback : 변경사항 취소
delete from emp where ename='lee';
rollback ;

-- 회원 등록 : insert
-- 회원 수정 : update
-- 회원 탈퇴 : delete

savepoint a;
insert into emp(empno, ename) values (2222, 'aaaaa');
insert into emp(EMPNO, ENAME) values(3333, 'bbbbb');

savepoint b;
delete from emp where empno=1111;
delete from emp where job='salesman';

savepoint c;
update emp set comm=5000;

rollback to savepoint  b;

select *
from emp;

-- 현재 autocommit 상태확인
select @@autocommit;
set autocommit = 1;

