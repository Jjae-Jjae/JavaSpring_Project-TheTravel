<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%> --%>
<%@ include file="../module/jsp-header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="../resources/css/product/choice.css">


</head>
<body>         
			<c:forEach var="dto" items="${list}">
			
				<div id=body_top>
			<input type=hidden id=id name=id class=id value=${dto.id }>
					<div id=body_top_left>
						<img src="../resources/imgs/product/${dto.filename } ">
<%-- 						${dto.filename } --%>
					</div>
					<div id=body_top_right>
						<div class="name">${dto.name }</div>
						<hr>
						<br>
						<div id=icon>
							<div>
								<img src="../resources/imgs/product/calendar.png"> <span>
									일정 확인 필수</span>
							</div>
							<div>
								<img src="../resources/imgs/product/shopping.png"> <span>쇼핑
									선택</span>
							</div>
						</div>
						<div class=clear></div>
						<br>
						<hr>
						<br>
					 <form method="get" action="${ctxpath}/order/writeForm.do">
                  <input name=pro_no type=hidden value=${dto.id }>
                  <input type=submit value=주문하기> 
                  </form><br>
                  <form method="get" action="${ctxpath}/review/list.do">
                    <input name=pro_no type=hidden value=${dto.id }>
                  <input type=submit id=review value=리뷰보기>
                  </form>
						<p>
							성인/아동 1인 <br>
						</p>
						<div id=price>
							<strong>${dto.price}</strong>원
						</div>
					</div>
					<div class=clear></div>

					<div id=body_bottom>
						<hr>
						<div id=body_bottom_left>
							<table id=table1>
								<th colspan="2">
									<h3>여행 주요일정</h3>
								</th>
								<tr>
									<td>
										<h5>일정</h5>
									</td>
									<td>${dto.start}~${dto.end}</td>
								</tr>
								<tr>
									<td>
										<h5>여행도시</h5>
									</td>
									<td>${dto.city}</td>
								</tr>

							</table>
							<br>

						</div>
					</div>
					<div class=clear></div>
					
				</div>
				<div id=line></div>
			 
			</c:forEach>
			
	

</body>
</html>