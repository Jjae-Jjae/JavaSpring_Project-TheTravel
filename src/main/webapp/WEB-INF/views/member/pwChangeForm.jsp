<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${ctxpath}/resources/js/member/member_pwcheck.js"></script>

<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

</head>
<body>
 <form name="userCheckForm" method="post" action="${ctxpath}/member/pwChangePro.do" onSubmit="return checkChange('${pw}')">
  <div align="center">
    <div class="inputForm">
      <table class="box">     
	    <c:if test="${not empty msg}">
	      <tr>
	        <td align="center" colspan="2">
			  <font color="red">
			    ${msg}
			  </font>
			</td>
	      </tr>
		</c:if>
	    <tr>
	      <td colspan="2" align="center">비밀번호 확인
	      <input type="hidden" name="id" id="id" value="${sessionScope.userId}"></td>
	    </tr>
	     
	    <tr>
	      <td>현재 암호</td>
	      <td><input type="password" name="pw" id="pw" size="20"></td>
	    </tr>
	     
	    <tr>
	      <td>비밀번호</td>
	      <td>
	        <input type="password" id=pw2 name=pw2 placeholder=" 숫자+문자+특수 8~12자리" size="30"><br>
	        <span id=pwConfirm2><font color="red">다시 입력해주세요</font></span>
	      </td>
	    </tr>
	    <tr>
	      <td>비밀번호 확인</td>
	      <td>
	        <input type="password" id=pw3 name="pw3" placeholder=" 숫자+문자+특수 8~12자리" size="30"><br>
	        <span id=pwConfirm3>일치합니다</span>
	        <span id=pwConfirm4><font color="red">잘못 입력하였습니다</font></span>
	      </td>
	    </tr>
	     
	    <tr>
	      <td colspan="2" align="center">
	        <div class="container">
 			  <div class="item deleForm_div">
	            <input type="submit" value="변경" class="div_btn">
	          </div>
			  <div class="item deleForm_div">
	            <input type="button" onclick="location='${ctxpath}/member/myPageForm.do'" value="취소" class="div_btn">
	          </div>
	        </div>
	      </td>
	    </tr>
	  </table>
	</div>
  </div>
 </form>
</body>
</html>