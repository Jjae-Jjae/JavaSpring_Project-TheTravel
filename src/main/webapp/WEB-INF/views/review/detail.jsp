<%@page import="sun.reflect.generics.visitor.Reifier"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../module/jsp-header.jsp" %>
<%-- ReviewDetail.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${ctxpath}/resources/js/review/dele.js"></script>

<link rel="stylesheet" href="${ctxpath}/resources/css/review/review.css">
<link rel="stylesheet" href="${ctxpath}/resources/css/review/bxslider.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

</head>
<body>
<div align="center">
<h2>여행 후기</h2><br>
  <table>
    <tr>
    	
      <c:if test="${!empty img_list}">
        <td rowspan="2" width="400px" align="center">
          <div class="slider">
            <c:forEach var="list" items="${img_list}" varStatus="i">
  	          <div><img style="object-fit:cover; width: 100%;" id="review_img" src="${ctxpath}/resources/imgs/review/saveImg/${list.img_name}"/></div>
   		    </c:forEach>
  		  </div>
        </td>
      </c:if>
	  <td>
	    <table class="box">
	      <tr>
	        <td>${reviewDto.pro_name}</td>
	      </tr>
	      <tr>
	        <td>
		      <font size="2">
		        <c:choose>
				  <c:when test="${reviewDto.score==0}">☆☆☆☆☆</c:when>
				  <c:when test="${reviewDto.score==1}">★☆☆☆☆</c:when>
				  <c:when test="${reviewDto.score==2}">★★☆☆☆</c:when>
				  <c:when test="${reviewDto.score==3}">★★★☆☆</c:when>
				  <c:when test="${reviewDto.score==4}">★★★★☆</c:when>
				  <c:when test="${reviewDto.score==5}">★★★★★</c:when>
				</c:choose>
	    	  </font>
	    	</td>
	  	  </tr>
	      <tr>
	        <td>
	          <textarea rows="50" cols="100" class="content_box" class="box" readonly="readonly">${reviewDto.content}</textarea>      
	    	</td>
	   	  </tr>
	  	  <tr>
	    	<td>
	      	<!-- <hr color="#999999" style=" border-style: dotted; "> --><%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>
	      	  <font size="2" color="gray">
	        	<c:set var="strLength" value="${fn:length(reviewDto.writer)}"/>
	        	****${fn:substring(reviewDto.writer,4,strLength)}
	     	  </font>
	    	</td>
	 	  </tr>
		</table>
	  </td>
	</tr>  
	<tr>
	  <td>
	    <form method="post" name="deleForm" onsubmit="return chkDel()" action="${ctxpath}/review/deleteForm.do">
	      <div class="container">
	        <div class="item deleForm_div">
	          <input type="button" value="뒤로가기" onclick="history.back()" class="div_btn">
	        </div>
	        <div class="item deleForm_div">
	          <input type="button" value="상품보기" onclick="location.href='${ctxpath}/product/list.do?#div${reviewDto.pro_no}'" class="div_btn">
	        </div> 
	        <c:if test="${sessionScope.userId eq reviewDto.writer || sessionScope.userLevel > 0}">
	          <div class="item deleForm_div">
	            <input type="submit" value="삭제하기" class="div_btn">
	          </div>
	          <input type="hidden" name="pageNum" value="${pageNum}"> 
	          <input type="hidden" name="review_id" value="${reviewDto.review_id}">
	          <input type="hidden" name="pro_no" value="${reviewDto.pro_no}">
	  	    </c:if>
	  	  </div>
	  	</form>	
	  </td> 
    </tr>
<!-- 	<tr>
	  <td colspan="2">
	    <font size="6">여기는 상품정보를 쓸 예정입니다</font>
	  </td>
	</tr> -->
  </table>  
</div>
</body>
</html>