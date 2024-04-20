# 🏠 CozyHouse - 당신이 갖게 될 아늑한 집을 위해
# 📎목차
1. [기능 구현](#기능-구현)  
2. [알고리즘 적용](#1-유저-password-해쉬-암호화-추가)  
3. [데이터 베이스(ERD, 스키마, Usecase, DB dump, 뉴스 스크래핑 추가)](#1python을-이용한-부동산-관련-최신-기사-스크래핑)



## 🗒️ 프로젝트 요약
- 주택 실거래 공공데이터를 활용해 나에게 딱 맞는 집을 찾도록 도와주는 플랫폼
- 삼성 청년 SW 아카데미(SSAFY) 11기 1학기 Back-End 관통 프로젝트
- 사용 데이터 : OpenAPI 내 "국토교통부 아파트매매 실거래 상세 데이터" 등

<br>

## ✔️ 프로젝트 목표

<br>

📌 DataBase에 정규화를 적용, Database 모델링, ERD도출, 스키마 작성, 새로운 기능추가(스크래핑) 

<br>

## ✔️ 프로젝트 일정  

2024-04-05  

<br>

## ✔️ 팀원
- 11기 광주캠퍼스 Java 전공반 황성민
- 11기 광주캠퍼스 Java 전공반 이인준

<br>

## ✔️ 기술 스택 
<img src="https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=white">
<img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
<img src="https://img.shields.io/badge/python-3776AB?style=for-the-badge&logo=python&logoColor=white">


<br>
<br>
<br>

# 📋 전체 테이블 구조
![1.png](/resources/databaseERD/1.png)
![2.png](/resources/databaseERD/2.png)

### board 
---
![3.png](/resources/databaseERD/3.png)

### dongcode
---
![4.png](/resources/databaseERD/4.png)

### housedeal
---
![5.png](/resources/databaseERD/5.png)

### houseinfo
---
![6.png](/resources/databaseERD/6.png)

### uattention_table (찜 목록)
---
![7.png](/resources/databaseERD/7.png)

## userinfo 
![8.png](/resources/databaseERD/8.png)

<br>
<br>
<br>

# 💡 기능 구현 

# 기능 구현

## 1. 필수 기능

### 1.1 - 주택 실거래가 정보 수집
- SQL 파일을 적재하고 주택 실거래가 DTO, DAO를 활용한 데이터 전송
---
### 1.2 - 주택 실거래가 검색
- 행정동 및 날짜 기준으로 주택 실거래가 검색
- 검색결과는 Kakao Map API를 활용하여 지도에 Marker 찍고 면적, 거래금액 등 표시
- 검색 상세결과는 해당 주텍에 대한 자세한 정보를 볼 수 있게 함(심화 참조)
![01_주택 실거래가 검색](/resources/gif/01_주택_실거래가_검색.gif)
---

### 1.3 - 회원 관리
- 회원가입 기능 제공
![02_회원가입](/resources/gif/02_회원가입.gif)

- 회원정보 검색(마이페이지) 및 회원정보 수정, 삭제
![03_마이페이지_정보수정.gif](/resources/gif/03_마이페이지_정보수정.gif)

    
### 1.4 - 로그인 관리
- 로그인 및 로그아웃 기능
![04_로그인_로그아웃](/resources/gif/04_로그인_로그아웃.gif)

---
## 2. 추가 기능

### 2.1 - 주변 업종 정보 검색(카카오맵)
- Kakao Map API를 활용해 주택 근처 편의시설 검색 기능 제공
![05_키워드_주변_시설_검색](/resources/gif/05_키워드_주변_시설_검색.gif)

---
### 2.2 - 찜 기능
- 원하는 주택을 찜 해 놓는 기능 추가
- 찜한 목록을 마이페이지에서 볼 수 있도록 구현
- 찜 삭제 기능을 통해 마이페이지에서 찜 해 놓은 목록 삭제 가능
![06_찜기능](/resources/gif/06_찜기능.gif)
---
### 3. 심화 기능

### 3.1 -  공지사항 관리
- 공지사항 등록 등 기능 제공
![07_공지사항_공지작성](/resources/gif/07_공지사항_공지작성.gif)
---
### 3.2 상세페이지에 시세 정보 그래프 제공
- 상세보기를 선택한 주택의 지난 거래내역을 line-chart로 시각화
- m2를 평 수로 변환하여 더욱 쉽게 주택에 대해 정보를 알 수 있도록 함
- 평수별로 아파트 거래내역 그래프를 볼 수 있도록 기능 차별화
![08_심화_그래프_최고가_최저가.gif](/resources/gif/08_심화_그래프_최고가_최저가.gif)
---
  <br>
  <br>
  <br>

# 💡 알고리즘 적용 기획서 

### 1. 유저 password 해쉬 암호화 추가 

##### 적용 알고리즘 : HSA256

단방향 암호화 (One-Way Encryption) 방식인 해시 알고리즘(HSA256)을 사용하여 민감한 정보에 대해 보안을 강화한다. 
암호문을 가지고 평문으로 복구 하는 것이 불가능하다.  

단방향 암호화 알고리즘은 입력값의 길이가 달라도 출력값은 언제나 고정된 길이로 변환하며 동일한 값이 입력되면 언제나 동일한 출력값을 보장한다.  
---
##### 적용 서비스   
  
HSA256을 이용하여 민감한 정보를 암호문으로 바꿔 데이터를 저장하고 
암호문을 이용한 비교로 직접적인 사용자 정보를 사용하지 않아 보안을 강화한다. 

![10_2_해쉬암호](/uploads/06dca4ce202720a3f0ed215c3df9aea4/10_1_해쉬암호.gif)
---
##### 적용 서비스 구현 

![09_해시암호화_DB저장](/uploads/62065410072609e2ad0c3ed39291d2fb/09_해시암호화_DB저장.PNG)

![10_1_해시암호화JAVA구현](/uploads/a5235fe77b814c2946a20efbfbcbac78/10_해시암호화JAVA구현.PNG)
---
### 2. 검색 리스트 정렬

##### 적용 알고리즘 : Quick Sort

Quick Sort 알고리즘은 분할 정복(divide and conquer) 방법을 사용하여 리스트를 정렬하는 효율적인 알고리즘 중 하나입니다. 이 알고리즘은 다음과 같이 작동한다.

  
- 리스트 내에서 피벗(pivot) 요소를 선택한다. 피벗은 리스트의 한 요소로 선택되며, 이 피벗을 기준으로 리스트가 분할된다.
- 피벗을 기준으로 피벗보다 작은 요소들은 피벗의 왼쪽에, 큰 요소들은 피벗의 오른쪽에 배치한다.
- 피벗을 기준으로 분할된 두 하위 리스트에 대해 재귀적으로 위의 과정을 반복한다.
- 재귀 호출이 종료되면 각 하위 리스트는 정렬되어 있으므로, 합병을 통해 전체 리스트가 정렬된다.
- 추가적인 메모리를 사용하지 않고 시간 복잡도는 NLog(N)이다.
---
##### 적용 서비스 


사용자가 아파트 거래 정보를 상세 조회 하고 아파트 거래 정보를 오름차순, 내림차수 정렬(정렬 키 : 거래 금액, 이름, 면적)을 지원하여 사용자 편의를 제공한다. 

![11_5_퀵소트_검색목록정렬_이름_가격_면적](/uploads/18f07ae7df781c63669a4b771b65dcc8/11_5_퀵소트_검색목록정렬_이름_가격_면적.gif)
---
<br><br>

##### 적용 서비스 구현 

Quick Sort 로직 코드 



![11_1_퀵소트_자바스크립트코드](/uploads/223edb4ba3d4a3c25d728271bfe037de/11_1_퀵소트_자바스크립트코드.PNG)
---
- 아파트 이름별  

![11_2_퀵소트_아파트_이름별](/uploads/ec7fd274c284214fdc3434e449e18d14/11_2_퀵소트_아파트_이름별.PNG)
---

- 거래금액별  

![11_3_퀵소트_금액별](/uploads/f06e0730ee9c66807a3bcdc298679293/11_3_퀵소트_금액별.PNG)
---

- 면적별  

![11_4_퀵소트_면적별](/uploads/3a952e36b63313ebe1081398c5aa70f4/11_4_퀵소트_면적별.PNG)
---
### 3. 유효성 검사 

정규 표현식은 대개 백트래킹을 이용해서 일치 여부를 확인
이는 보통 정규식의 크기에 따라 최악의 경우에는 지수 시간 복잡도를 가짐

정규식을 사용하여 문제를 해결할 때에는 최악의 경우를 고려하면서 검증하고 해결하는 것이 가능
알고리즘 문제의 경우, 정규 표현식을 사용하여도 큰 문제(예: 시간 초과)가 발생하지 않는 경우가 많음

따라서 알고리즘 문제의 경우, 정규 표현식을 사용하여 빠르게 해결하는 것이 가능
어려운 문제가 아니라면 일반적으로 큰 문제가 발생하지 않음
---
<br>
- 입력값 유효성검사  

![12_1_유효성_검사](/uploads/5235166489962d1d5c94d0d031fae4f7/12_1_유효성_검사.png)
---

## 폼 유효성검사  

![12_2_폼_유효성_검사](/uploads/27ac343dec4c532b718697d161313750/12_2_폼_유효성_검사.png)

---
# 💡 데이터 베이스(ERD, 스키마, Usecase, DB dump, 뉴스 스크래핑 추가)

## 1.python을 이용한 부동산 관련 최신 기사 스크래핑




```
import pymysql
import requests
from bs4 import BeautifulSoup
```

### 사용 라이브러리   

- DB 연결 : pymysql 
- 웹 프로토콜(HTTP) : requests
- 스크래핑 : BS4 
- 스키마 : resources/Sql/news_Crawling.sql


---
### 소스 코드 

```
results = []


for page_num in range(1, 16):

    url = f'https://realestate.daum.net/news/all?page={page_num}'

    response = requests.get(url, verify = False)
    
    if response.status_code == 200:
        html = response.text
        soup = BeautifulSoup(html, 'html.parser')
    else : 
        print(response.status_code)
    
    ul_elements = soup.find_all('ul', class_ = "list_live")

    
    for ul in ul_elements:
        li_elements = ul.find_all('li')
        for li in li_elements:
    
            # 기사 제목 추출
            title = li.find('strong', class_='tit').text.strip()
            # 기사 URL 추출
            url = li.find('a', class_='link')['href']
            # 시간 추출
            time = li.find('span', class_='time').text.strip()
            
            # 기사 내용 추출
            content = li.find('p', class_='desc').text.strip()
                    
            # 내용 가공
            content = content.split(time)[0].strip().split("\n")[0]


            
            print("------------------------------------------------------------")
            print(f"제목 : {title}")
            print(f"url : {url}")
            print(f"내용 : {content}")
            print(f"시간 : {time}")

            results.append({"title" : title,
                        "url" : url,
                        "content" : content,
                        "time" : time})
```

![스크래핑_텍스트](/uploads/a8d764ad6848913a4f32a2c6e8bb2ff9/스크래핑_텍스트.PNG)


---

- 최신 기사 데이터베이스에 추가 

```
 conn = pymysql.connect(host='127.0.0.1', port=3306, user='ssafy', password='ssafy', db='ssafyhome', charset='utf8')

with conn.cursor() as cursor:
    for data in results:
    
        sql = """INSERT INTO news (subject, url, content, upload_date)
                 VALUES (%s, %s, %s, %s)"""
        
        cursor.execute(sql, (data['title'], data['url'], data['content'], data['time']))
    
    # 변경사항을 커밋하여 데이터베이스에 반영
    conn.commit()
    print("데이터가 성공적으로 삽입되었습니다.")
```





![뉴스_크로울링_데이터](/uploads/ffc8d2375edfe7175c1c651df9479e22/뉴스_크로울링_데이터.PNG)



---

<br>

## 유스케이스  

![Useclass_Diagram](/uploads/bda951b5750bf51abf634edad34d3520/Useclass_Diagram.png)





<br>

## ERD

![SSAFYHOME_ERD](/uploads/e8a55f4523ff3447abfe2b3efb0d50ee/SSAFYHOME_ERD.png)


- 사용자가 자주 이용하는 지하철역을 관심역으로 등록할 수 있도록 설계
- 사용자가 아파트 매물에 대해 글을 작성할 수 있도록 게시판 설계
- 매물 정보에 가까운 지하철역 컬럼 추가 



