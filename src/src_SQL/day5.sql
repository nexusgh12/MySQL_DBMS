
-- join
use demo;
select * from emp;
select * from dept;

-- 사원명(emp), 급여(emp), 부서코드(emp, dept), 부서명(dept)을 선택하라

-- 기본 방법
select ename, sal, deptno, dname from emp, dept
where emp.deptno = dept.deptno;                    -- error : deptno이 양쪽에 있다.

select ename, sal, emp.deptno, dname from emp, dept
where emp.deptno = dept.deptno;                    -- emp. 추가하면 된다.

select e.ename, e.sal, e.deptno, d.dname            -- 이렇게해도 출력이 된다. 앞에 별명을 추가하면 더 알아보기 쉽다.
from emp e, dept d                              -- 윗 줄에서 d.deptno 로 넣어도 같은 부속코드라 출력된다.
where e.deptno=d.deptno;                        -- 별명안지어주며 emp. / dept. 이렇게 써도 상관없다.

-- join문 (동등조인, 같은 데이터끼리 조인)
select ename, sal, emp.deptno, dname
from emp join dept
              on emp.deptno = dept.deptno;                     -- join 기준이되는 필드명을 쓰자 where대신 on임

-- 별명 넣기
select e.ename, e.sal, e.deptno, d.dname
from emp e join dept d
                on e.deptno = d.deptno;

--          emp            /   dept
-- [문제] 사원번호, 담당업무, 급여, 부서명, 부서위치를 선택하라.
-- 단, 30번 부서의 사원은 제외하고 급여는 10% 인상한 급여와 지급액(급여+보너스)를 출력하라.

select * from emp;
select * from dept;

-- 내가
select e.empno, e.job, e.sal , d.loc
from emp e join dept d
                on e.deptno = d.deptno;

-- 선생님이
select e.empno, e.job, e.sal, e.sal*1.1 '급여', e.sal+e.comm '지급액', d.dname, d.loc         -- 겹치는거 아니면 별명 생략가능
from emp e join dept d
                on e.deptno = d.deptno
where e.deptno!=30;                           -- 지급액이 null처리됌

-- 30번부서만 있기에 지급액=sal
select e.empno, e.job, e.sal, e.sal*1.1 '급여', e.sal+ifnull(e.comm,0) '지급액', d.dname, d.loc
from emp e join dept d
                on e.deptno = d.deptno
where e.deptno!=30;

-- 서브쿼리문 사용
select a.empno,  a.지급액 from
    (select e.empno, e.job, e.sal, e.sal*1.1 '급여', e.sal+ifnull(e.comm,0) '지급액', d.dname, d.loc
     from emp e join dept d
                     on e.deptno = d.deptno
     where e.deptno!=30) a;


-- Manager업무를 하는 사원의 평균급여보다 많이 받는 사원을 선택하는데
-- 사원번호, 사원명, 담당업무, 급여, 부서코드, 부서명을 사원명을 오름차순으로 정렬하여 선택하라.

select job, avg(sal) from emp group by job;

select e.empno, e.ename, e.job, e.sal, e.deptno, d.dname
from emp e join dept d
                on e.deptno = d.deptno
                    and sal>(select avg(sal) from emp where job='manager')         -- and/where 노상관 똑같음
order by ename asc;

-- salesman의 사원번호, 이름, 급여, 부서명, 근무지를 출력하여라
-- 내가 = 강사님
select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e join dept d
                on e.deptno = d.deptno
where e.job = 'salesman';


-- join (비동등)
show tables;
select * from salgrade;

-- 일반 쿼리사용
select e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

-- join 사용
select e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
from emp e join salgrade s
                on e.sal between s.losal and s.hisal;

-- emp 테이블에서 사원명, 급여, 호봉을 선택하되,
-- 담당업무가 Manager이거나 salesman인 사원 중 사원명에 A가 포함된 사원을 선택하라.
-- 내가
select e.ename, e.sal, s.grade
from emp e join salgrade s
                on ( e.job = 'manager' or e.job ='salesman' and e.ename ='%A%');

-- 선생님이
-- 1차
select e.ename, e.sal, s.grade
from emp e join salgrade s
                on e.sal between losal and hisal;

-- where절에 넣어보기
select e.ename, e.sal, s.grade
from emp e join salgrade s
                on e.sal between losal and hisal
where e.job in ('manager', 'salesman')               -- in이 이거나 연산자 in(a,b) a이거나 b
  and e.ename like '%a%';

-- and절에 넣어보기
select e.ename, e.sal, s.grade
from emp e join salgrade s
                on e.sal between losal and hisal
                    and e.job in ('manager', 'salesman')
                    and e.ename like '%a%';

-- table이 3개
-- 사원명(emp), 급여(sal), 부서코드(emp, dept), 부서명(dept), 호봉(salgrade)을 선택하라.
--                         d, e상관 X
-- 내가
select e.ename, e.sal, d.deptno, d.dname, s.grade
from emp e join (dept d, salgrade s)               -- ,로 하지말것..!!
                on e.deptno = d.deptno and e.sal between s.losal and s.hisal;

-- 강사님
select e.ename, e.sal, d.deptno, d.dname, s.grade
from emp e join dept d
                on e.deptno = d.deptno
           join salgrade s
                on e.sal between s.losal and s.hisal;

-- 사원번호, 사원명, 입사일, 급여, 부서명, 호봉, 호봉의 초고급여를 선택하라.
-- 단, 급여가 2500불 이상인 사원을 급여순으로 내림차순 선택하라.
select * from emp;
select * from dept;
select * from salgrade;

-- 내가
select e.empno, e.ename, e.hiredate, e.sal, d.dname, s.grade, s.hisal
from emp e join dept d
                on e.deptno = d.deptno
           join salgrade s
                on e.sal between s.losal and s.hisal
                    and e.sal >= 2500
order by sal desc;

-- 강사님
select e.empno, e.ename, e.hiredate, e.sal, d.dname, s.grade, s.hisal
from emp e join dept d
                on e.deptno = d.deptno
           join salgrade s
                on e.sal between losal and hisal
where e.sal >= 2500
order by e.sal desc;
