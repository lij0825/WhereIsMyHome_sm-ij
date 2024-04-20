<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>

<h3>내 정보</h3>
<table boarder="1">
	<tr>
		<td>이름 :</td>
		<td>${sessionScope.loginInfo.name}</td>
	</tr>
	<tr>
		<td>아이디 :</td>
		<td>${sessionScope.loginInfo.id}</td>
	</tr>
	<tr>
		<td>주소 :</td>
		<td>${sessionScope.loginInfo.address}</td>
	</tr>

</table>


<a href="user/checkpw.jsp">[정보 수정하기]</a>
<br>
<h3>찜 목록</h3>
<ul id="list-group" class="list-group">
	<script>
	<c:forEach items="${requestScope.attList}" var="aptCode">
	console.log("${aptCode}");
		 fetch("house?act=getAptName&aptCode=${aptCode}")
		 .then((response)=> response.json())
		 .then((data) =>  {
			 document.getElementById("list-group").innerHTML += `<li id="${aptCode}" class="list-group-item d-flex justify-content-between"></li>` ;
			 document.getElementById("${aptCode}").innerHTML += data.apartmentName;

			 document.getElementById("${aptCode}").innerHTML += `<button id="btn${aptCode}" onclick='deleteA("${aptCode}")' type="button" class="btn btn-danger">찜 삭제</button>`;
			 document.getElementById("btn${aptCode}").addEventListener("click",function() {
				 location.href="attention?act=delete&aptCode=${aptCode}";

			 })
		 });
		 </c:forEach>
		 function deleteA(aptCode) {
			 location.href="attention?act=delete&aptCode="+aptCode;
		 }
	</script>
</ul>

</div>
