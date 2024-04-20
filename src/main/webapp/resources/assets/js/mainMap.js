let btnShow = document.getElementById("list-btn");
var searchResult = [];
var positions = [];
// 마커를 담을 배열입니다
var markers = [];
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
var ps = new kakao.maps.services.Places();


var mapContainer = document.getElementById("map"); // 지도를 표시할 div
mapOption = {
  center: new kakao.maps.LatLng(36.355116, 127.298372), // 지도의 중심좌표
  level: 5, // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption);


function startmap(userAddress){
        console.log(userAddress);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(userAddress, function(result, status) {

            // 정상적으로 검색이 완료됐으면
             if (status === kakao.maps.services.Status.OK) {

                 
                 var imageSrc = 'https://user-images.githubusercontent.com/51085309/192584836-dd00266b-450f-4731-8468-a288c0842f6b.png', // 마커이미지의 주소입니다    
                    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                      
                // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
                 
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords,
                    image: markerImage
                    
                });


                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
                
                // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
                var iwContent = '<div style="width:150px; text-align:center; padding:6px 0;">우리집</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                	
                // 인포윈도우를 생성합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content : iwContent
                });

                // 마커에 마우스오버 이벤트를 등록합니다
                kakao.maps.event.addListener(marker, 'mouseover', function() {
                  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
                    infowindow.open(map, marker);
                });

                // 마커에 마우스아웃 이벤트를 등록합니다
                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                    infowindow.close();
                });
            } 
        });
        
        

        
}

function makeMarker(lat, lng, content, dealno){
    
    // 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(lat, lng); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition,
        clickable:true
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
    map.setCenter(markerPosition);

    
    
    // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
       var iwContent = `<div style="padding:5px;">${content}</div>`; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

       // 인포윈도우를 생성합니다
       var infowindow = new kakao.maps.InfoWindow({
           content : iwContent
       });

       // 마커에 마우스오버 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseover', function() {
         // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
           infowindow.open(map, marker);
       });

       // 마커에 마우스아웃 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseout', function() {
           // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
           infowindow.close();
       });
       
       kakao.maps.event.addListener(marker, 'click', function() {
    	      // 마커 위에 인포윈도우를 표시합니다
    	      location.href = `house?act=detail&no=${dealno}`;
    	});
    
}


function detailMarker(lat, lng, content){
	
	var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
	var ps = new kakao.maps.services.Places();


	var mapContainer = document.getElementById("map"); // 지도를 표시할 div
	mapOption = {
	  center: new kakao.maps.LatLng(36.355116, 127.298372), // 지도의 중심좌표
	  level: 5, // 지도의 확대 레벨
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);
    // 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(lat, lng); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition,
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
//    map.setCenter(markerPosition);

    
    
    // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
       var iwContent = `<div style="padding:5px;">${content}</div>`; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

       // 인포윈도우를 생성합니다
       var infowindow = new kakao.maps.InfoWindow({
           content : iwContent
       });

       // 마커에 마우스오버 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseover', function() {
         // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
           infowindow.open(map, marker);
       });

       // 마커에 마우스아웃 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseout', function() {
           // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
           infowindow.close();
       });
       
    
}





    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert("검색 결과가 존재하지 않습니다.");
        return;
      } else if (status === kakao.maps.services.Status.ERROR) {
        alert("검색 결과 중 오류가 발생했습니다.");
        return;
      }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {
      var listEl = document.getElementById("placesList"),
        menuEl = document.getElementById("menu_wrap"),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds(),
        listStr = "";

      // 검색 결과 목록에 추가된 항목들을 제거합니다
      removeAllChildNods(listEl);

      // 지도에 표시되고 있는 마커를 제거합니다
      removeMarker();

      for (var i = 0; i < places.length; i++) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
          marker = addMarker(placePosition, i),
          itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function (marker, title) {
          kakao.maps.event.addListener(marker, "mouseover", function () {
            displayInfowindow(marker, title);
          });

          kakao.maps.event.addListener(marker, "mouseout", function () {
            infowindow.close();
          });

          itemEl.onmouseover = function () {
            displayInfowindow(marker, title);
          };

          itemEl.onmouseout = function () {
            infowindow.close();
          };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
      }

      // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;

      // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
      map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {
      var el = document.createElement("li"),
        itemStr =
          '<span class="list-group-item list-group-item-dark" >' +
          (index + 1) +
          '</span>' +
          '<div class="list-group-item">' +
          "   <h5>" +
          places.place_name +
          "</h5>";

      if (places.road_address_name) {
        itemStr +=
          "    <span class='list-group-item'>" +
          places.road_address_name +
          "</span>" +
          '   <span class="list-group-item">' +
          places.address_name +
          "</span>";
      } else {
        itemStr += "    <span>" + places.address_name + "</span>";
      }

      itemStr += '  <span class="list-group-item">' + places.phone + "</span>" + "</div>";

      el.innerHTML = itemStr;
      el.className = "item";

      return el;
    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커
                                                                                                        // 이미지
                                                                                                        // url,
                                                                                                        // 스프라이트
                                                                                                        // 이미지를
                                                                                                        // 씁니다
        imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
        imgOptions = {
          spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
          spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할
                                                                // 영역의 좌상단 좌표
          offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
          position: position, // 마커의 위치
          image: markerImage,
        });

      marker.setMap(map); // 지도 위에 마커를 표출합니다
      markers.push(marker); // 배열에 생성된 마커를 추가합니다

      return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
      }
      markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
      var paginationEl = document.getElementById("pagination"),
        fragment = document.createDocumentFragment(),
        i;

      // 기존에 추가된 페이지번호를 삭제합니다
      while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
      }

      for (i = 1; i <= pagination.last; i++) {
        var el = document.createElement("a");
        el.href = "#";
        el.innerHTML = i;

        if (i === pagination.current) {
          el.className = "on";
        } else {
          el.onclick = (function (i) {
            return function () {
              pagination.gotoPage(i);
            };
          })(i);
        }

        fragment.appendChild(el);
      }
      paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
      var content = '<div style="padding:5px;z-index:1;">' + title + "</div>";

      infowindow.setContent(content);
      infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
      while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
      }
    }
