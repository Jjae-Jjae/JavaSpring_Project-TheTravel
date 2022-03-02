<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
<%-- ReviewDeleteForm.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 function msg() {
	alert("리뷰가 삭제 되었습니다");
}
</script>
</head>
<body onload="msg()">

<meta http-equiv="Refresh" content="3;url=${ctxpath}/review/ReviewList.do?pageNum=${pageNum}&pro_no=${pro_no}">
</body>
</html>