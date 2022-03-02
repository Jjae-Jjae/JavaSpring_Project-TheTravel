<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../module/jsp-header.jsp"%>
<%--list.jsp --%>
<fmt:requestEncoding value="UTF-8" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>qna list.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="${ctxpath}/resources/js/script.js"></script>

<link rel="stylesheet" type="text/css"
	href="${ctxpath}/resources/css/style.css">
</head>
<body>
	<h2><center>Q&A 목록(${pp2.cnt}개의 글이 있습니다)</center></h2>

	&nbsp;&nbsp;
	
	<div align="center">
    <div class="inputForm">
      <table class="box" style="width: 80%; text-align: center;"><tr><td>  
	
	&nbsp;&nbsp;
	
	<form name="searchForm" method="post" action="/TheTravelSpring/qna/list.do">
	<table style="width: 100%">
		<tr >
			<td align="left">
			검색어(제목 + 내용) :
			<input type="text" name="searchText" id="searchText" value="${searchText}" size="20"/>
			<input type="submit" value="검색">
			</td>
			<td align="right"><a href="${ctxpath}/qna/writeForm.do">글쓰기</a></td>
		</tr>	
	</table>
	</form>
	&nbsp;&nbsp;

	<c:if test="${pp2.cnt==0}">
	게시된 글이 없습니다
	</c:if>

	<c:if test="${pp2.cnt>0}">
		<table style="width: 100%">				
			<tr align="center" height="20">
				<td>글번호</td>
				<td>글제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
 
			 <c:set var="number" value="${cnt}"/>
	  		
			<c:forEach var="qDto" items="${list}">
				<c:if test="${qDto.re_level eq 0}">
					<tr><td colspan="5"><hr></td></tr>	 
				</c:if>		
				<tr align="center">
					<td>
					 
					<!-- 답글 -->
					 <c:if test="${qDto.re_level>0}">
						 
						<c:set var="number" value="${number}" />
						 	
					 </c:if>
				      
					<!-- 원글일때 -->
					
				    <c:if test="${qDto.re_level==0}">
					  	 <c:out value="${number}"/>
						
					</c:if>
					<c:set var="number" value="${number-1}" />
				
					</td>

					<td align="left">
						<!-- 답글 -->
						 <c:if test="${qDto.re_level>0}">
							<img src="${ctxpath}/resources/imgs/qna/level.gif" width="${5*qDto.re_level}" height="16">
							<img src="${ctxpath}/resources/imgs/qna/re.gif">
						 </c:if>
						 
						<!-- 원글일때 -->
						 <c:if test="${qDto.re_level==0}">
							<img src="${ctxpath}/resources/imgs/qna/level.gif" width="${5*qDto.re_level}" height="16">
						</c:if> <!-- 글 제목을 클릭하면 내용 보기로 가기 --> <a
						href="${ctxpath}/qna/content.do?num=${qDto.num}&pageNum=${pageNum}">${qDto.subject}</a>

					</td>

					<td>
					<!-- 답글 -->
						 <c:if test="${qDto.re_level>0}">
						 
						 </c:if>
					<!-- 원글일때 -->
						 <c:if test="${qDto.re_level==0}">
						${qDto.writer}<c:set var="writer" value="${writer}" />
						</c:if>
					</td>
					
					<td>
						${qDto.regdate}
					</td>
					<td>${qDto.readcount}</td>
				</tr>				
			</c:forEach>


		</table>
	</c:if>

	<%--블럭처리, 페이지처리 --%>
	<table style="width: 100%">
		<tr>
			<td><c:if test="${pp2.cnt>0}">

					<!-- 이전블럭 -->
					<c:if test="${pp2.startPage}>10">
						<a href="${ctxpath}/qna/list.do?pageNum=${pp2.startPage-10}">
							[이전블럭] </a>
					</c:if>

					<!-- 페이지 처리 -->
					<c:forEach var="i" begin="${pp2.startPage}" end="${pp2.endPage}">
						<a href="${ctxpath}/qna/list.do?pageNum=${i}"> [${i}] </a>
					</c:forEach>

					<!-- 다음 블럭 -->
					<c:if test="${pp2.endPage<pp2.pageCnt}">
						<a href="${ctxpath}/qna/list.do?pageNum=${pp2.startPage+10}">
							[다음블럭] </a>
					</c:if>
				</c:if>
	</table>
  </td></tr><table></div></div>
	
</body>
</html>