use demo;
desc emp2;
select * from emp2;

-- [실습] 사원테이블에서 scott의 급여보다 많은 사원의 사원번호, 이름, 업무, 급여를 출력하세요.**
select EMPNO, ENAME, JOB, SAL
from emp
where sal>(select sal from emp where ENAME='scott');

-- [문제1] 사원 테이블에서 사원명, 입사일, 담당업무, 부서코드를 선택하되 ‘ADAMS’와
-- 같은 업무를 하는 사원이거나 ‘SCOTT’과 같은 부서인 사원을 선택하라.**
select ENAME, HIREDATE, JOB, EMPNO from emp
where job = (select job from emp where ename='adams') or
                                       DEPTNO=(select DEPTNO from emp where ename = 'scott');

-- [문제2] 사원테이블에서 사원번호가 7521인 사원과 업무가 같고 급여가 7934인 사원보다
-- 많은 사원의 사번,이름,업무,입사일자,급여를 출력하세요.
select EMPNO, ENAME, JOB, HIREDATE, SAL
from emp
where job = (select job from emp where EMPNO = 7521) and sal>(select SAL from emp where EMPNO=7934);

-- [실습]사원테이블에서 급여의 평균보다 적은 사원의 사번, 이름, 업무, 급여, 부서번호를 선택하라.
select EMPNO, ENAME, JOB, SAL, DEPTNO from emp
where SAL<(select avg(SAL) from emp);


-- 테이블에 필드를 추가한다.
-- emp2 테이블에 연락처를 저장 할 필드 추가
alter table emp2 add tel varchar(15);

-- 필드의 크기를 수정하기
-- job을 varchar(20)으로 바꿔라
alter table emp2 modify job varchar(20);

desc emp2;

-- 컬럼 명 변경하기
-- tel -> mobile로 컬럼 명 변경하기
alter table emp2 change tel mobile varchar(20);

-- 필드 삭제하기
-- job을 삭재하기
alter table emp2 drop column job;

-- emp2 테이블 지우기
drop table emp2;

show tables;

commit;
select @@autocommit;

-- 제약조건 확인하기
select * from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME in ('emp', 'dept', 'salgrade');



-- unique : 유일한 값일 때
-- ename을 unique 제약조건 설정
alter table emp add constraint emp_uq_ename unique (ENAME);
insert into emp(empno, ename) values (8888, 'smith2');

-- 제약조건 삭제
alter table emp drop constraint emp_ck_sal;

-- 특정 데이터만 등록 되도록 제약 조건을 설정한다.
alter table emp add constraint emp_ck_sal check (sal>500 and sal<8000);
update emp set sal=7000 where ename='smith';
alter table emp add constraint emp_ck_comm check(comm in(100, 200, 300, 400));

update emp set comm=100;
update emp set comm=200 where sal>3000;
update emp set comm=500 where sal<2000;

-- primary key 설정
-- dept 테이블 deptno필드를 primary key 설정 하겠다.
alter table dept add constraint dept_pk_deptno primary key (DEPTNO);

insert into dept values (50, '총무부', '서울');

-- 외래키 설정
-- emp 테이블의 deptno는 dept 테이블의 deptno를 참조한다.

alter table emp add constraint emp_fk_deptno
foreign key (DEPTNO) references dept(DEPTNO);



update emp set DEPTNO=50 where ENAME='martin';
update emp set DEPTNO=35 where ename='jones';

delete from dept where DEPTNO=20;


-- 제약조건 삭제 후 재생성

alter table emp drop constraint emp_fk_deptno;
alter table emp add constraint emp_fk_deptno foreign key (DEPTNO)
references dept(deptno) on delete cascade ;

delete from dept where DEPTNO = 20;
select * from dept;
select * from emp;
select avg(sal) from emp;
select * from emp where sal>2006.66667;
select * from emp where sal>(select avg(sal) from emp);


-- emp 테이블 삭제 후 재생성
delete from emp;

alter table emp drop constraint emp_ck_sal;
alter table emp drop constraint emp_ck_comm;

insert into dept values (20, '인사부', '경기도');

INSERT INTO EMP VALUES(7369, 'SMITH',  'CLERK', 7902, '1980-12-17', 800, NULL, 20);
INSERT INTO EMP VALUES(7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600,  300, 30);
INSERT INTO EMP VALUES(7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250,  500, 30);
INSERT INTO EMP VALUES(7566, 'JONES',  'MANAGER',   7839, '1981-04-02',  2975, NULL, 20);
INSERT INTO EMP VALUES(7654, 'MARTIN', 'SALESMAN',  7698,'1981-09-28', 1250, 1400, 30);
INSERT INTO EMP VALUES(7698, 'BLAKE',  'MANAGER',   7839,'1981-05-01', 2850, NULL, 30);
INSERT INTO EMP VALUES(7782, 'CLARK',  'MANAGER',   7839,'1981-06-09', 2450, NULL, 10);
INSERT INTO EMP VALUES(7788, 'SCOTT',  'ANALYST',   7566, '1982-12-09', 3000, NULL, 20);
INSERT INTO EMP VALUES(7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP VALUES(7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08',  1500,    0, 30);
INSERT INTO EMP VALUES(7876, 'ADAMS',  'CLERK', 7788, '1983-01-12', 1100, NULL, 20);
INSERT INTO EMP VALUES(7900, 'JAMES',  'CLERK',     7698, '1981-12-03',   950, NULL, 30);
INSERT INTO EMP VALUES(7902, 'FORD',   'ANALYST',   7566, '1981-12-03',  3000, NULL, 20);
INSERT INTO EMP VALUES(7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300, NULL, 10);

select * from dept;
select * from emp;




use demo;
select * from emp;
-- 서브쿼리
select * from emp where sal>(select avg(sal) from emp);

-- emp 테이블의 급여 jones의 급여보다 많이 받는 사원중 급여가 30번인 사원을 선택하라.
select * from emp where sal>(select sal from emp where ENAME ='jones') and DEPTNO=20;

-- manager 업무를 하는 사원의 평균 급여보다 적게 받는 사원을 선택하라.
select * from emp where sal<(select avg(sal) from emp where job ='manager') ;

-- [문제1] 사원테이블에서 사원명, 입사일, 담당업무, 부서코드를 선택하되 'adams'와 같은 업무를 하는 사원이거나
-- 'scott'과 같은 부서인 사원을 선택하여라
select ename, HIREDATE, JOB, DEPTNO from emp
where job=(select JOB from emp where ENAME = 'adams')
or DEPTNO=(select DEPTNO from emp where ENAME="SCOTT");

-- [문제2] 사원테이블에서 사원번호가 7521인 사원과 업무가 같고
-- 급여가 7934인 사원보다 많은 사원의 사번, 이름, 업무 ,입사일자, 급여를 출력하세요.
select * from emp;
select EMPNO, ENAME, JOB, HIREDATE, sal from emp
where job=(select job from emp where EMPNO=7521)
and sal>(select sal from emp where EMPNO=7934);



-- [문제3]사원테이블에서 사원의 급여가 30번부서의 최소급여보다 많이 받는 부서를
-- 선택하라.
select deptno, min(sal) from emp group by deptno;

select DEPTNO, min(SAL)
from emp
group by DEPTNO
having min(sal) > (select min(SAL) from emp where DEPTNO=30);

-- [문제4] 사원테이블의 사원의 급여가 10번부서의 평균급여보다 많이 받는 업무를 하는 업무
-- 별 평균급여를 선택하라.
    select job, avg(sal) from emp group by job
    having avg(sal) > (select avg(sal) from emp where DEPTNO=10);

-- 다중 행 서브쿼리 5000, 3000, 2850
select max(sal) from emp group by DEPTNO;

 -- 부서별 최고 급여와 같은 급여를 받는 사원은
select ename, job, DEPTNO, sal
from emp
where sal in (select max(sal) from emp group by DEPTNO);

-- [문제5] 업무별로 최대 급여를 받는 사원과 같은 급여를 받는 사원의 사원번호와 이름, 업무, 급여을 출력하세요.
select EMPNO, ENAME, JOB, SAL
from emp
where sal in(select max(sal) from emp group by JOB);

-- [문제] 업무가 'SALESMAN'인 사원의 최소급여보다 많으면서
-- 부서번호가 20번이 아닌 사원의 이름과 급여, 부서코드를 출력하라.

select ename, sal, DEPTNO from emp
where DEPTNO!= 20
and SAL> any(select SAL from emp where JOB='SALESMAN');

select HIREDATE from emp where ENAME='king';
-- [문제] 사원테이블의 사원중 KING속한 부서의 사원보다 늦게 입사한 사원의 사원명, 업무, 급여, 입사일을 선택하라.
select ENAME, JOB, sal, HIREDATE from emp
where HIREDATE>any(select HIREDATE from emp
where DEPTNO= (select DEPTNO from emp where  ENAME='king'))

-- all : 모든 데이터가 만족하여야한다.
select * from emp
where sal>all(select sal from emp where JOB='salesman')
and DEPTNO!=20;

-- exists
select * from emp e
where exists(Select EMPNO from emp where e.EMPNO=mgr);

-- emp 테이블의 사원 중 사원명, 담당업무, 입사일, 급여를 선택하되
-- scott이 속한 부서의 평균 급여보다 많이 받는 사원과
-- manager 업무를 하는 사원을 선택하라.
-- 단, 사원명을 오름차순으로 정렬하여 출력

select ENAME, JOB, HIREDATE, SAL from emp
where sal>(select avg(sal) from emp
where DEPTNO=(select DEPTNO from emp where ENAME='scott'))
or job = 'manager' order by ename asc;

-- 30번 부서의 보너스를 받는 사원은?(급여, 부서코드)
select sal, DEPTNO from emp where DEPTNO=30 and comm is not null;
select * from emp where
(sal, DEPTNO) in (select  sal, DEPTNO from emp where DEPTNO=30 and comm is not null);

-- [문제]업무별로 최소 급여를 받는 사원의 사번, 이름, 업무, 부서번호를 출력하세요.
-- 단, 업무별로 정렬하세요.
select empno, ename, job, DEPTNO from emp
where (JOB, sal) in  (select JOB, min(sal) from emp group by JOB)
order by JOB asc ;

select job, min(sal) from emp group by job;

-- from 절에 서브쿼리문 사용하기
select * from (select EMPNO, ENAME, SAL, HIREDATE from emp) e;
select EMPNO, ENAME, SAL, HIREDATE from emp;

-- 사원번호 같은 값이 들어가나
insert into emp(empno, ename,DEPTNO) values (7788, 'abcd', 30);

select * from emp;

delete from emp where ename='abcd';

-- 제약조건 설정 : empno primary key
alter table emp add constraint emp_pk_empno
primary key (EMPNO);