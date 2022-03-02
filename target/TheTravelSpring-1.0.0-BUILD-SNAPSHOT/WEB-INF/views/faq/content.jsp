<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>   
 
<%--content.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>content.jsp</title>

<link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/style.css">


</head>
<body>

<div align="center">
<h2>글내용 보기</h2>
    <div class="inputForm">
      <table class="box">
		<tr>
			<td>글번호</td>
			<td>${fDto.num}</td>
		</tr>
		
		<tr>
			<td>분류</td>
			<td>${fDto.theme}</td>
		
		<tr>
			<td>조회수</td>
			<td>${fDto.readcount}</td>
		</tr>	
		
		<tr>
			<td>작성자</td>
			<td>${fDto.writer}</td>
		</tr>	
		
		<tr>
			<td>글제목</td>
			<td>${fDto.subject}</td>
		</tr>	
		
		<tr>
			<td>글내용</td>
			<td>${fDto.content}</td>
		</tr>	
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="글수정" onClick="location='${ctxpath}/faq/updateForm.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
				<input type="button" value="글삭제" onClick="location='${ctxpath}/faq/deleteForm.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
				<input type="button" value="글쓰기" onClick="location='${ctxpath}/faq/writeForm.do'">
				&nbsp; &nbsp;
				<input type="button" value="리스트" onClick="location='${ctxpath}/faq/list.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
			</td>
		</tr>	
		
		
		
		
	</table></div></div>
</body>
</html>