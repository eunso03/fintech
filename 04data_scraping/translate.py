def ko2eng(keyword):
    """
    구글 번역기에 한국어 넣고 영어로 번역 후
    번역결과 가져오는 함수
    """
    from selenium import webdriver
    from selenium.webdriver.chrome.service import Service
    from selenium.webdriver.chrome.options import Options
    from webdriver_manager.chrome import ChromeDriverManager
    from selenium.webdriver.common.by import By
    from selenium.webdriver.common.keys import Keys
    from book_dbio import to_book_db

    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC

    options = Options()
    options.add_experimental_option("detach", True)
    options.add_argument("start-maximized")
    options.add_argument("Chrome/135.0.0.0")
    options.add_argument("lang=ko_KR")
    options.add_argument("--headless")  
    options.add_argument("--no-sandbox")  

    driver = webdriver.Chrome(
        service=Service(ChromeDriverManager().install()),
        options=options
        )

    url = "https://translate.google.co.kr/?h1=ko&tab=TT&sl=ko&tl=en&op=translate"
    driver.get(url)

    wait = WebDriverWait(driver, 10)
    kor_text_box = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div > textarea")))
    kor_text_box.send_keys(keyword)
    kor_text_box.send_keys(Keys.ENTER)
    translated_box = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.lRu31 span.")))

    return translated_box.text
 