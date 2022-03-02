<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../module/jsp-header.jsp"%>
<%--list.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${ctxpath}/resources/js/member/member_adminList.js"></script>

</head>
<body>
<c:if test="${not empty msg}">
  <font color="red">
	${msg}
  </font>
</c:if>
  <form action="${ctxpath}/member/adminUserInfo.do" id="userInfoForm" name="userInfoForm"></form>
  <form action="${ctxpath}/member/adminDeletePro.do" id="userDelForm" name="userDelForm"></form>
  
	<c:if test="${pp2.cnt>0}">
		<div align="center">
   		  <div class="inputForm">
      		<table class="box" style="border-spacing: 5px">      
			<tr align="center" height="20">
				<td>ID</td>
				<td>레벨</td>
				<td>이름</td>
				<td>이메일</td>
				<td>전화번호</td>
				<td>
				 	<%-- 검색창 --%>
					<form name="searchForm" method="post" action="/TheTravelSpring/member/adminList.do">
					<table>
						<tr>
							<td colspan="2" align="right">
							<select id="column" name="column">
							  <option value="name">이름</option>
							  <option value="level">레벨</option>
							  <option value="id">Id</option>
							</select>
							<input type="text" name="searchText" id="searchText" value="${searchText}" size="20"/>
							<input type="submit" value="검색">
							</td>
						</tr>	
					</table>
					</form>
				</td>
		  </tr><tr><td colspan="6"><hr></td></tr>
		  <%-- table --%>
		  <c:forEach var="memDto" items="${list}">
			<tr align="center" >
		  	  <td>${memDto.id}</td>
			  <td>
			    <c:if test="${memDto.level > 0}">
                  <font size="2" color="red">관리자</font>
                </c:if>
            	<c:if test="${memDto.level eq 0}">
              	  <font size="2" color="blue">손님</font>
            	</c:if>
			  </td>
			  <td>${memDto.name}</td>
			  <td>${memDto.email}</td>
			  <td>${memDto.tel}</td>
			  <td>
			    <input type="button" onclick="goUserInfo('${memDto.id}')" value="정보">&nbsp; &nbsp; &nbsp; &nbsp; 
			    <input type="button" onclick="goUserDel('${memDto.id}', ${sessionScope.userLevel})" value="삭제">
			  </td>
			</tr>
			<tr><td colspan="6"><hr></td></tr>
			
		  </c:forEach>
		<table>
   <tr>
     <td align="center"> 
       <!-- 이전블럭 -->
       <c:if test="${pp2.startPage}>10">
         <a href="${ctxpath}/member/adminList.do?pageNum=${pp2.startPage-10}&column=${column}&searchText=${searchText}">
           [이전블럭]
         </a>
       </c:if>
   
	   <!-- 페이지 처리 -->
	   <c:forEach var="i" begin="${pp2.startPage}" end="${pp2.endPage}">
	     <a href="${ctxpath}/member/adminList.do?pageNum=${i}&column=${column}&searchText=${searchText}">
	     [${i}]
	     </a>
	   </c:forEach>
	   
	   <!--다음 블럭-->
	   <c:if test="${pp2.endPage<pp2.pageCnt}">
	     <a href="${ctxpath}/member/adminList.do?pageNum=${pp2.startPage+10}&column=${column}&searchText=${searchText}">
	     [다음블럭]
	     </a>
	   </c:if>
	 </td>
   </tr>
	    </c:if>
      </table>
    </div>
  </div>
</body>
</html>