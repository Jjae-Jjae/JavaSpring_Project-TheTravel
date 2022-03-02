<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../module/jsp-header.jsp" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeForm.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/order/style.css">

</head>
<body>

<c:if test="${sessionScope.userId eq null}">
	로그인 하신 후 주문하십시오.
	2초후에 로그인으로 이동합니다.
	<meta http-equiv="Refresh" content="2;url=${ctxpath}/member/login.do">
					
</c:if>

<form method="post" name="writeForm" action="${ctxpath}/order/writePro.do">
<div align="center" >
  <h2>상품 주문!</h2>
  <table class="box card" style="background-color: gray;">
    <tr>
    <td>
	<table border="0" width="660" align="light" bgcolor="ivory" cellpadding="10">
		<tr align="right">
			<td>
				<input type="button" value="예약목록" onClick="location='${ctxpath}/order/list.do'">
			</td>
		</tr>		
	</table>
	</td>
	</tr>
	<tr>
	<td>

	<table border="0" width="660" cellpadding="10" bgcolor="#EEFFFF">
							
		<tr align="left">
			<!-- 시작 주문 BOX-이미지 -->						
			<td width="260" height="180" align="left">
				<img src="${ctxpath}/resources/imgs/product/${dto.filename}" width="260" height="180">
			</td>	
			<!-- 끝 주문 BOX-이미지 -->
			
			<!-- 시작 주문 BOX-내용 -->
			<td width="400" align="left">
				<table border="0" align="left" cellpadding="5">
					<tr>
						<td align="left" width="80">여행 상품 :</td>
						<td align="left" width="200">${dto.name}</td>
					</tr>								
					<tr>
						<td>여행 일정 : </td>
						<td>${dto.start}~${dto.end}</td>
					</tr>
					<tr>
						<td>여행 도시 :</td>
						<td>${dto.city}</td>
					</tr>	
					<tr>
						<td>주문 수량 :</td>
						<td>
							<input type="number" name="ord_qty" id="ord_qty" style="width:50px;">
							&nbsp;<input type="submit" value="예약저장">
							<input type="hidden" name="pro_id" id="pro_id" value="${pro_no}">	
						</td>
					</tr>
																							
				</table>
			</td>		
			<!-- 끝 주문 BOX-내용 -->				
		</tr>
	</table>	
	</td>
	</tr>
	</table>
</div>
</form>	
</body>
</html>