<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<%@include file="/WEB-INF/views/common/header.jsp"%>

<h3>공지 작성</h3>



<form id="postForm" method="post">
	<input type="hidden" name="action" value="post"> <br> <b>공지</b>
	<input class="form-control" type="text" name="subject"> <br>

	<b>내용</b>
	<textarea class="form-control" name="content" style="height: 300px;"></textarea>
	<br>

	<button class="form-control list-group-item-warning mt-3" type="submit"
		type="submit" id="post">등록</button>
</form>

<script>
	// 등록 버튼 클릭 이벤트 처리
	document.querySelector('#post').addEventListener("click", function(e) {
		e.preventDefault();

		// form 요소 가져오기
		let form = document.querySelector("#postForm");

		form.setAttribute("action", '${root}/board?userId=${loginInfo.id}');

		// form 제출
		form.submit();
	});
</script>










</div>
</body>
</html>