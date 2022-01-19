show databases ;
use employees;
show tables;

-- 절댓값 계산
select abs(-100);
select abs(emp_no - 400000 ) '절대치' from employees;

-- 올림
select ceil(10.1), ceil(-10.1), floor(10.9), floor(-10.9);
select round(192.123, 2), round(192.123, -2), round(192.123, 0);

-- 진수 변환
SELECT CONV(100, 10, 2);

-- 문자 내장함수
select ascii('A') NAME;
select char(65) Name;
select BIT_LENGTH('가나다'), char_length('가나다'), length('가나다');

-- CONCAT 문자열을 이을 때 사용
select concat(first_name, last_name)from employees;
select concat('김', '길동', '이다'), concat_ws(',', '홍길동', '김길동', '최길동');
select concat_ws(', ')

-- ELT(n, 문자열, 문자열) : n번째 문자열을 반환
select elt(2, 'a', 'b', 'c');### 3.  CONCAT(char1, char2, ..)

-- field(찾을 문자열, 문자열, 문자열) : 찾을 문자열의 위치를 찾아서 있으면 위치를, 없으면 0을 반환
select field('b', 'a', 'b', 'c');
select find_in_set('b', 'a,b,c');

-- 기준 문자열에서 부분문자열을 찾아서 그 시작 위치를 반환
select instr('abcd', 'b');
select locate('b', 'abcd');

select insert('가나다라마', 2, 3, '@@@');
select reverse('가나다라마');

select lcase('aBcDe');
select ucase('aBcDe');

select substring('abcdef', 3, 2) name;
select substring_index('jaehoney.tistory.com', '.', 2);
select substring_index('jaehoney.tistory.com', '.', -2);

select substring(first_name, 1,char_length(first_name)*0.5) from employees;

select lpad('jung-sick', 10, '*') name;
select rpad('jung-sick', 10, '*') name;

select rpad(substring(first_name, 1, char_length(first_name)*0.5), char_length(first_name), '*') from employees;
select first_name from employees;

select repeat('abc', 3);

SELECT REPLACE ('JACK and JUE', 'J', 'BL') "Changes";
SELECT REPLACE ('JACK and JUE', 'JA', 'BL') "Changes";
SELECT REPLACE ('JACK and JUE', 'j', 'BL') "Changes";

select ltrim('   abc');
select rtrim('abc  ');
select trim(' abc ');

select trim(both 'a' from 'aababaa')"TRIM Example";

select substring_index('nexusgh12@gmail.com', '@', 1), substring_index('nexusgh12@gmail.com', '@', -1);

