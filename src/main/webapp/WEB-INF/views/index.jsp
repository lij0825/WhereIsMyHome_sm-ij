<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="jakarta.tags.core"%> <% String root = request.getContextPath();
application.setAttribute("root", root); %>

<!DOCTYPE html>
<html lang="en">
  <head>
  
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors" />
    <meta CozyHouse="generator" content="Hugo 0.101.0" />
    <title>CozyHouse</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/pricing/" />
    <link href="./css/bootstrap.min.css" rel="stylesheet" />
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b41929528b8f4419b944de7d33f3211c&libraries=services"
    ></script>
    <!-- CDN 사용하는 경우 -->
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
      rel="stylesheet"
    />

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, 0.1);
        border: solid rgba(0, 0, 0, 0.15);
        border-width: 1px 0;
        box-shadow: inset 0 0.5em 1.5em rgba(0, 0, 0, 0.1),
          inset 0 0.125em 0.5em rgba(0, 0, 0, 0.15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -0.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      #keywordsearch-btn {
        margin-top: 15px;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
    </style>

    <link href="${root}/css/pricing.css" rel="stylesheet" />
  </head>
  <body>
  
    <div class="container py-3">
      <%@include file="common/header.jsp" %>
		
      <main>
        <!-- 셀렉트 박스 -->
        <h3>세부 검색</h3>
        <div class="d-flex select-boxes align-items-center">
          <!-- 시 -->
          <div class="form-floating">
            <select class="form-select" id="sido" aria-label="Floating label select example">
              <c:if test="${requestSession.sido}">
                <option selected>전체</option>
              </c:if>
              <option selected>전체</option>
            </select>
            <label for="floatingSelect">시 선택</label>
          </div>

          <!-- 구 -->
          <div class="form-floating">
            <select class="form-select" id="gugun" aria-label="Floating label select example">
              <option selected>전체</option>
            </select>
            <label for="floatingSelect">구 선택</label>
          </div>

          <!-- 동 -->
          <div class="form-floating">
            <select class="form-select" id="dong" aria-label="Floating label select example">
              <option selected>전체</option>
            </select>
            <label for="floatingSelect">동 선택</label>
          </div>

          <!-- 년도 -->
          <div class="form-floating">
            <select class="form-select" id="year" aria-label="Floating label select example">
              <option selected>전체</option>
            </select>
            <label for="floatingSelect">년도 선택</label>
          </div>

          <!-- 월 -->
          <div class="form-floating">
            <select class="form-select" id="month" aria-label="Floating label select example">
              <option value="all" selected>전체</option>
            </select>
            <label for="floatingSelect">월 선택</label>
          </div>

          <!-- 조회 버튼 -->
          <div class="d-flex align-item-center">
            <button id="aptBtn" class="btn btn-primary h-100"><i class="fas fa-search"></i></button>
          </div>
        </div>
      </main>
      <div style="display: flex; align-items: center; gap: 10px">
        <!-- 결과 조회 제목 -->
        <h3 id="resultTitle" class="mb-0">
          결과 조회
          <c:if test="${requestScope.resultSize != null && requestScope.resultSize != 0}">
            (${resultSize})
          </c:if>
        </h3>
        <!-- 정렬 선택 드롭다운 -->
        <div class="form-floating" style="width: 200px; margin-bottom: 0">
          <select class="form-select" id="sortOption" onchange="sortHouseDeals()">
            <option value="dealAmount">거래금액 순</option>
            <option value="name">이름(한글)순</option>
            <option value="area">전용 면적 순</option>
          </select>
          <label for="sortOption">정렬 기준</label>
        </div>
        <div class="form-floating" style="width: 200px; margin-bottom: 0">
          <select class="form-select" id="sortOrder" onchange="sortHouseDeals()">
            <option value="ascending">오름차순</option>
            <option value="descending">내림차순</option>
          </select>
          <label for="sortOption">오름 내림</label>
        </div>
      </div>
      <div
        class="d-flex justify-content-between"
        style="width: 1200px; height: 350px; margin: 20px auto"
      >
        <div id="description" style="width: 300px; height: 350px; overflow: scroll">
          <c:if test="${empty requestScope.houseDealList }"> No Result </c:if>

          <c:if test="${not empty requestScope.houseDealList }">
            <c:forEach var="houseDeal" items="${houseDealList }">
              <div class="card">
                <div class="card-body">
                  <script>
                    fetch("house?act=getAptName&aptCode=${houseDeal.aptCode}")
                    .then((response)=> response.json())
                    .then((data) => {
                    	let aptName = data.apartmentName;
                    	document.getElementById("aptName${houseDeal.no}").innerHTML=
                    		`<a href='${root}/house?act=detail&no=${houseDeal.aptCode}' class="text-decoration-none">`
                    			+aptName
                    	+`</a>`;

                                    makeMarker(data.lat, data.lng, data.apartmentName, ${houseDeal.no});

                                    fetch("attention?act=checkAtt&aptCode=${houseDeal.aptCode}")
                          			.then((response)=>response.json())
                          			.then((data) => {
                          				if (data) {
                          					document.getElementById("aptName${houseDeal.no}").innerHTML	+= `&nbsp <img src="https://cdn-icons-png.flaticon.com/512/4369/4369505.png" alt = "star" width="20px" height="20px" />`;
                          				}
                          			})

                    	});
                  </script>
                  <h5 id="aptName${houseDeal.no}" class="card-title d-flex align-items-center">
                    아파트 이름
                  </h5>
                  <p class="card-text">거래금액: ${houseDeal.dealAmount } (만원)</p>
                  <p class="card-text">전용면적: ${houseDeal.area } (m2)</p>
                </div>
              </div>
            </c:forEach>
          </c:if>
        </div>
        <div id="map" style="width: 500px; height: 350px; position: relative"></div>
        <div id="menu_wrap" class="bg_white" style="overflow: scroll; width: 300px; height: 350px">
          <div class="option">
            <div>
              <form onsubmit="searchPlaces(); return false;">
                <div class="d-flex justify-content-center align-items-center">
                  <label class="form-label"
                    ><b>키워드</b>
                    <input class="form-control" type="text" value="" id="keyword" size="15"
                  /></label>
                  <button
                    id="keywordsearch-btn"
                    class="btn"
                    type="submit"
                    style="width: 95px; height: 40px"
                  >
                    검색
                  </button>
                </div>
              </form>
            </div>
          </div>
          <hr />
          <ul id="placesList" class="list-group"></ul>
          <div class="page-item" id="pagination"></div>
        </div>
        <br />
      </div>
      <!-- 하단 바-->
      <footer class="pt-4 my-md-5 pt-md-5 border-top">
        <p style="color: gainsboro">CozyHouse SM & IJ</p>
      </footer>
    </div>
  </body>
  <!-- 셀렉트 박스 초기화 -->
  <script src="./js/main.js"></script>
  <!-- 맵 만들기 -->
  <script src="./js/searchDB.js"></script>
  <script src="js/mainMap.js"></script>

  <script>
    function quickSort(arr, compareFn) {
      if (arr.length <= 1) {
        return arr;
      }

      const pivotIndex = Math.floor(arr.length / 2);
      const pivot = arr[pivotIndex];
      const left = [];
      const right = [];

      for (let i = 0; i < arr.length; i++) {
        if (i === pivotIndex) {
          continue;
        }
        if (compareFn(arr[i], pivot) < 0) {
          left.push(arr[i]);
        } else {
          right.push(arr[i]);
        }
      }

      return [...quickSort(left, compareFn), pivot, ...quickSort(right, compareFn)];
    }

    function sortHouseDeals() {
      const sortOption = document.getElementById("sortOption").value;
      const sortOrder = document.getElementById("sortOrder").value;
      const container = document.getElementById("description");
      const houseDeals = Array.from(container.querySelectorAll(".card"));

      const compareFn = (a, b) => {
        let aValue, bValue;
        switch (sortOption) {
          case "name":
            // 아파트 이름으로 정렬
            aValue = a.querySelector(".card-title").textContent.trim();
            bValue = b.querySelector(".card-title").textContent.trim();

            if (sortOrder === "ascending") {
              return aValue.localeCompare(bValue);
            } else {
              return bValue.localeCompare(aValue);
            }
            break;
          case "dealAmount":
            // 거래금액으로 정렬
            aValue = parseInt(
              a
                .querySelector(".card-text")
                .textContent.replace(/거래금액: /, "")
                .replace(/ \(만원\)/, "")
                .replace(/,/g, "")
            );
            bValue = parseInt(
              b
                .querySelector(".card-text")
                .textContent.replace(/거래금액: /, "")
                .replace(/ \(만원\)/, "")
                .replace(/,/g, "")
            );
            break;
          case "area":
            // 전용 면적으로 정렬
            aValue = parseFloat(
              a
                .querySelectorAll(".card-text")[1]
                .textContent.replace(/전용면적: /, "")
                .replace(/ \(m2\)/, "")
            );
            bValue = parseFloat(
              b
                .querySelectorAll(".card-text")[1]
                .textContent.replace(/전용면적: /, "")
                .replace(/ \(m2\)/, "")
            );
            break;
        }

        if (sortOrder === "ascending") {
          return aValue - bValue;
        } else {
          return bValue - aValue;
        }
      };

      const sortedHouseDeals = quickSort(houseDeals, compareFn);

      // 정렬된 요소를 컨테이너에 다시 추가
      sortedHouseDeals.forEach((deal) => {
        container.appendChild(deal);
      });
    }

    init("${requestScope.year}", "${requestScope.month}");
    startmap("${sessionScope.loginInfo.address}");

    console.log("${requestScope.dongName}");
    //      searchPlaces("${dongName}");

    function searchPlaces() {
      var keyword = document.getElementById("keyword").value;

      if (keyword.replace(/^\s+|\s+$/g, "")) {
        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        console.log("${dongName}" + " " + keyword);
        ps.keywordSearch("${dongName}" + " " + keyword, placesSearchCB);
      }
    }
  </script>
</html>
