<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

</head>

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
          <td colspan="2" align="center">
            <div class="container">
	          <div class="item deleForm_div">
                <input type="button" onclick="location='${ctxpath}/member/editForm.do'" value="정보수정" class="div_btn">
              </div>
		      <div class="item deleForm_div">
                <input type="button" onclick="location='${ctxpath}/member/pwChangeForm.do'" value="암호수정" class="div_btn">
              </div>
		      <div class="item deleForm_div">
                <input type="button" onclick="location='${ctxpath}/member/deleteForm.do'" value="회원탈퇴" class="div_btn">
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
</body>
</html>