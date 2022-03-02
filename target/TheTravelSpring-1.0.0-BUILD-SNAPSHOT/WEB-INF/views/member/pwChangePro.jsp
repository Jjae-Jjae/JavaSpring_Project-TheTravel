<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>

<body onload="alert('암호변경이 완료되었습니다\n다시 로그인 해주세요')">
 <c:remove var="userId" scope="session"/><!-- 세션무효화  -->
<meta http-equiv="refresh" content="0; url=${ctxpath}/member/login.do">
</body>