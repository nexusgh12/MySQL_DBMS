create database mydb;
show databases ;
use mydb;
create table member(
    -- 필드명   데이터타입  제약조건 기본값check
    num int auto_increment primary key,
     username varchar(30) not null ,
     tel varchar(15) not null ,
     email varchar(50),
     birth date,
     gender char(1) default 'M',
     writedate datetime not null default now()
);

show tables ;
desc member;

-- 회원 등록
create table usertbl(
    userid varchar(30) primary key ,
    username varchar(30) not null ,
    birth year not null ,
    local varchar(50) not null ,
    mobile varchar(4),
    mobile2 varchar(10),
    height int(3),
    writetime datetime
);

show tables ;
desc usertbl;

-- 상품 테이블
create table protble(
    productname varchar(100) primary key,
    price int default 0,
    opendate datetime,
    company varchar(50),
    stock int default 0
);

show tables ;
desc protble;

-- 구매 테이블
create table buytbl
(
    buyno       integer auto_increment,
    userid      varchar(30) not null,
    productname varchar(50) not null,
    groupname   varchar(40) not null,
    price       int      default 0,
    amount      int      default 0,
    buydate     datetime default now(),
    primary key (buyno)
);



