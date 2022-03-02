<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${ctxpath}/resources/js/member/member_insertForm.js"></script>

<link rel="stylesheet" href="${ctxpath}/resources/css/member/member.css">

</head>
<body>
 <form method="post" action="${ctxpath}/member/insertPro.do" onSubmit="return check()">
  <div align="center">
    <h2>회원 가입</h2>
    <div class="inputForm">
      <table class="box"> 
	    <tr>
	      <td class=category>성함</td>
	      <td>
	        <input type="text" id=name name=name>
	        <!-- &nbsp;&nbsp;&nbsp; -->
	        <span id=nameConfirm1></span>
	        <span id=nameConfirm2><font color="red">잘못된 이름입니다</font></span>
	      </td>
	    </tr>
	    <tr>
	      <td>아이디</td>
	      <td>
	        <input type="text" id=id placeholder=" 소문자+숫자 6~15자리, 영어로 시작" name=id size="30">
	        <input type="button" value="ID중복체크" onClick="confirmIdCheck()"><br>
	        <span id=idConfirm1><font color="red">다시 입력해주세요</font></span>
	        <input type="hidden" name="idcheck" id="idcheck" value="false">
	        
	      </td>
	    </tr>
	    <tr>
	      <td>비밀번호</td>
	      <td>
	        <input type="password" id=pw name=pw placeholder=" 숫자+문자+특수 8~12자리" size="30">
	        <span id=pwConfirm2><font color="red">다시 입력해주세요</font></span>
	      </td>
	    </tr>
	    <tr>
	      <td>비밀번호 확인</td>
	      <td>
	        <input type="password" id=pw2 size="30">
	        <span id=pwConfirm3>일치합니다</span>
	        <span id=pwConfirm4><font color="red">잘못 입력하였습니다</font></span>
	      </td>
	    </tr>
	     
	     <tr>
	       <td>Email</td>
	       <td>
	         <input type="text" name="email" id="email" size="20">@
	         
	         <select name="email2" id="email2">
	           <option value="">선택하세요</option>
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
	           <option value="">선택하세요</option>
	           <option value="010">010</option>
	           <option value="018">018</option>
	           <option value="017">017</option>
	         </select>
	         -
	         <input type="text" name="tel2" id="tel2" size="4">-
	         <input type="text" name="tel3" id="tel3" size="4"><br>
	         <span id=telConfirm><font color="red">잘못 입력하였습니다</font></span>
	       </td>
	     </tr>
	     
	     <tr>
	      <td>우편번호</td>
	      <td>
	       <input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
	       <input type="button" value="주소검색" onClick="openDaumPostcode()" >
	      
	      </td>
	     </tr>
	     
	     
	     <tr>
	       <td>주소</td>
	       <td>
	       <input type="text" name="addr" id="addr" size="50" readonly="readonly">
	       <br>
	       <br>
	       상세주소:<input type="text" name="addr2" id="addr2" size="20">
	       </td>
	     </tr>
	     
	     
	     <tr>
	      <td colspan="2" align="center">
	        <div class="container">
 			  <div class="item deleForm_div">
		        <input type="submit" value="회원가입" class="div_btn">
		      </div>
			  <div class="item deleForm_div">
		        <input type="reset" value="다시입력" class="div_btn">
		      </div>
			  <div class="item deleForm_div">
		        <input type="button" value="가입안함" onClick="${ctxpath}/member/main.do" class="div_btn">
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