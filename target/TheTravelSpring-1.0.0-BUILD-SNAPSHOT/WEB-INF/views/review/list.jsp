<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
<%-- List.jsp --%>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${ctxpath}/resources/css/review/review.css">

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${ctxpath}/resources/js/review/list.js"></script>

</head>
<body>
<div align="center" >
<h2>후기 리스트</h2>
<c:if test="${pro_no ne null}">
  <button onclick="location.href='${ctxpath}/product/list.do?#div${pro_no}'">👉리뷰상품 보러가기👈</button><br><br><br>
</c:if>
  <table class="box card">
    <c:if test="${fn:length(boardList) eq 0}">
      <tr>
        <td align="center">
                 게시판에 저장된글이 없습니다
          <c:if test="${pro_no ne null}">
            <br><br>
          	<button onclick="location.href='${ctxpath}/review/list.do'">👉전체 리스트 보러가기👈</button><br>
    	  </c:if>
    	  <c:if test="${pro_no eq null}">
            <br><br>
          	<button onclick="location.href='${ctxpath}/product/list.do'">👉상품 보러가기👈</button><br>
    	  </c:if>
        </td>
      </tr>  
    </c:if>
    <tr>  
    <c:forEach var="dto" items="${boardList}" varStatus="i">
      <c:set var="imgDTO" value="${imgList[i.index]}"/>
		<td align="left">
		  <table class="box card_link" onclick="gotoDetail('${pageNum}','${dto.review_id}')">
		      <tr height="250" valign="middle">
		        <td width="200" class="box" align="center" style="width: 200; padding: 10px">
		         <img src="${ctxpath}/resources/imgs/review/saveImg/${imgDTO.img_name}" onerror="this.src='${ctxpath}/resources/imgs/review/empty.gif'" style="max-height: 90%; max-width: 90%;"/>
		       </td>
		     </tr>
		   <tr>
		     <td>
		       <c:if test="${fn:length(dto.pro_name)>=20}">
		         ${fn:substring(dto.pro_name,0,16)}...
		       </c:if>
		       <c:if test="${fn:length(dto.pro_name)<20}">
		           ${dto.pro_name}
		       </c:if>
		     </td>
		   </tr>
		   <tr>
		     <td align="left">
		       <font size="2">
		         <c:choose>
		           <c:when test="${dto.score==0}">☆☆☆☆☆</c:when>
		           <c:when test="${dto.score==1}">★☆☆☆☆</c:when>
		           <c:when test="${dto.score==2}">★★☆☆☆</c:when>
		           <c:when test="${dto.score==3}">★★★☆☆</c:when>
		           <c:when test="${dto.score==4}">★★★★☆</c:when>
		           <c:when test="${dto.score==5}">★★★★★</c:when>
	  	         </c:choose>
		       </font>
		     </td>
		   </tr>
		   <tr>
		     <td>
		       <font size="2">
  	  	         <c:if test="${fn:length(dto.content)>=20}">
		           ${fn:substring(dto.content,0,16)}...
		         </c:if>
		         <c:if test="${fn:length(dto.content)<20}">
		           ${dto.content}
		           <c:if test="${fn:length(dto.content) eq 0}">
		     <%--공백문자 있음--%>&nbsp;	&nbsp;<%--공백문자 있음--%> 
		           </c:if>
		         </c:if>
		       </font>
		     </td>
		   </tr>
		   <tr>
		     <td>
		     <font size="2" color="gray">
		       <c:set var="strLength" value="${fn:length(dto.writer)}"/>
		       ****${fn:substring(dto.writer,4,strLength)}
		     </font>
		     </td>
		   </tr>
		  </table>
        </td>
      <c:if test="${i.count%4==0}">
		</tr><tr>
      </c:if>
    </c:forEach>
    <c:remove var="imgDTO" />
    </tr>
  </table>
  <br>  
 <%--블럭처리 ,페이지 처리 --%>
 
<c:if test="${pro_no ne null}">
<table>
   <tr>
     <td align="center"> 
       <!-- 이전블럭 -->
       <c:if test="${pp2.startPage}>10">
         <a href="${ctxpath}/review/list.do?pageNum=${pp2.startPage-10}&pro_no=${pro_no}">
           [이전블럭]
         </a>
       </c:if>
   
	   <!-- 페이지 처리 -->
	   <c:forEach var="i" begin="${pp2.startPage}" end="${pp2.endPage}">
	     <a href="${ctxpath}/review/list.do?pageNum=${i}&pro_no=${pro_no}">
	     [${i}]
	     </a>
	   </c:forEach>
	   
	   <!--다음 블럭-->
	   <c:if test="${pp2.endPage<pp2.pageCnt}">
	     <a href="${ctxpath}/review/list.do?pageNum=${pp2.startPage+10}&pro_no=${pro_no}">
	     [다음블럭]
	     </a>
	   </c:if>
	 </td>
   </tr>
</table>
</c:if>

<c:if test="${pro_no eq null}">
<table>
   <tr>
     <td align="center"> 
       <!-- 이전블럭 -->
       <c:if test="${pp2.startPage}>10">
         <a href="${ctxpath}/review/list.do?pageNum=${pp2.startPage-10}">
           [이전블럭]
         </a>
       </c:if>
   
	   <!-- 페이지 처리 -->
	   <c:forEach var="i" begin="${pp2.startPage}" end="${pp2.endPage}">
	     <a href="${ctxpath}/review/list.do?pageNum=${i}">
	     [${i}]
	     </a>
	   </c:forEach>
	   
	   <!--다음 블럭-->
	   <c:if test="${pp2.endPage<pp2.pageCnt}">
	     <a href="${ctxpath}/review/list.do?pageNum=${pp2.startPage+10}">
	     [다음블럭]
	     </a>
	   </c:if>
	 </td>
   </tr>
</table>
</c:if>
 
 
</div>
<form method="post" name="godetail" id="godetail" action="${ctxpath}/review/detail.do">
	<input type="hidden" id="pageNum" name="pageNum">
	<input type="hidden" id="review_id" name="review_id">
</form>
</body>
</html>