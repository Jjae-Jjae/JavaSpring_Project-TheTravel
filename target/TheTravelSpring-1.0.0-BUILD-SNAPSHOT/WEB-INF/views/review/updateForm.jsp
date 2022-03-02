<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
<%-- ReviewUpdateForm.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 function msg() {
	alert("이미 작성하신 리뷰 입니다.\n삭제후 진행해 주세요");
	document.getElementById('updateForm').submit();
}
</script>
</head>
<body onload="msg()">
<form method="post" action="${ctxpath}/review/detail.do" id="updateForm">
  <input type="hidden" name="pageNum" value="${ pageNum}">
  <input type="hidden" name="review_id" value="${review_id }">
</form>
</body>
</html>