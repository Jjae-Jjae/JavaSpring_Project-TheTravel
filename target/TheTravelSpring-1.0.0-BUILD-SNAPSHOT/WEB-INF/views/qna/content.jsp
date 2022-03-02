<%@page import="model.qna.QnaDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>   
 
<%--content.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/style.css">


</head>
<body>

<div align="center">
<h2>글내용 보기</h2>
    <div class="inputForm">
      <table class="box" style="width: 80%;">
		<tr>
			<td>글번호</td>
			<td>${qDto.num}</td>
		</tr>
		<tr><td colspan="3"><hr></td></tr>
		<tr>
			<td>조회수</td>
			<td>${qDto.readcount}</td>
		</tr>	
		<tr><td colspan="3"><hr></td></tr>
		<tr>
			<td>작성자</td>
			<td>${qDto.writer}</td>
		</tr>	
		<tr><td colspan="3"><hr></td></tr>
		<tr>
			<td>글제목</td>
			<td>${qDto.subject}</td>
		</tr>	
		<tr><td colspan="3"><hr></td></tr>
		<tr>
			<td>글내용</td>
			<td>${qDto.content}</td>
		</tr>
		<tr><td colspan="3"><hr></td></tr>
		<%--파일이 있을때 --%>
		<c:if test="${qDto.fileName ne null}">
		
			<tr>
				<td>첨부파일</td>
				
				<td><img src="fileDownload.do?fileName=${qDto.fileName}" width="200" height="200"></td>
				<td align="left"><a href="fileDownload.do?fileName=${qDto.fileName}">다운로드</a></td>
			</tr>
			
			</c:if>
			
			
						
		<tr>
			<td colspan="3" align="center">
				<input type="button" value="글수정" onClick="location='${ctxpath}/qna/updateForm.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
				<input type="button" value="글삭제" onClick="location='${ctxpath}/qna/deleteForm.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
				<input type="button" value="글쓰기" onClick="location='${ctxpath}/qna/writeForm.do'">
				<c:if test="${sessionScope.userLevel==1}">				
				&nbsp; &nbsp;
				<input type="button" value="답글쓰기" onClick="location='${ctxpath}/qna/writeForm.do?num=${num}&pageNum=${pageNum}&ref=${qDto.ref}&re_step=${qDto.re_step}&re_level=${qDto.re_level}'">
				</c:if>
				&nbsp; &nbsp;							
				<input type="button" value="리스트" onClick="location='${ctxpath}/qna/list.do?num=${num}&pageNum=${pageNum}'">
				&nbsp; &nbsp;
			</td>
		</tr>	
		
		
		
	<table></div></div>
</body>
</html>