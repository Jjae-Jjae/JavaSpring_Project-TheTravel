<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>   
<%--deleteForm.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<link rel="stylesheet" type="text/css" href="style.css">
<script>
  function check(){
	  if(document.delForm.pw.value==''){
		  alert("암호을 입력 하세요");
		  document.delForm.pw.focus();
		  return false;
	  }
	  return true;
  }
</script>

<body>

  <form name="deleteForm" method="post" action="${ctxpath}/qna/delete.do" onSubmit="return check()">
   <div align="center">
     <h2>글삭제 폼</h2>
    <div class="inputForm">
      <table class="box" style="width: 30%;">
   
     <tr>
      <td >
              암호를 입력 하세요
      </td>
     </tr>
     
     <tr>
       <td align="center" >
       
         암호입력:
       <input type="password" name="pw" size="15">
       
       <input type="hidden" name="num" value="${num}">         
       <input type="hidden" name="pageNum" value="${pageNum}">
      
       <input type="submit" value="글삭제">&nbsp;<br><br>
       <input type="button" value="글목록" onClick="location='${ctxpah}/qna/list.do?pageNum=${pageNum}'">
       </td>
     </tr>
     
     
     
   <table></div></div>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>

  </form>
</body>
</html>