<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="${ctxpath}/resources/js/member/member_adminList.js"></script>

<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

<body>
<div align="center">
  <h2>${mdto.id}님의 정보</h2>
    <div class="inputForm">
      <table class="box">      
        <tr>
          <td>이름</td>
          <td><input type="text" size="30" value="${mdto.name}" readonly="readonly"></td>
        </tr>
      
        <tr>
          <td>Email</td>
          <td>
           <input type="text" value="${mdto.email}" size="20" readonly="readonly">
          </td>
        </tr>
      
      
        <tr>
          <td>전화</td>
          <td>
            <input type="text" name="tel" id="tel" value="${mdto.tel}" readonly="readonly">
          </td>
        </tr>
      
        <tr>
          <td>우편번호</td>
          <td>
            <input type="text" size="7" value="${mdto.zipcode}" readonly="readonly">
          </td>
        </tr>
      
        <tr>
          <td>주소</td>
          <td>
            <input type="text" size="50" value="${mdto.addr}" readonly="readonly">
            <br><br>
                     상세주소 : <input type="text"size="20" value="${mdto.addr2}" readonly="readonly">
          </td>
        </tr>
        
        <tr>
          <td>관리자 권한</td>
          <td>
            <c:if test="${mdto.level > 0}">
              <font size="5" color="red">관리자</font>
            </c:if>
            <c:if test="${mdto.level eq 0}">
              <font size="5" color="blue">손님</font>
            </c:if>
          </td>
        </tr>
      
        <tr>
          <td colspan="2" align="center">
            <div class="container">
	          <div class="item deleForm_div">
	            <form action="${ctxpath}/member/adminLevelPro.do" id="levelForm" name="levelForm" method="post" onsubmit="return check()">
        		  <input type="hidden" name="mem_id" value="${mdto.id}">
        		  <input type="hidden" name="level" value="${mdto.level}">
                  <input type="submit" value="권한변경" class="div_btn">
                </form>
              </div>
		      <div class="item deleForm_div">
		        <form action="${ctxpath}/member/adminDeletePro.do" id="infoDelForm" name="infoDelForm" method="post" onsubmit="return Del()">
        		  <input type="hidden" name="mem_id" value="${mdto.id}">
        		  <input type="hidden" name="level" value="${sessionScope.userLevel}">
                  <input type="submit" value="회원강퇴" class="div_btn">
                </form>
              </div>
            </div>
            
          </td>
        </tr>
      </table>
      

    </div>
</body>
</html>