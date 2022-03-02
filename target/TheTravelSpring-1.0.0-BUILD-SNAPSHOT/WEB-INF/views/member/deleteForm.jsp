<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>

<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${ctxpath}/resources/js/member/member_pwcheck.js"></script>
</head>
<body>
<form name="userCheckForm" method="post" action="${ctxpath}/member/deletePro.do" onSubmit="return check()">
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
        <td colspan="2" align="center" class="box">비밀번호 확인<br>
          <input type="hidden" name="id" id="id" value="${sessionScope.userId}">
        </td>
      </tr>
     
      <tr>
        <td>암호</td>
        <td><input type="password" name="pw" id="pw" size="20"></td>
      </tr>
     
      <tr>
        <td colspan="2" align="center">
          <div class="container">
            <div class="item deleForm_div">
              <input type="submit" value="탈퇴" class="div_btn">
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

