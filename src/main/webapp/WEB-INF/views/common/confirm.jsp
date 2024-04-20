<script>
	<c:if test="${not empty requestScope.msg}">
		alert("${msg}");
	</c:if>
</script>