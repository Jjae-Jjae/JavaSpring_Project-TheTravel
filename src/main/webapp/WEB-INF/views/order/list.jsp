<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../module/jsp-header.jsp" %>    
<fmt:requestEncoding value="UTF-8"/>

<html>
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/order/style.css">


<script type="text/javascript">

function goReviewWrite(idx) {
	$('#goReviewWrite'+idx).submit();
}

function pageReload(pageNum){	
 	moveurl = "${ctxpath}/order/list.do?pageNum=" + pageNum + "&start_date="+ $('#start_date').val() + "&end_date="+$('#end_date').val(); 
	location.href = moveurl;	
}

function deleteOrder(ord_num){	
	moveurl = "${ctxpath}/order/deletePro.do?ord_num=" + ord_num; 
	location.href = moveurl;	
}

</script>

<head>
<meta charset="UTF-8">
<title>/order/list.jsp</title>
</head>
<body>

<c:if test="${empty sessionScope.userId}">
	<h2><font color="red"> 로그인 하신 후 주문목록을 조회할 수 있습니다.</font></h2>
	<br>
	<h2>2초후에 로그인으로 이동합니다.</h2>
	<meta http-equiv="Refresh" content="2;url=${ctxpath}/member/login.do">
					
</c:if>

<%-- 0. 본문 --%>
<c:if test="${sessionScope.userId ne null}">
	<%-- 1. 검색부 --%>
	<form name="searchForm" method="post" action="${ctxpath}/order/list.do">
		<c:set var="start_date" value="${start_date}"/>
		<c:set var="end_date" value="${end_date}"/>
		<c:set var="pageNum" value="${pageNum}"/>
	
		<table width="80%" height ="80" cellpadding="5">
			<tr>
				<td align="left">
					<font size="+2">
						<strong>예약목록</strong><font size="-1">&nbsp;&nbsp;(전체 : ${cnt}) </font>
					</font>
					<a href="${ctxpath}/order/writeForm.do?pro_no=16">주문하기(임시)</a>			
				</td>
		
				<td align="right">				
					<a href="javascript:listReload()">새로고침</a>						
				</td>				
			</tr>
			
			<tr>
				<td colspan="2" align="right">
					예약 일자
					<input type="date" name="start_date" id="start_date" value="${start_date}">
					&nbsp;			
					<input type="date" name="end_date" id="end_date" value="${end_date}">			
					<input type="submit" value="검색">						
				</td>
			</tr>	
			
		</table>
	</form>
	<%-- END 1. 검색부 --%>
	
	<%-- 2. 목록 조회영역 --%>
	<c:if test="${cnt == 0}">
		<center>
			<font size="+2" color="blue">
				<br><br><br>예약 내역이  없습니다
			</font>
		</center>	
	</c:if>
	<c:if test="${cnt > 0}">
		<table width="80%" >		
			<tr>		
			<c:forEach  var="dto" items="${list}" varStatus="i">
					<td align="left" >					
						<!--  시작 주문 BOX -->	
						<table border="0" width="450" class="box card">						
							<tr align="left">
								<!-- 시작 주문 BOX-이미지 -->						
								<td width="120" height="90" align="center" bgcolor="lightgrey">
									<img src="${ctxpath}/resources/imgs/product/${dto.pro_img}" width="120" height="90">
								</td>	
								<!-- 끝 주문 BOX-이미지 -->
								
								<!-- 시작 주문 BOX-내용 -->
								<td width="280">
									<table border="0" align="left" cellpadding="5">
										<tr>
											<td align="left" width="80">상  품  명  :</td>
											<td align="left">${dto.pro_name}</td>
										</tr>								
										<tr>
											<td>주문 수량 : </td>
											<td>${dto.ord_qty}</td>
										</tr>
										<tr>
											<td>주문 일시 :</td>
											<td>${dto.ord_date}</td>
										</tr>	
										<tr>
											<td>${dto.ord_num}</td>
											<td  align="center">
												<input type="button" value="후기작성" onclick="goReviewWrite(${i.count})">
												<input type="button" value="예약취소" onclick="deleteOrder(${dto.ord_num})">
											</td>
										</tr>																	
									</table>
								</td>		
								<!-- 끝 주문 BOX-내용 -->				
							</tr>
						</table>
						<!--  끝 주문 BOX -->			
					</td>										
					<c:if test="${i.count%2==0}">
						</tr><tr>
					</c:if>			
					<form method="post" name="goReviewWrite${i.count}" id="goReviewWrite${i.count}" action="${ctxpath}/review/writeForm.do">
						<input type="hidden" name="pro_no" value="${dto.pro_id}">
						<input type="hidden" name="userId" value="${dto.mem_id}">
	      			</form>		
			</c:forEach>
			</tr>				
		</table>
	</c:if>
	<%-- END 2. 목록 조회영역 --%>
	
 	<%--3. 블럭처리, 페이지 처리 --%>
 	<!-- <form name="pageForm" method="post" action="${ctxpath}/order/list.do"> -->
 	
 	<form name="pageForm" id="pageForm" method="post">
 	<!-- TO-DO : post 방식으로 수정 -->
 	</form>
 	 	
	 	<table>
	 		<tr>
	 			<td> 	
				 	<c:if test="${pdto.cnt>0}">
	
				 		<!-- 이전 블럭 -->
				 		<c:if test="${pdto.startPage>10}">				 			
				 			<a href="javascript:pageReload(${pdto.startPage-10})">
				 			[이전블럭]
				 			</a>
				 		</c:if>
				 		
				 		<!-- 페이지 처리 -->
				 		<c:forEach var="i" begin="${pdto.startPage}" end="${pdto.endPage}">

				 			<a href="javascript:pageReload(${i})">
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
				 			<a href="javascript:pageReload(${pdto.startPage+10})">
				 			[다음블럭]
				 			</a>
				 		</c:if>
				
					</c:if> 	
				</td>
			</tr>			
	 	</table>	
		 	
 	<%--END 3.블럭처리, 페이지 처리 --%>	
</c:if>
<%-- END 0. 본문 --%>
	
</body>
</html>