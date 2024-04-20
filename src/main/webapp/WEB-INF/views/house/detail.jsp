<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<% request.getAttribute("loginInfo"); %>




<div>
	<h3> 🏠${requestScope.houseDeal.get(0).apartmentName} </h3>
    <button type="button" id="aBtn" class="btn btn-primary">찜하기</button>
    <div id="buttonContainer"></div>
  
    <c:if test="${not empty loginInfo}">
    
        <script>
        var element = document.getElementById("aBtn");
    	console.log(element);
        element.setAttribute("onclick", "location.href= 'attention?act=addAttention&aptCode=${requestScope.houseDeal.get(0).aptCode}'"); // 원하는 링크 주소로 변경해주세요.
        fetch("attention?act=checkAtt&aptCode=${requestScope.houseDeal.get(0).aptCode}")
        .then((response)=>response.json())
        .then((data) => {
        	console.log("dfdf: " + data);
            if (data) {
            	console.log(data);
                var element = document.getElementById("aBtn");
                element.setAttribute("disabled","");
            }
        });
        

        </script>
    </c:if>
    
    <div id="sheetContainer">
    	
    </div>
    
</div>


<canvas id="myChart" width="400" height="200"></canvas>

<footer class="pt-4 my-md-5 pt-md-5 border-top">
    <p style="color: gainsboro">&copy; SM SH</p>
</footer>


<script>

	document.addEventListener("DOMContentLoaded", function() {
	    // 데이터 배열에서 가장 비싸게 팔린 거래와 가장 싸게 팔린 거래를 찾는 함수
	    function findExtremeDeals(dealDates, dealAmounts, dealFloors, isMax) {
	        var extremeDealIndex;
	        var extremeDealAmount;
	
	        if (isMax) {
	            extremeDealIndex = dealAmounts.indexOf(Math.max(...dealAmounts));
	            extremeDealAmount = "최고가 : ";
	        } else {
	            extremeDealIndex = dealAmounts.indexOf(Math.min(...dealAmounts));
	            extremeDealAmount = "최저가 : ";
	        }
	
	        return {
	            date: dealDates[extremeDealIndex],
	            amount: dealAmounts[extremeDealIndex],
	            floor: dealFloors[extremeDealIndex]
	        };
	    }
	
	    // 가장 비싸게 팔린 거래 정보 찾기
	    var maxDeal = findExtremeDeals(dealDates, dealAmounts, dealFloors, true);
	
	    // 가장 싸게 팔린 거래 정보 찾기
	    var minDeal = findExtremeDeals(dealDates, dealAmounts, dealFloors, false);
	
	    // 테이블에 출력할 데이터 배열
	    var tableData = [
	        { type: "최고가 ", date: maxDeal.date, amount: maxDeal.amount, floor: maxDeal.floor },
	        { type: "최저가", date: minDeal.date, amount: minDeal.amount, floor: minDeal.floor }
	    ];
	
	    // 테이블 생성 및 데이터 추가
	    var tableContainer = document.createElement("div");
	    tableContainer.id = "sheetContainer"; // 표를 감싸는 div에 id 추가
	    var table = document.createElement("table");
	    table.classList.add("table", "table-bordered", "mt-4");
	    var tableHeader = "<thead><tr><th>종류</th><th>날짜</th><th>가격</th><th>층수</th></tr></thead>";
	    var tableBody = "<tbody>";
	
	    // 데이터 배열을 순회하면서 테이블의 각 행에 데이터 추가
	    tableData.forEach(function(deal) {
	        tableBody += "<tr>";
	        tableBody += "<td>" + deal.type + "</td>";
	        tableBody += "<td>" + deal.date + "</td>";
	        tableBody += "<td>" + deal.amount + "</td>";
	        tableBody += "<td>" + deal.floor + "</td>";
	        tableBody += "</tr>";
	    });
	
	    tableBody += "</tbody>";
	    table.innerHTML = tableHeader + tableBody;
	    tableContainer.appendChild(table);
	
	    // 테이블을 페이지에 추가
	    var buttonContainer = document.getElementById("buttonContainer"); // 버튼 컨테이너 가져오기
	    buttonContainer.appendChild(tableContainer); // 버튼 컨테이너에 표 컨테이너 추가
	});


    
</script>


<script>
    // Extracting data for the chart
    var dealDates = [];
    var dealAmounts = [];
    var dealAreas = [];
    var dealPyungs = [];
    var dealFloors = []; // 층수 추가
    
    <c:forEach var="houseDetailDto" items="${requestScope.houseDeal}">
        dealDates.push("${houseDetailDto.dealDate}");
        dealAmounts.push(parseFloat("${houseDetailDto.dealAmount.replace(",", "")}"));
        dealAreas.push(parseFloat("${houseDetailDto.area}"));
        dealFloors.push("${houseDetailDto.floor}"); // 층수 추가
    </c:forEach>

    // 평수 변환
    dealAreas.forEach(function(area) {
        dealPyungs.push((area / 3.3058).toFixed(1));
    });
    console.log(dealPyungs.length);

    // Creating a chart
    var ctx = document.getElementById('myChart').getContext('2d');
    var chartOptions = {
        responsive: true,
        legend: {
            position: "top"
        },
        title: {
            display: true,
            text: "집값의 가격~"
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
   
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: dealDates,
            datasets: [{
                label: '거래금액(만원)',
                data: dealAmounts,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: chartOptions
    });
    
    // 그래프 생성
    document.addEventListener('DOMContentLoaded', function () {
        // 면적 값(평수)을 담을 배열
        var areas = [];
        
        // 중복 제거
        dealPyungs.forEach(function(area) {
            if (!areas.includes(area)) {
                areas.push(area);
            }
        })

        
        // 전체 데이터를 보여주는 버튼 생성
        var showAllButton = document.createElement("button");
        showAllButton.textContent = "전체 데이터";
        showAllButton.classList.add("btn", "btn-secondary", "mr-2", "mb-2");
        showAllButton.addEventListener("click", function() {
            showAllData();
        });
        
        // 버튼을 담을 div 요소 가져오기
        var buttonContainer = document.getElementById("buttonContainer");
        
        // 버튼 배열을 면적 값을 숫자로 변환하여 정렬
        areas.sort((a, b) => parseFloat(a) - parseFloat(b));
        
        // 전체 데이터 버튼을 맨 앞에 추가
        buttonContainer.appendChild(showAllButton);
        
        // 각 면적 값에 대해 버튼을 생성하여 버튼 컨테이너에 추가
        areas.forEach(function(area) {
            // 면적 값을 버튼으로 추가
            var button = document.createElement("button");
            button.textContent = area +'평';
            button.classList.add("btn", "btn-secondary", "mr-2", "mb-2");
            button.addEventListener("click", function() {
                filterByArea(area);
            });
            buttonContainer.appendChild(button);
        });
    });
    
    // 전체 데이터를 보여주는 함수
    function showAllData() {
        // 차트에 전체 데이터 표시
        myChart.data.labels = dealDates;
        myChart.data.datasets[0].data = dealAmounts;
        myChart.update();
    }

    // 면적을 클릭할 때 호출될 함수
    function filterByArea(area) {
        // 전체 데이터를 보관할 배열
        var filteredDealDates = [];
        var filteredDealAmounts = [];
        
        // 선택한 면적과 일치하는 데이터만 필터링
        for (var i = 0; i < dealPyungs.length; i++) {
            if (dealPyungs[i] === area) {

                filteredDealDates.push(dealDates[i]);
                filteredDealAmounts.push(dealAmounts[i]);
            }
        }
        
        // 차트 업데이트
        myChart.data.labels = filteredDealDates;
        myChart.data.datasets[0].data = filteredDealAmounts;
        myChart.update();
    }
    
    
</script>




