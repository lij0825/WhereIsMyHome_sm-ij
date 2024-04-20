<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Modify Information</title>
  </head>
  <body>
    <%@include file="/WEB-INF/views/common/header.jsp"%>
    <form id="modifyForm" action="" method="post">
      <input type="hidden" name="act" value="modify" />
      <input type="hidden" name="userId" value="${sessionScope.loginInfo.id}" />
      <table style="width: 550px; height: 400px">
        <tr>
          <td><b>이름</b></td>
          <td>${sessionScope.loginInfo.name}</td>
        </tr>
        <tr>
          <td><b>아이디</b></td>
          <td>${sessionScope.loginInfo.id}</td>
        </tr>

        <tr>
          <td><b>기존 주소</b></td>
          <td>${sessionScope.loginInfo.address}</td>
        </tr>

        <tr>
          <td><b>주소 변경</b></td>
          <td>
            <div class="d-flex align-items-center justify-content-center">
              <input
                class="form-control"
                type="text"
                id="sample4_postcode"
                placeholder="우편번호"
              />
              &nbsp; &nbsp;
              <input
                class="btn btn-secondary"
                type="button"
                onclick="sample4_execDaumPostcode()"
                value="우편번호 찾기"
              />
            </div>
            <input
              class="form-control"
              type="text"
              id="sample4_roadAddress"
              placeholder="도로명주소"
              name="address"
              value="${sessionScope.loginInfo.address }"
              style="width: 313px"
            />
            <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소" />
            <span id="guide" style="color: #999; display: none"></span>
          </td>
        </tr>

        <tr>
          <td><b>비밀번호 변경</b></td>
          <td>
            <input
              class="form-control"
              type="password"
              name="userpw"
              value="${sessionScope.loginInfo.pw}"
            />
          </td>
        </tr>

        <tr>
          <td><b>비밀번호 확인</b></td>
          <td><input class="form-control" type="password" name="userpwCheck" /></td>
        </tr>
      </table>

      <input id="modifyUser" , type="submit" value="수정완료" />
      <input id="delUser" type="submit" value="회원탈퇴" />
    </form>

    <script>
      // 수정완료 버튼 클릭 이벤트 핸들러
      document.querySelector("#modifyUser").addEventListener("click", function (event) {
        // 액션 변경
        document.querySelector("#modifyForm").action = "${root}/user?act=modify";
      });

      // 회원탈퇴 버튼 클릭 이벤트 핸들러
      document.querySelector("#delUser").addEventListener("click", function (event) {
        // 액션 변경
        document.querySelector("#modifyForm").action = "${root}/user?act=delete";
      });
    </script>
  </body>

  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var roadAddr = data.roadAddress; // 도로명 주소 변수
          var extraRoadAddr = ""; // 참고 항목 변수

          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
            extraRoadAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if (data.buildingName !== "" && data.apartment === "Y") {
            extraRoadAddr += extraRoadAddr !== "" ? ", " + data.buildingName : data.buildingName;
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if (extraRoadAddr !== "") {
            extraRoadAddr = " (" + extraRoadAddr + ")";
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample4_postcode").value = data.zonecode;
          document.getElementById("sample4_roadAddress").value = roadAddr;
          document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

          /*
                        // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                        if (roadAddr !== '') {
                            document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                        } else {
                            document.getElementById("sample4_extraAddress").value = '';
                        }*/

          var guideTextBox = document.getElementById("guide");
          // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
          if (data.autoRoadAddress) {
            var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
            guideTextBox.innerHTML = "(예상 도로명 주소 : " + expRoadAddr + ")";
            guideTextBox.style.display = "block";
          } else if (data.autoJibunAddress) {
            var expJibunAddr = data.autoJibunAddress;
            guideTextBox.innerHTML = "(예상 지번 주소 : " + expJibunAddr + ")";
            guideTextBox.style.display = "block";
          } else {
            guideTextBox.innerHTML = "";
            guideTextBox.style.display = "none";
          }
          console.log(this);
        },
      }).open({
        autoClose: true,
        //기본값 true
      });
    }
  </script>
</html>
