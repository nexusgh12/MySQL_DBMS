show databases;
use demo;
show tables;

select * from emp;
select * from dept;
select * from salgrade;

desc emp;
-- 사원수
select count(empno) from emp;
select count(comm) from emp;
select count(ename) from emp;
select max(sal), min(sal), avg(sal), sum(sal) from emp;
select * from emp;

-- 업무별 통계 
select job, count(empno), sum(sal), max(sal), avg(sal), min(sal)
from emp group by job;

-- 부서별 사원수, 급여합계, 급여평균을 구하여라
-- 그룹 함수를 사용하는 필드와 사용하지 않는 필드는 함께 표시할 수 없다.
-- 분류기준을 사용할 수 있다.
select deptno, count(ename), sum(sal), avg(sal) from emp group by deptno
order by deptno;

-- 중복 데이터 제거
select distinct job from emp;

-- 업무별 급여의 합계, 평균을 구하여 평균이 3000불 이상인 업무를 출력하라
select job, sum(sal), avg(sal) from emp
group by job
having avg(sal)>=3000;

-- 업무별 급여 평균과 보너스(comm)의 평균을 구하여라
select job, avg(sal), avg(comm) from emp group by job;
select sum(sal), avg(sal), avg(comm) from emp;
show databases;
-- null 데이터 계산에서 제외된다.
select sum(sal), avg(sal), sum(comm), avg(ifnull(comm, 0)) from emp;
select ename, sal, ifnull(comm, 0) from emp;
select * from emp where comm is not null;

-- 문제
-- 보너스를 받는 사원의 사원 수, 보너스 합, 보너스 평균을 구하라
select count(empno), sum(comm), avg(comm) from emp where comm>0;

-- 전체 월급이 5000을 초과하는 각 업무에 대해서 업무와 월 급여 합계를 출력하라.
-- 단 판매원은 제외하고 월 급여 합계로 내림차순 정렬하여라.

select job, sum(sal) from emp
where job != 'salesman'
group by job
having sum(sal)>5000
order by sum(sal) desc;

select count(comm), sum(comm), avg(comm) from emp;


select empno, ename, hiredate, sal from emp order by ename;