<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../module/jsp-header.jsp" %>    
<fmt:requestEncoding value="UTF-8"/>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/notice/style.css">

<script type="text/javascript">

function listReload(){
	$('#searchText').val('');
	document.searchForm.category.options[0].selected = "selected";
	document.searchForm.submit();	//전송
}

function init(){
	//분류 콤보박스 : 화면로드 시 서버에서 받아온 값으로 선택해준다. 	
	paramVal = "${sdto.category}";
	
	optCount = document.searchForm.category.options.length;
	
	for(i=0; i < optCount; i++) {
		optVal = document.searchForm.category.options[i].value;
	
		if(paramVal == optVal){ //파라미터 값과 같으면 select 처리
			document.searchForm.category.options[i].selected = "selected";
		}
	}
}
</script>

</head>
<body onLoad="init()">

<form name="searchForm" method="post" action="${ctxpath}/notice/list.do">
<c:set var="searchText" value="${sdto.searchText}"/>
<c:set var="category" value="${sdto.category}"/>
<div align="center">
    <div class="inputForm">
      <table class="box" style="width: 80%">
      <tr><td>
      <table style="width: 80%">      
	<tr>
		<td align="left">
			<font size="+2">
			    <br>
				<strong>공지사항</strong><font size="-1">&nbsp;&nbsp;(전체글: ${cnt}) </font>
			</font>
		</td>

		<td align="right">
					
			<%--관리자인 경우 --%>
			<c:if test="${'admin' eq sessionScope.userId }">				
				<a href="${ctxpath}/notice/writeForm.do">공지사항  추가</a>	
			</c:if>
			&nbsp;&nbsp;
			<a href="javascript:listReload()">새로고침</a>						
		</td>				
	</tr>

	<tr>
		<td colspan="2" align="right">
			분류 :
			<select name="category" id="category">
				<option value="" selected>전체</option>
				<option value="국제선">국제선</option>
				<option value="국내선">국내선</option>
				<option value="패키지">패키지</option>
				<option value="자유여행">자유여행</option>
			</select>			
			검색어 :
			<input type="text" name="searchText" id="searchText" value="${sdto.searchText}" size="20">
			<input type="submit" value="검색">						
		</td>
	</tr>
</table>	

<c:if test="${cnt == 0}">
	<center>
		<font size="+2" color="blue">
			<br><br><br>공지사항에 등록된 글이 없습니다
		</font>
	</center>	
</c:if>

<c:if test="${cnt > 0}">
	<table class="box" style="width: 80%">
		<tr align="center">
			<td>번호</td>
			<td>분류</td>			
			<td>제목</td>
			<td>조회수</td>
		</tr>
		
		<c:forEach  var="dto" items="${list}">
		<tr align="center">
			<td align="center">${dto.num}</td>
			<td>${dto.category}</td>
			<td>
				<a href="${ctxpath}/notice/content.do?num=${dto.num}&pageNum=${sdto.pageNum}">
					${dto.subject}
				</a>			
			</td>
			<td align="center">${dto.readcount}</td>
		</tr>
		</c:forEach>
	</table>
</c:if>

 	<%--블럭처리, 페이지 처리 --%>
 	<table>
 		<tr>
 			<td> 	
			 	<c:if test="${pdto.cnt>0}">

			 		<!-- 이전 블럭 -->
			 		<c:if test="${pdto.startPage>10}">
			 			<a href="${ctxpath}/notice/list.do?pageNum=${pdto.startPage-10}">
			 			
			 			[이전블럭]
			 			</a>
			 		</c:if>
			 		
			 		<!-- 페이지 처리 -->
			 		<c:forEach var="i" begin="${pdto.startPage}" end="${pdto.endPage}">
			 			<a href="${ctxpath}/notice/list.do?pageNum=${i}">
				 			<c:choose>
					 			<c:when test="${sdto.pageNum == i}">
					 				<font color="red" size="+2">[${i}]</font>
					 			</c:when>
					 			<c:otherwise>
					 				[${i}]
					 			</c:otherwise>
				 			</c:choose>
			 			</a>
			 		</c:forEach>
			 		
			 		<!-- 다음 블럭 -->
			 		<c:if test="${pdto.endPage<pdto.pageCnt}">
			 			<a href="${ctxpath}/notice/list.do?pageNum=${pdto.startPage+10}">[다음블럭]</a>
			 		</c:if>
			
				</c:if> 	
			</td>
		</tr>			
 	</table>
 	</td></tr>
 	</table>
 		
 	</div>
 	</div>
 	
</form>


</body>

</html>