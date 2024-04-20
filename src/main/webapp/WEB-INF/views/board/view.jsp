<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<%@include file="/WEB-INF/views/common/header.jsp"%>

<h3>상세 공지</h3>



<form id="listForm" method="post">
	<input type="hidden" name="action" value="list"> <br> <b>공지</b>
	<input class="form-control" type="text" name="subject" readonly
		value="${boardDto.subject}"> <br> <b>내용</b>
	<textarea class="form-control" name="content" readonly
		style="height: 300px;">${boardDto.content}</textarea>
	<br>

	<button class="form-control list-group-item-warning mt-3" type="submit"
		type="submit" id="list">뒤로 가기</button>
</form>



<script>
	// 등록 버튼 클릭 이벤트 처리
	document.querySelector('#list').addEventListener("click", function(e) {
		e.preventDefault();

		// form 요소 가져오기
		let form = document.querySelector("#listForm");

		form.setAttribute("action", '${root}/board');

		// form 제출
		form.submit();
	});
</script>


</div>
</body>
</html>