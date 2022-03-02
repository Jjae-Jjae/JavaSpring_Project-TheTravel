<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../module/jsp-header.jsp" %>    
<%--content.jsp --%>

<%-- 임시 테스트 admin 처리 --%>
<%
session.setAttribute("userId", "admin");  
String userId = (String)session.getAttribute("userId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="../resources/css/notice/style.css">

</head>
<body>
<div align="center">
    <div class="inputForm">
      <table class="box card" style="width: 80%">  
      <tr>
      <td>
      <table  style="width: 80%">    
	<tr>
		<td align="left">
			<font size="+2">
			    <br>
				<strong>공지사항</strong>
			</font>
		</td>

		<!-- TODO : 수정, 삭제 관리자 권한 처리 -->	
		<td align="right">
			<input type="hidden" name="num" id="num" value="${num}">
			<input type="button" value="수정" onClick="location='${ctxpath}/notice/updateForm.do?num=${num}&pageNum=${pageNum}'">
			
			<%--관리자인 경우 --%>
			<c:if test="${'admin' eq sessionScope.userId }">	
				<input type="button" value="삭제" onClick="location='${ctxpath}/notice/delete.do?num=${num}&pageNum=${pageNum}'">
			</c:if>
			
			<input type="button" value="목록" onClick="location='${ctxpath}/notice/list.do?pageNum=${pageNum}'">
		</td>
	</tr>
</table>	

<table  style="width: 80%" align="center" cellpadding="5">
	<!-- [분류]제목 -->
	<tr height="50" bgcolor="#f2f2f2">
		<td colspan="2">
			<font size="+1" color="blue">
			<strong>[${dto.category}] ${dto.subject}</strong>
			</font>
		</td>
	</tr>
	
	<!-- 작성자, 작성일 -->
	<tr height="40" bgcolor="white">
		<td width="160"><font color="darkgrey"><strong>${dto.writer}</strong></font></td>
		<td><font size="-1">${dto.regdate}</font></td>
	</tr>
	
	<!-- 글내용 -->
	<tr bgcolor="#CCFFE5" height="200" valign="center">
		<td colspan="2">
			<pre>${dto.content}</pre>		
		</td>
	</tr>
	</table>
	</td>
	</tr>
	
</table>
</div>
</div>


</body>
</html>