USE korea_exchange_rate;

# 2020년 1월 1일부터 12월 31일까지 데이터에서 통화별 현찰_살때_환율의 최소, 최대, 평균가
select 통화, MIN(현찰_살때_환율) 최저가, MAX(현찰_살때_환율) 최고가, round(AVG(현찰_살때_환율), 2) 평균가 from exchange_rate 
where date >= "2020-01-01" and date <= "2020-12-31" 
group by 통화;

select 통화, MIN(현찰_살때_환율) 최저가, MAX(현찰_살때_환율) 최고가, ceil(round(AVG(현찰_살때_환율), 2)) 평균가 from exchange_rate 
where date >= "2020-01-01" and date <= "2020-12-31" 
group by 통화;

# 나머지 연산자(%)의 활용 : 짝수, 홀수 판단
select 7%2;
select 8%2;