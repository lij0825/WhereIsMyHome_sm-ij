
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common/header.jsp"%>


<a class="btn btn-primary" href="${root}/board/post.jsp">글쓰기</a>


<c:if test="${not empty sessionScope.loginInfo}">
</c:if>


<table class="table">
	<thead>
		<tr>
			<th scope="col">글번호</th>
			<th scope="col">글쓴이</th>
			<th scope="col">제목</th>
			<th scope="col">작성시간</th>
		</tr>
	</thead>
	<tbody>
		<tr>

			<c:forEach items="${list}" var="boardDto">
				<tr>
					<td>${boardDto.boardNo}</td>
					<td>${boardDto.userId}</td>
					<td><a
						href="${root}/board?action=view&post_no=${boardDto.boardNo}">${boardDto.subject}</a></td>
					<td>${boardDto.postDate}</td>
				</tr>
			</c:forEach>
		</tr>
	</tbody>
</table>


<%@include file="/WEB-INF/views/common/footer.jsp"%>

</div>
</body>

