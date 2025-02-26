USE titanic;
SHOW tables;

# 데이터 조회 명령 SELECT 컬럼명1, 컬럼명2, ... (*: 전부) FROM 테이블명;
SELECT * FROM p_info;

# 테이블에서 1개 컬럼만 조회할 때 컬럼명1 FROM 테이블명;
SELECT Name FROM p_info;

# 테이블에서 2개 컬럼만 조회할 때 컬럼명1, 컬럼명2 FROM 테이블명;
SELECT Name, Age FROM p_info;

# 데이블에 있는 컬럼 확인
DESC p_info;  # 테이블의 구조 확인

# 테이블에서 데이터를 10개만 조회하고 싶을 때 SELECT * FROM 테이블명 LIMIT 10
SELECT * FROM p_info LIMIT 10;

# 조건에 맞는 데이터 검색하기 WHERE + 비교연산자, 논리 연산자
# 성별이 남자인 경우만 조회하고 싶을 때 
SELECT * FROM p_info WHERE SEX="male";
SELECT * FROM p_info WHERE Sex!="male";  # 성별이 여자인 경우

# 나이가 40세 이상인 사람만 조회하고 싶을 때
SELECT * FROM p_info WHERE Age>=40;

# 조건을 2개 이상 줄 때 : 논리 연산자로 묶음(and, or)
SELECT * FROM p_info WHERE Sex="male" and Age<10; # 성별이 남성이고 나이가 10세 미만인 경우
SELECT * FROM p_info WHERE Sex="male" or Age<10;  # 성별이 남성이거나 나이가 10세 미만인 경우

# ===========================문제================================ #
# p_info 테이블에서 20살 이상 50세 미만의 여성을 조회하시오.
SELECT * FROM p_info WHERE (Age>=20 and Age<50) and Sex="female";

# p_info 테이블에서 SibSp가 1이거나 Parch가 1이상인 사람을 조회하시오.
SELECT * FROM p_info WHERE SibSp=1 or Parch>=1;

# t_info 테이블에서 Pclass가 1인 승객을 조회하시오.
DESC t_info;
SELECT * FROM t_info WHERE Pclass=1;

# t_info 테이블에서 Pclass가 2인 또는 Fare가 50초과인 승객을 조회하시오.
SELECT * FROM t_info WHERE Pclass=2 or Fare>50;

# survived 테이블에서 Survived가 1인 승객을 조회하시오.
SELECT * FROM survived WHERE Survived=1;
# ============================================================= #

# IN, NOT IN, LIKE, NOT LIKE, BETWEEN, IS NULL, IS NOT NULL
# p_info 테이블에서 SibSp 컬럼의 값이 1,2,3인 행을 찾으세요.
SELECT * FROM p_info WHERE SibSp=1 OR SibSp=2 OR SibSp=3;
SELECT * FROM p_info WHERE SibSp IN (1,2,3);

# p_info 테이블에서 SibSp 컬럼의 값이 0,1,2,3이 아닌 행을 찾으세요.
SELECT * FROM p_info WHERE SibSp NOT IN (0,1,2,3);

# LIKE : 문자열 안에서 특정 단어를 포함한 행을 찾을 떄
SELECT * FROM p_info WHERE Name LIKE "Rice, Master. Eugene";
SELECT * FROM p_info WHERE Name LIKE "Rice%";
SELECT * FROM p_info WHERE Name LIKE "%Eric";
SELECT * FROM p_info WHERE Name LIKE "%Oscar%";

# BTWEEN a and b : a 이상 b 이하를 찾을 때(이상, 이하만 가능)
# Age 컬럼의 값이 20이상 40이하인 값을 찾을 때
SELECT * FROM p_info WHERE Age>=20 and Age<=40;
SELECT * FROM p_info WHERE Age BETWEEN 20 AND 40;

# IS NULL, IS NOT NULL
# p_into 테이블에서 Age의 NULL값 찾기
SELECT * FROM p_info WHERE Age IS NULL;
SELECT * FROM p_info WHERE Age IS NOT NULL;

# ===========================문제================================ #
# t_info 테이블에서 Fare가 100 이상 1000이하인 승객을 조회하시오.
SELECT * FROM t_info WHERE Fare BETWEEN 100 AND 1000;

# t_info 테이블에서 Ticket이 PC로 시작하고 Embarked가 C 혹은 S인 승객을 조회하시오.
SELECT * FROM t_info WHERE Ticket LIKE "PC%" AND Embarked IN ("C","S");

# t_info 테이블에서 Pclass가 1 혹은 2인 승객을 조회하시오.
SELECT * FROM t_info WHERE Pclass IN (1,2);

# t_info 테이블에서 Cabin에 숫자 59가 포함된 승객을 조회하시오.
SELECT * FROM t_info WHERE Cabin LIKE "%59%";

# p_info 테이블에서 Age가 NULL이 아니면서 이름에 James가 포함된 40세 이상의 남성을 조회하시오.
SELECT * FROM p_info WHERE Age IS NOT NULL AND Name LIKE "%James%" AND Age>=40 AND Sex="male";
# ========================================================================================================#

# ORDER BY : 데이터의 순서 정렬하기
# SELECT * FROM 테이블명 WHERE 컬럼명 + 조건 ORDER BY 기준컬럼 ASC(오름) / DESC(내림)
# p_info 테이블에서 Age가 NULL이 아니면서 이름에 Miss가 포함된 40세 이하의 여성을 조회하고 나이를 기준으로 내림차순 정렬하시오.
SELECT * FROM p_info WHERE Age IS NOT NULL AND Name LIKE "%Miss%" AND Age<=40 AND Sex="female"
ORDER BY Age DESC;

# GROUP BY : 특정 칼럼을 기준으로 그룹 연산을 할 때 (평균, 최솟값, 최댓값, 행 갯수)
# 그룹 연산 함수 : AVG() - 평균, MIN() - 최솟값, MAX() - 최댓값, COUNT() - 행 갯수
#SELECT 기준 컬럼명, 그룹연산 함수 FROM 테이블명 WHERE 컬럼명 GROUP BY 기준컬럼
# p_info 테이블에서 나이가 NULL이 아닌 행의 성별별 나이 평균을 구하시오.
SELECT Sex,  AVG(Age) FROM p_info WHERE Age IS NOT NULL 
GROUP BY Sex;

# having : 그룹 연산 후의 결과에서 특정 조건을 충족하는 행을 찾고 싶을 때
# t_info 테이블에서 Pclass별 Fare 가격 평균을 구하고 그 중 가격 평균이 50을 초과하는 결과만 조회하시오.
SELECT Pclass, AVG(Fare) FROM t_info GROUP BY Pclass
HAVING AVG(Fare)>50;

# JOIN(INNER, LEFT, RIGHT, OUTER) *단, OUTER JOIN은 MYSQL에서 사용x
# INNER JOIN (교집합) : 왼쪽, 오른쪽에 있는 테이블에서 기준 컬럼의 값이 일치하는 것만 합침
# passenger 컬럼(왼족)과 ticket컬럼(오른쪽)을 INNER 조인 하시오.
SELECT * FROM passenger LIMIT 3;
SELECT * FROM ticket LIMIT 3;   # --> 두 테이블 확인 결과, PassengerId가 겹침 -> PassengerId가 기준컬럼이 됨

# SELECT * FROM 테이블1명(왼쪽) INNER JOIN 테이블2명(오른쪽) ON 테이블1명(왼쪽).기준컬럼명 = 테이블2명(오른쪽).기준컬럼명;
SELECT * FROM passenger INNER JOIN ticket ON passenger.PassengerId = ticket.PassengerId;

# LEFT JOIN 
SELECT * FROM passenger LEFT JOIN ticket ON passenger.PassengerId = ticket.PassengerId;

# RIGHT JOIN
SELECT * FROM passenger RIGHT JOIN ticket ON passenger.PassengerId = ticket.PassengerId;

# 두개의 테이블을 조인하면서 Name, Age, Pclass, Fare 컬럼만 보고 싶을 때
SELECT Name, Age, Pclass, Fare FROM passenger INNER JOIN ticket ON passenger.PassengerId = ticket.PassengerId;
SELECT PassengerId, Name, Age, Pclass, Fare FROM passenger INNER JOIN ticket ON passenger.PassengerId = ticket.PassengerId; # PassengerId 추가 -> 오류 : 어느 테이블의 PassengerId인 지 몰라서
SELECT passenger.PassengerId, Name, Age, Pclass, Fare FROM passenger INNER JOIN ticket ON passenger.PassengerId = ticket.PassengerId; # 오류 해결
SELECT ticket.PassengerId, Name, Age, Pclass, Fare FROM passenger INNER JOIN ticket ON passenger.PassengerId = ticket.PassengerId; # 오류 해결2

SELECT ticket.PassengerId, Name, Age, Pclass, Fare FROM passenger LEFT JOIN ticket ON passenger.PassengerId = ticket.PassengerId;
SELECT passenger.PassengerId, Name, Age, Pclass, Fare FROM passenger LEFT JOIN ticket ON passenger.PassengerId = ticket.PassengerId;

# 약칭, 별칭 : AS -> 생략 가능
SELECT * FROM passenger AS p LEFT JOIN ticket AS t ON p.PassengerId = t.PassengerId;
SELECT * FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId;

# 3개의 테이블을 1개로 합치기 : (테이블1 + 테이블2) + 테이블3
SELECT * FROM passenger p INNER JOIN ticket t ON p.PassengerId = t.PassengerId 
INNER JOIN survived s ON p.PassengerId = s.PassengerId;

# ===========================문제================================ #
# 1. passenger, ticket, survived 테이블을 조인하고 Survived가 1인 사람들만 찾아서 Name, Age, Sex, Pclass, survived 컬럼을 출력하시오.
SELECT Name, Age, Sex, Pclass, survived FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Survived=1;

# 2. 1의 결과를 10개만 출력하시오.
SELECT Name, Age, Sex, Pclass, survived FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Survived=1
LIMIT 10;

# 3.Passenger 테이블을 기준 ticket, survived테이블을 LEFT JOIN 한 결과에서 성별이 여성이면서 Pclass가 1인 사람 중 생존자(survived=1)를 찾아 이름, 성별, Pclass를 표시하시오.
SELECT Name, Sex, Pclass FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE (Sex="female" AND Pclass=1) AND survived=1;

# 4. passenger, ticket, survived 테이블을 left join 후 나이가 10세 이상 20세 이하 이면서 Pclass 2인 사람 중 생존자를 표시하시오.
SELECT * FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE ((Age BETWEEN 10 AND 20) AND Pclass=2) AND survived=1;

# 5. passenger, ticket, survived 테이블을 left join 후 성별이 여성 또는 Pclass 가 1인 사람 중 생존자를 표시하시오.
SELECT * FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE (Sex="female" OR Pclass=1) AND survived=1;

# 6.  passenger, ticket, survived 테이블을 left join 후 생존자 중에서 이름에 Mrs가 포함된 사람을 찾아 이름, Pclass, 나이, Parch, Survived 를 표시하시오.
SELECT Name, Pclass, Age, Parch, Survived FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE survived=1 AND Name LIKE "%Mrs%";

# 7. passenger, ticket, survived 테이블을 left join 후 Pclass가 1, 2이고 Embarked가 s, c 인 사람중에서 생존자를 찾아 이름, 성별, 나이를 표시하시오.
SELECT Name, Sex, Age FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE (Pclass IN (1,2) AND Embarked IN ("S","C")) AND survived=1;

# 8. passenger, ticket, survived 테이블을 left join 후 이름에 James가 들어간 사람중 생존자를 찾아 이름, 성별, 나이 를 표시하고 나이를 기준으로 내림차순 정렬하시오.
SELECT Name, Sex, Age FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId 
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Name LIKE "%James%" AND survived=1
ORDER BY Age DESC;

# 9. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서 성별별, 생존자의 숫자를 구하시오. 생존자 숫자 결과는 별칭을 Total로 하시오.
SELECT Sex, count(survived) Total FROM passenger p INNER JOIN ticket t ON p.PassengerId = t.PassengerId 
INNER JOIN survived s ON p.PassengerId = s.PassengerId
WHERE survived=1
GROUP BY Sex;

# 10. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서 성별별, 생존자의 숫자, 생존자 나이의 평균을 구하시오. 생존자 숫자 결과는 별칭을 Total로 하시오.
SELECT Sex, count(survived) Total, AVG(Age) FROM passenger p INNER JOIN ticket t ON p.PassengerId = t.PassengerId 
INNER JOIN survived s ON p.PassengerId = s.PassengerId
WHERE survived=1
GROUP BY Sex;

# 11. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서 성별별, pclass별, 생존자별로 sex, pclass, survived , survived의 클래스별 합계, 생존자/사망자의 나이 평균을 구하시오. 
# survived의 별칭은 is_survived로, 생존자 클래스별 합계는 별칭을 survived_total로, 생존자/사망자의 나이 평균은 별칭을 avg_age로 하시오.
SELECT Pclass, sex, survived AS is_survived, count(survived) survived_total, AVG(Age) avg_age FROM passenger p INNER JOIN ticket t ON p.PassengerId = t.PassengerId 
INNER JOIN survived s ON p.PassengerId = s.PassengerId
GROUP BY Sex, Pclass, survived
ORDER BY Sex, Pclass, survived;

