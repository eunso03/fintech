import os
import requests
import time
import pandas as pd
from datetime import datetime
from bs4 import BeautifulSoup as bs
from sqlalchemy import create_engine, text
import pymysql
pymysql.install_as_MySQLdb()

company_infos = []
page = 1
while True:
    url = "https://kind.krx.co.kr/corpgeneral/corpList.do"
    payload = dict(method="searchCorpList", pageIndex=page, currentPageSize=100, 
                   orderMode=3, orderStat="D", searchType=13, fiscalYearEnd="all",
                   location="all")
    r = requests.post(url, data=payload)
    soup = bs(r.content, 'lxml')
    time.sleep(5)

    total_page = int(soup.select_one(".info.type-00 > em").text.replace(",", "")) // 100 + 1
    
    for idx, tr in enumerate(soup.select("tbody > tr")):
        print(f"{page}/{total_page}중, {idx}/{len(soup.select('tbody > tr'))} 작업 중", end="\r")
        stock_type = tr.select_one("td:nth-child(1) > img")['alt']
        company_name = tr.select_one("td:nth-child(1) > a")['title']
        stock_code = tr.select_one("td:nth-child(1) > a")['onclick'].split("'")[1]
        business_type = tr.select_one("td:nth-child(2)").text
        product = tr.select_one("td:nth-child(3)").text
        resi_date = tr.select_one("td:nth-child(4)").text
        settlement = tr.select_one("td:nth-child(5)").text
        ceo = tr.select_one("td:nth-child(6)").text
        homepage = tr.select_one("td:nth-child(7) > a")['href'] if tr.select_one("td:nth-child(7) > a") != None else ""
        region = tr.select_one("td:nth-child(8)").text
        company_infos.append((stock_type, company_name, stock_code, business_type, 
                             product, resi_date, settlement, ceo, homepage, region))
    
    if page < total_page:
        page += 1
    else:
        break
    
columns = soup.select_one("table")['summary'].split(", ")
columns.insert(0, "주식종목")
columns.insert(2, "종목코드")
print(columns)
df = pd.DataFrame(company_infos, columns=columns)
df

today = datetime.now()
today = f"{today.year}_{today.month:02d}_{today.day:02d}"

if not os.path.exists("./scraping_results"):
    os.mkdir("scraping_results")

df.to_csv(f"./scraping_results/상장기업정보_{today}기준.csv", encoding='utf-8', index=False)
print(f"./scraping_results/상장기업정보_{today}기준.csv 저장완료!")

engine = create_engine("mysql+pymysql://root:1234@127.0.0.1:3306")
with engine.connect() as conn:
    conn.execute(text("CREATE DATABASE IF NOT EXISTS korean_stock"))

engine = create_engine("mysql+pymysql://root:1234@127.0.0.1:3306/korean_stock")
conn = engine.connect()

df.to_sql("company_info", con=conn, if_exists="replace", index=False)
print("company_info 데이터베이스 저장완료!")
conn.close()