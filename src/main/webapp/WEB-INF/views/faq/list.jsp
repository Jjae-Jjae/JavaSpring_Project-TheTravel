<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp"%>
<%--list.jsp --%>
<fmt:requestEncoding value="UTF-8" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>faq list.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="${ctxpath}/resources/js/script.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/style.css">
</head>
<body>
<div align="center">
    <div class="inputForm">
      <table class="box"><tr><td>  
	<h2><center>자주 물어보시는 질문 (${pp2.cnt}개의 글이 있습니다)</center></h2>
	
	&nbsp;&nbsp;

	&nbsp;&nbsp;
	
	<!-- 검색 form -->
	
<form name="searchForm" method="post" action="/TheTravelSpring/faq/list.do">
	<table style="width: 100%;" >
		<tr>
			<td align="left">
				분류 : 
				<select name="category" id="category">				
					<option value="">전체</option>
					<option value="해외여행">해외여행</option>
					<option value="국내여행">국내여행</option>
					<option value="결제">결제</option>
					<option value="계정">계정</option>
					<option value="기타">기타</option>
			</select>
			검색어 :
			<input type="text" name="searchText" id="searchText" value="${searchText}" size="20"/>
			<input type="submit" value="검색">
			</td>
			<td align="left">
			  <c:if test="${sessionScope.userLevel==1}">		
	 			<a href="${ctxpath}/faq/writeForm.do">글쓰기</a>
			  </c:if>
			</td>
		</tr>	
	</table>
	</form>
	&nbsp;&nbsp;
      <table class="box" style="width: 100%;">
		<tr>
			<td colspan="6" align="center">
			테마별로 보기
			</td>
		<tr align="center">
			<td><a href="${ctxpath}/faq/list.do">전체</a></td>
			<td><a href="${ctxpath}/faq/list.do?category=해외여행&searchText=">해외여행 관련</a></td>
			<td><a href="${ctxpath}/faq/list.do?category=국내여행&searchText=">국내여행 관련</a></td>
			<td><a href="${ctxpath}/faq/list.do?category=결제&searchText=">결제 관련</a></td>
			<td><a href="${ctxpath}/faq/list.do?category=계정&searchText=">계정 관련</a></td>
			<td><a href="${ctxpath}/faq/list.do?category=기타&searchText=">기타 관련</a></td>			
		</tr>
	</table>	
	<br>
	<br>
	<br>
	<c:if test="${pp2.cnt==0}">
	FAQ가 없습니다
	</c:if>
	<c:if test="${pp2.cnt>0}">
	
		<table class="box" style="width: 100%;">
			<tr height="20" align="center">
				<td>글번호</td>
				<td>분류</td>
				<td>FAQ제목</td>				
				<td>작성일</td>
				<td>조회수</td>
			</tr>

            <c:set var="number" value="1"/>
            
			<c:forEach var="fDto" items="${list}">
				<tr height="30" align="center">
					<td>
					<c:out value="${number}"/>
					<c:set var="number" value="${number+1}" />
					</td>

					<td>${fDto.theme}</td>
					
					<td>						
						<!-- 글 제목을 클릭하면 내용 보기로 가기 -->
						<a href="${ctxpath}/faq/content.do?num=${fDto.num}&pageNum=${pageNum}">${fDto.subject}</a>
						
					</td>
	
					<td>
						${fDto.regdate}
					</td>
					<td>${fDto.readcount}</td>
				</tr>
			</c:forEach>
			
			
		</table>
	</c:if>
	<br>
	<%--블럭처리, 페이지처리 --%>
	<table style="width: 100%;">
	<tr><td align="center">
	<c:if test="${pp2.cnt>0}">	
		
		<!-- 이전블럭 -->
		<c:if test="${pp2.startPage}>10">
			<a href="${ctxpath}/faq/list.do?pageNum=${pp2.startPage-10}">
			[이전블럭]
			</a>
		</c:if>
		
		<!-- 페이지 처리 -->
		<c:forEach var="i" begin="${pp2.startPage}" end="${pp2.endPage}">
			<a href="${ctxpath}/faq/list.do?pageNum=${i}">
			[${i}]
			</a>
		</c:forEach>
		
		<!-- 다음 블럭 -->
		<c:if test="${pp2.endPage<pp2.pageCnt}">
			<a href="${ctxpath}/faq/list.do?pageNum=${pp2.startPage+10}">
			[다음블럭]
			</a>
		</c:if>
	</c:if>
	</table>	
	
	 </td></tr></table></div></div>
</body>
</html>