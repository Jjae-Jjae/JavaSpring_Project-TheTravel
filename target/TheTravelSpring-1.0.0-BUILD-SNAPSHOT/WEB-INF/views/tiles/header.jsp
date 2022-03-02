<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
<%-- 상단 --%>
<table style="width: 100%;">
  <%-- 메인 로고 이미지&링크 --%>
  <tr>
	<td>
	  <div class=top2>
	   <div style="margin: 0px"></div><div style="margin: 0px"></div>
	  	<%-- 로그인 정보 X --%>
	    <c:if test="${empty sessionScope.userId}">
		  <div>
    	  <!-- <a href="/anytime/login">-->
      		<a href="${ctxpath}/member/login.do">
        	  <img src="${ctxpath}/resources/imgs/tiles/login.png"><br>
                         로그인
      		</a><br>
      	  </div>
    	</c:if>
		<c:if test="${empty sessionScope.userId}">
		  <div>
		    <a href="${ctxpath}/member/insertForm.do">
		      <img src="${ctxpath}/resources/imgs/tiles/join.png" alt=""><br>
		           회원가입
		    </a><br>
		  </div>
		</c:if>
		<%-- 로그인정보 O  --%>
		<c:if test="${!empty sessionScope.userId}">
		  <div>
		  <!-- <a href="/user/logout"> -->
		    <a href="${ctxpath}/member/logOut.do">
		      <img src="${ctxpath}/resources/imgs/tiles/logout.png" alt=""><br>
		          로그아웃
		    </a>
		  </div>
		</c:if>
		

		
		<c:if test="${!empty sessionScope.userId}">
		  <div>
		  <!-- <a href="/leave.html"> -->
		    <a href="${ctxpath}/member/myPageForm.do">
		      <img src="${ctxpath}/resources/imgs/tiles/my.png" alt=""><br>
		          내정보
		    </a>
		  </div> 
		</c:if>
		
		<c:if test="${sessionScope.userLevel > 0}">
		  <div>
		  <!-- <a href="/leave.html"> -->
		    <a href="${ctxpath}/member/adminList.do">
		      <img src="${ctxpath}/resources/imgs/tiles/userControll.jpg" alt=""><br>
		          유저관리
		    </a>
		  </div> 
		</c:if>
		
		<%-- 로그인 상관 X --%>
		<div>
		  <!--<a href="/main.html">-->
		  <a href="${ctxpath}/">
		    <img src="${ctxpath}/resources/imgs/tiles/home.png" alt=""><br>
		       홈으로
		  </a>
		</div>
	  </div>
	</td>
  </tr>	
  <tr>
    <td>
      <%-- 메뉴바 --%>
	  <div id="topBar">
		<a href="${ctxpath}/" class="item">
		<img src="${ctxpath}/resources/imgs/tiles/logo.png">
		</a>
	  	<a href="${ctxpath}/product/list.do" class="link item">여행상품</a>
        <a href="${ctxpath}/review/list.do" class="link item">여행후기</a>
        <a href="${ctxpath}/order/list.do" class="link item">예약목록</a>
		<a href="${ctxpath}/notice/list.do" class="link item">공지사항</a>
		<a href="${ctxpath}/qna/list.do" class="link item">QnA</a>
		<a href="${ctxpath}/faq/list.do" class="link item">FAQ</a>
	  </div>
	</td>
  </tr>
</table>
