<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    
<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${ctxpath}/resources/js/member/member_editForm.js"></script>


<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

</head>

<body>
<div align="center">
<h2>${mdto.id}님의 정보 수정</h2>
  <form method="post"  action="${ctxpath}/member/editPro.do" onSubmit="return check()">
    <div class="inputForm">
    <table class="box">      
      <tr>
        <td>성함</td>
        <td>
        <input type="text" id=name name=name value="${mdto.name}"><br>
        <span id=nameConfirm1></span>
        <span id=nameConfirm2><font color="red">잘못된 이름입니다</font></span>
      </td>
      </tr>
      
      <tr>
        <td>Email</td>
        <td>
         <input type="text" name="email" id="email" value="${email}" size="20">
         @
         <select name="email2" id="email2">
           <option value="@${email2}">${email2}</option>
           <option value="@naver.com">naver.com</option>
           <option value="@daum.net">daum.net</option>
           <option value="@nate.com">nate.com</option>
         </select>
        </td>
      </tr>
      
      
      <tr>
       <td>전화</td>
       <td>
         <select name="tel" id="tel">
           <option value="${tel}">${tel}</option>
           <option value="010">010</option>
           <option value="018">018</option>
           <option value="017">017</option>
           <option value="032">032</option>
         </select>
         -
         <input type="text" name="tel2" id="tel2" size="4" value="${tel2}">-
         <input type="text" name="tel3" id="tel3" size="4" value="${tel3}">
         <span id=telConfirm><font color="red">잘못 입력하였습니다</font></span>
       </td>
      </tr>
      
      <tr>
       <td>우편번호</td>
       <td>
        <input type="text" name="zipcode" id="zipcode" size="7" value="${mdto.zipcode}" readonly="readonly">
        <input type="button" value=주소찾기 onClick="openDaumPostcode()">
       </td>
      </tr>
      <tr>
        <td>주소</td>
        <td>
         <input type="text" name="addr" id="addr" size="50" value="${mdto.addr}" readonly="readonly">
         <br><br>
         상세주소:<input type="text" name="addr2" id="addr2" size="20" value="${mdto.addr2}">
        </td>
      </tr>
      
    
      <tr>
        <td colspan="2" align="center">
          <div class="container">
	        <div class="item deleForm_div">
              <input type="submit" value="내정보 수정"class="div_btn">
            </div>
		    <div class="item deleForm_div">
              <input type="reset" value="다시입력"class="div_btn">
            </div>
          </div>
        </td>
      </tr>
  </table>
</div>
<input type="hidden" name="id" value="${mdto.id}">
</form>
</div>  
</body>
</html>