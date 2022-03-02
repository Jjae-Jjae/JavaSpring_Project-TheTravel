<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>       

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>writeForm.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/style.css">

<!-- 공란 체크 -->
<script type="text/javascript">
  function check(){
	  if($("#writer").val()==''){
		  alert("이름을 입력 하세요");
		  $("#writer").focus();
		  return false;
	  }
	  
	  if($("#pw").val()==''){
		  alert("암호를 입력 하세요")
		  $("#pw").focus();
		  return false;
	  }
	  
	  if($("#subject").val()==''){
		  alert("글제목을 입력 하세요");
		  $("#subject").focus();
		  return false;
	  }
	  
	  if($("#content").val()==''){
		  alert("글내용을 입력 하세요")
		  $("#content").focus();
		  return false;
	  }
	  
	  
	  return true;
  }
</script>
</head>
<body>
<div align="center">
    <div class="inputForm">


<c:if test="${num==0}">
<h2>글쓰기 폼</h2>
</c:if>

<c:if test="${num!=0}">
<h2>답글쓰기</h2>
</c:if>

<form method="post" name="writeForm" action="${ctxpath}/qna/writePro.do" onSubmit="return check()"enctype="multipart/form-data">
  <input type="hidden" name="num" value="${num}">
  <input type="hidden" name="ref" value="${ref}">
  <input type="hidden" name="re_step" value="${re_step}">
  <input type="hidden" name="re_level" value="${re_level}">
  

<table class="box" style="width: 80%;">
   <tr>
     <td>글쓴이</td>
     <td><input type="text" name="writer" id="writer" value="${writer}" size="30"></td>
   </tr>
   
   <tr>
     <td>암호</td>
     <td><input type="password" name="pw" id="pw" size="15"></td>
   </tr>
 
   <tr>
     <td>글제목</td>
     <td>
      <c:if test="${num==0}">
        <input type="text" name="subject" id="subject" size="40">
      </c:if>
     
      <c:if test="${num!=0 }">
        <input type="text" name="subject" id="subject" size="40" value="[답변]">
      </c:if>
     </td>
   </tr>
 
   <tr>
     <td>글내용</td>
     <td>
     <textarea name="content" id="content" rows="10" cols="50"></textarea>
     </td>
   </tr>
   
	<tr>
		<td width="100">파일 업로드</td><td align="left">
		<input type="file" name="uploadFile"/></td>
	</tr>

   <tr>
    <td colspan="2" align="center">
      <c:if test="${num==0}">
         <input type="submit" value="글쓰기">
      </c:if>
      
      <c:if test="${num!=0}">
      <input type="submit" value="답글쓰기">
      </c:if>
      
      <input type="reset" value="취소">
      <input type="button" value="글목록" onClick="location='${ctxpath}/qna/list.do'">
    </td>
   </tr>
 </table></div></div>
  
</form>
</body>
</html>