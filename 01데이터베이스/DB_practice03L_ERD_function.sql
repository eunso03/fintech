use korea_stock_info;
show tables;
select * from stock_company_info;
select * from 2024_08_stock_price_info;

USE korea_exchange_rate;
show tables;
select count(*) from exchange_rate;

select * from exchange_rate where date>"2000-05-04";
select * from exchange_rate where date >= "2020-01-01" and date <= "2020-12-31";
select * from exchange_rate where date >= "2020-01-01" and date <= "2020-12-31" and 통화="유로 EUR";

# 2020년 1월 1일부터 12월 31일까지 데이터에서 통화별 현찰_살때_환율의 최소, 최대, 평균가
select 통화, MIN(현찰_살때_환율) 최저가, MAX(현찰_살때_환율) 최고가, round(AVG(현찰_살때_환율), 2) 평균가 from exchange_rate 
where date >= "2020-01-01" and date <= "2020-12-31" 
group by 통화;

use korea_stock_info;
show tables;

select * from 2024_08_stock_price_info;

# 7, 8, 9월로 나눠져 있는 데이터를 1개의 테이블로 모으기 위해서는 JOIN을 사용할 수 없으므로 UNION을 사용
SELECT * FROM 2024_07_stock_price_info
UNION ALL
SELECT * FROM 2024_08_stock_price_info
UNION ALL
SELECT * FROM 2024_09_stock_price_info;


# ===========================문자형 함수=========================== #
# SQL 함수
# SELECT 함수(값) / MIN(), MAX()

# 절대값 : ABS()
SELECT ABS(-34), ABS(1), ABS(25);

# 문자열의 길이 측정 : LENGTH(문자열);
SELECT LENGTH("my sql");  # 공백도 문자임

# 반올림 함수 : ROUND()
SELECT ROUND(3.14567, 2);
SELECT ROUND(3.14467, 2);

# 올림 CEIL, 내림 FLOOR
SELECT CEIL(4.1);
SELECT FLOOR(4.9);

# 연산자를 통한 계산 : +, -, *, /, %(나머지), DIV(몫), MOD(나머지)
SELECT 7/2;
SELECT 7*2;
SELECT 7+2;
SELECT 7-2;
SELECT 7%2;
SELECT 7 div 2;
SELECT 7 mod 2;

# POWER(제곱), SQRT(루트), SIGN(음수 양수 확인)
SELECT POWER(4,3);
SELECT SQRT(3);
SELECT SIGN(5), SIGN(-78);

# TRUNCATE(값, 자릿수) : 버림
SELECT ROUND(2.2345,3), TRUNCATE(2.2345,3);
SELECT ROUND(1153.2345,-2), TRUNCATE(1153.2345,-2);

# 문자열 함수
# 문자의 길이를 알아보는 함수 : CHAR_LENGTH
SELECT CHAR_LENGTH("my sql"), LENGTH("my sql");
SELECT CHAR_LENGTH("홍 길동"), LENGTH("홍 길동");  # LENGRH함수는 한글과 영어의 계산이 다름

# 문자를 연결하는 함수 : CONCAT(), CONCAT_WS()
SELECT CONCAT("this", "is", "mysql") as concat1;
SELECT CONCAT("  this", " is ", "mysql") as concat1;
SELECT CONCAT("  this", null, "mysql") as concat1;  # null이 있으면 결과도 nul
SELECT CONCAT_WS(" : ","this", " is ", "mysql") as concat1;
SELECT CONCAT_WS("  ","this", "is", "mysql") as concat1;
SELECT CONCAT_WS(" VS ","헐크", "아이언맨", "타노스") as concat1;

# 대문자를 소문자로 : LOWER(), 소문자를 대문자로 : UPPER()
SELECT LOWER("ABcd");
SELECT UPPER("efgh");

# 문자열의 자릿수를 일정하게 하고 빈 공간을 지정한 문자로 채우는 함수
# LPAD(값, 자릿수, 채울문자), RPAD(값, 자릿수, 채울문자)
SELECT LPAD("sql", 7, "#");
SELECT LPAD("sql", 7, " ");
SELECT LPAD("sql", 7, "=");

SELECT RPAD("sql", 7, "#");
SELECT RPAD("sql", 7, " ");
SELECT RPAD("sql", 7, "=");

# 공백을 없애는 함수 : LTRIM(문자열), RTRIM(문자열)
SELECT LTRIM("    SQL    ");
SELECT RTRIM("    SQL    ");

#문자열의 공백을 앞 뒤로 삭제하는 함수 : TRIM()
SELECT TRIM("    SQL    ");
SELECT TRIM("    MY SQL    ");  # 문자열 사이에 있는 공백은 그대로 남음
SELECT TRIM("    MY SQL STUDY    "); 

# 문자열을 잘라내는 함수 LEFT(믄자열, 길이), RIGHT(문자열, 길이)
SELECT LEFT("this is my sql", 4), RIGHT("this is my sql", 5);
SELECT LEFT("이것이 my sql이다.", 5), RIGHT("이것이 my sql이다.", 5);

# 문자열을 중간에서 잘라내는 함수 : substr(문자열, 시작위치, 길이)
SELECT SUBSTR("this is my sql", 6, 5);
SELECT SUBSTR("this is my sql", 6);

# 문자열의 공백을 앞 뒤로 삭제하고 문자열 앞 뒤에 포함된 특정 문자도 삭제하는 함수
# TRIM(leading "삭제할 문자" from 전체 문자열);
SELECT TRIM(leading "*" from "****my sql****");  # 앞만 지워줌
SELECT TRIM(trailing "*" from "****my sql****");  # 뒤만 지워줌
SELECT TRIM(both "*" from "****my sql****");  # 앞 뒤 모두 지워줌
SELECT TRIM(both "*" from "****my sql**!**");  # 앞 뒤 모두 지워줌


# ===========================날짜형 함수=========================== #
# 현재 년월일 : CURDATE
SELECT CURDATE();
# 현재 시간 : CURTIME
SELECT CURTIME();
# 현재 년월일 + 시간 : NOW, CURRENT_TIMESTAMP
SELECT NOW();
SELECT CURRENT_TIMESTAMP();

# 요일 표시 함수 : dayname(날짜)
SELECT DAYNAME(NOW());
SELECT DAYNAME("2025-05-05");

# 요일을 번호로 표시 : DAYOFWEEK(날짜) / 일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
SELECT DAYOFWEEK(NOW());
SELECT DAYOFWEEK("2024-05-05");

# 1년 중 오늘이 며칠쨰인지 : DAYOFYEAR(날짜)
SELECT DAYOFYEAR(NOW());
SELECT DAYOFYEAR("2025-05-08");

# 날짜를 세분화해서 보는 함수들
# 현재 달의 마지막 날이 몇 일까지 있는 지 출력
SELECT LAST_DAY(NOW());
SELECT LAST_DAY("2025-10-01");

# 입력한 날짜에서 연도만 추출 : YEAR
SELECT YEAR(NOW());
SELECT YEAR("2025-10-01");

# 입력한 날짜에서 월만 추출 : MONTH
SELECT MONTH(NOW());
SELECT MONTH("2025-10-01");

# 입력한 날짜에서 월만 영문으로 출력 : MONTHNAME
SELECT MONTHNAME("2025-10-01");

# 몇 분기인지 출력 : QUARTER
SELECT QUARTER(NOW());
SELECT QUARTER("2025-12-13");

# 몇 주차인지
SELECT WEEKOFYEAR(NOW());
SELECT WEEKOFYEAR("2025-12-25");

# 날짜와 시간이 같이 있는 데이터에서 날짜와 시간을 구분해주는 함수
SELECT NOW();
SELECT DATE(NOW());
SELECT TIME(NOW());

# 날짜를 지정한 날 수만큼 더하는 함수 DATE_ADD(날짜, interval 더할 날 수 day);
SELECT DATE_ADD(NOW(), interval 5 day);
SELECT ADDDATE(NOW(),5);

# 날짜를 지정한 날 수만큼 빼는 함수 SUBDATE(날짜, interval 뺄 날 수 day);
SELECT SUBDATE(NOW(), interval 5 day);
SELECT SUBDATE(NOW(),5);

# 날짜와 시간을 년월, 날 시간, 분초 단위로 추출하는 함수 : EXTRACT(옵션 from 날짜시간)
SELECT EXTRACT(year_month from now());
SELECT EXTRACT(day_hour from now()); # now()와 같이 쓰면 오류 -> 시간만 표시됨
SELECT EXTRACT(day_hour from "2025-02-27 17:40:37");
SELECT EXTRACT(minute_second from now());

# 날짜1에서 날짜2를 뺀 일 수 계산 : DATEDIFF(날짜1, 날짜2)
SELECT DATEDIFF(NOW(), "2024-12-25");

# 날짜 포맷 함수 - 지정한 형식에 맞춰서 출력해주는 함수 : DATE_FORMAT
# %Y(4자리 연도)
# %y(2자리 연도)
# %M(월의 영문표기)
# %m(2자리 월 표시)
# %b(월의 축약 영문표기) 
# %d(2자리 일 표기)
# %e(1자리 일 표기)
SELECT DATE_FORMAT(NOW(), "%d-%b-%Y");
SELECT DATE_FORMAT(NOW(), "%d-%M-%Y");
SELECT DATE_FORMAT(NOW(), "%e-%M-%Y");
SELECT DATE_FORMAT("2025-01-01", "%e-%M-%Y");
SELECT DATE_FORMAT("2025-01-01", "%d-%M-%Y");
SELECT DATE_FORMAT("2025-01-01", "%d-%m-%y");

# 시간 표기
# %H(24시간)
# %h(12시간)
# %p(AM, PM 표시)
# %i(2자리 분 표기)
# %S(2자리 초)
# %T(24시간 표기법 시:분:초)
# %r(12시간 표기법 시:분:초 AM/PM)
# %W(요일의 영문 표기)
# %w(숫자로 요일 표기) / 일(0), 월(1), 화(2), 수(3), 목(4), 금(5), 토(6)
SELECT DATE_FORMAT(NOW(), "%H:%I:%S");
SELECT DATE_FORMAT(NOW(), "%p %h:%I:%S");
SELECT DATE_FORMAT(NOW(), "%T");
SELECT DATE_FORMAT(NOW(), "%r");
SELECT DATE_FORMAT(NOW(), "%W %r");
SELECT DATE_FORMAT(NOW(), "%w %r");

# ============================================================ #

# 연습
USE korea_stock_info;
select 수집일 from stock_2024_all;

select 회사명, max(변화율), min(변화율) from stock_2024_all
group by 회사명;

select 회사명, 고가, 저가, (고가-저가) 가격차이 from stock_2024_all
group by 회사명;

select 회사명, 고가, 저가, (고가-저가) 가격차이 from stock_2024_all
group by 회사명
order by 가격차이 desc;
