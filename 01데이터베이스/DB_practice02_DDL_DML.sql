# 데이터베이스, 테이블 만들기
CREATE DATABASE sampleDB;
DROP DATABASE sampleDB;  # 데이터베이스 삭제

# 데이터베이스 조회하기
SHOW DATABASES;

# 테이블 만들기
# CREATE TABLE 테이블명(컬럼명1 데이터타입,컬럼명2 데이터타입, ...);
USE sampledb;
CREATE TABLE customers(id int, name varchar(100), sex varchar(20), phone varchar(20), address varchar(255));

# 테이블 삭제하기 *참고) 데이터 삭제는 delete
DROP TABLE customers;

# market_db 만들기
CREATE DATABASE market_db;
USE market_db;

# hongong1 테이블 만들기 / toy_id(int), toy_name(char(4)), age(int)
CREATE TABLE hongong1 (toy_id int, toy_name char(4), age int);
SHOW TABLES;
DESC hongong1;

# 생성한 테이블에 데이터 입력하기 INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) VALUES (1, "우디", 25);
INSERT INTO hongong1(toy_id, toy_name, age) VALUES (1, "우디", 25);

SELECT * FROM hongong1;

INSERT INTO hongong1(toy_id, toy_name) VALUES (2, "버즈");

INSERT INTO hongong1(toy_name, age, toy_id) VALUES ("제시", 20, 3);
INSERT INTO hongong1 VALUES (5, "포테이토", 40);
INSERT INTO hongong1 VALUES (6, "강아지"); # 오류

# primary key와 auto increment 기능을 추가한 테이블 만들기
CREATE TABLE hongong2 (
	toy_id int AUTO_INCREMENT PRIMARY KEY,
    toy_name char(4),
    age int);
    
DESC hongong2;

# AUTO INCREMENT가 지정된 테이블에 데이터 넣기
INSERT INTO hongong2 VALUES (NULL, "보핍", 25);
INSERT INTO hongong2 VALUES (NULL, "슬링키", 22);
INSERT INTO hongong2 VALUES (NULL, "렉스", 21);

SELECT * FROM hongong2;

# 테이블 수정하기 : ALTER
# 컬럼 추가  ALTER TABLE 테이블명 ADD COLUMN 컬럼명, 자료형, 속성(NOT NULL, UNIQUE)
# hongong2 테이블에 country 컬럼 추가하기
ALTER TABLE hongong2 ADD COLUMN country VARCHAR(100);

# 기존 테이블에 있는 자료 UPDATE 하기 / WHERE와 함께 씀
# UPDATE 테이블명 SET 컬럼명 = 업데이트할 값 WHERE toy_id=1;
UPDATE hongong2 SET country = "미국" WHERE toy_id=1;
UPDATE hongong2 SET age = 30 WHERE toy_id=1;

# 테이블의 내용은 모두 지우고 테이블의 구조는 남기고 싶을 때 : TRUNCATE
TRUNCATE TABLE hongong2;

# 테이블의 데이터 삭제 DELETE FROM 테이블명 WHERE 조건
DELETE FROM hongong1 WHERE toy_id=2;
DELETE FROM hongong1 WHERE idx=2;

# idx 컬럼추가 primary key로 지전 AUTO_INCREMENT
ALTER TABLE hongong1 ADD COLUMN idx int AUTO_INCREMENT PRIMARY KEY;
SELECT * FROM hongong1;

DELETE FROM hongong1 WHERE idx=2;

INSERT INTO hongong1 VALUES (7, "렉스", 30, NULL);

# CREATE, INSERT, UPDATE, DELETE (CRUD)

# ===============================문제================================= #
# 회원테이블, 제품테이블 만들기
CREATE TABLE member (
	id int AUTO_INCREMENT PRIMARY KEY,
    member_id varchar(20),
    name varchar(20),
    address varchar(255)
    );

INSERT INTO member
VALUES (NULL, "tess", "나훈아", "경기 부천시 중동"),
	(NULL, "hero", "임영웅", "서울 은평구 증산동"),
    (NULL, "iyou", "아이유", "인천 남구 주안동"),
    (NULL, "jyp", "박진영", "경기 고양시 장항동");  

SELECT * FROM member;

CREATE TABLE product (
	prod_name varchar(100),
    price int,
    date_of_prod varchar(20),
    manuf varchar(50),
    balance int
    );

INSERT INTO product
VALUES ("바나나", 1500, "2024-07-01", "델몬트", 17),
	("카스", 2500, "2023-12-12", "OB", 3),
    ("삼각김밥", 1000, "2025-02-26", "CJ", 22);  

SELECT * FROM product;

# product 테이블에 prod_id 컬럼을 추가하고 AUTO_INCREMENT, PRIMARY KEY를 추가하시오.
ALTER TABLE product ADD COLUMN prod_id int AUTO_INCREMENT PRIMARY KEY;

DESC member;
INSERT INTO member (id, member_id,name) VALUES(NULL, "akmu", "악동뮤지션");

# ============================================================================= #

# ROLLBACK 연습
CREATE DATABASE mywork;
USE mywork;
CREATE TABLE emp_test
(emp_no int not null, 
emp_name varchar(30) not null,
hire_date date null,
salary int null,
primary key(emp_no));

DESC emp_test;

INSERT INTO emp_test
(emp_no, emp_name, hire_date, salary)
VALUES
(1005, "쿼리", "2021-03-01", 4000),
(1006, "호킹", "2021-03-05", 5000),
(1007, "패러데이", "2021-04-01", 2200),
(1008, "맥스웰", "2021-04-04", 3300),
(1009, "플랑크", "2021-04-05", 4400);

SELECT * FROM emp_test;

# UPDATE 연습
# 호킹의 salary를 10000으로 변경
# 패러데이의 hire_date를 2023-07-11로 변경
# 플랑크가 있는 데이터를 삭제
UPDATE emp_test SET salary=10000 WHERE emp_no=1006;
UPDATE emp_test SET hire_date="2023-07-11" WHERE emp_no=1007;
DELETE FROM emp_test WHERE emp_no=1009;

SELECT * FROM emp_test;

# 오토커밋 옵션 활성화 확인
SELECT @@autocommit;  # 결과가 1 : 오토커밋 활성화, 0 : 오토커밋 활성화x
SET autocommit=0; # 오토커밋 비활성화

CREATE TABLE emp_tran1 as SELECT * FROM emp_test;
SELECT * FROM emp_tran1;
DESC emp_tran1;  # primary key가 복제 안됨
DESC emp_test;

ALTER TABLE emp_tran1 add constraint primary key(emp_no);
drop table emp_tran1;
show tables;
rollback;

select * from emp_test;
insert into emp_test values(1009, "플랑크", "2024-04-04", 5030);
rollback;

# ROLLBACK 연습
select * from emp_test;
insert into emp_test values(10011, "플랑크4", "2024-04-05", 5000);
insert into emp_test values(10012, "플랑크5", "2024-04-05", 5000);
insert into emp_test values(10013, "플랑크6", "2024-04-05", 5000);
commit;
rollback;