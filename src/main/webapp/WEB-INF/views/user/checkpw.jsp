<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>


<c:set var="root" value="${pageContext.request.contextPath}" />

<div>
	<form id="checkForm" action="${root}/user" method="post">
		<input type="hidden" name="act" value="checkpass"> <label
			for="userpw" class="form-label"> 비밀번호 확인 : </label> <input
			type="password" class="form-control" id="userpw" name="userpw"
			placeholder="비밀번호를 입력하세요" /> <input type="submit" value="확인">
	</form>
</div>
</body>
</html>