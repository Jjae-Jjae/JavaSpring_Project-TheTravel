<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<%--updateForm.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

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

<link rel="stylesheet" type="text/css" href="../resources/css/style.css">





</head>
<body>

 <form name="writeForm" method="POST" action="${ctxpath}/qna/updatePro.do" onSubmit="return check()"enctype="multipart/form-data">
 	<div align="center">
 	 <h2>글수정 폼</h2>
    <div class="inputForm">
      <table class="box">
 		<tr>
 			<td>글쓴이</td>
 			<td><input type="text" name="writer" id="writer" value="${qDto.writer}" size="30">
 			<input type="hidden" name="num" value="${num}"> 
 			<input type="hidden" name="pageNum" value="${pageNum}"> 
 			</td>
 		</tr>
 		
 		<tr>
 			<td>암호</td>
 			<td><input type="password" name="pw" id="pw" size="15">
 			<font color="red">*필수입력</font>
 			</td>
 		</tr>
 				
 		<tr>
 			<td>글제목</td>
 			<td><input type="text" name="subject" id="subject" value="${qDto.subject}" size="50"></td>
 		</tr>
 				
 		<tr>
 			<td>글내용</td>
 			<td><textarea name="content" id="content" rows="10" cols="50">${qDto.content}</textarea>
 			
 			</td>
 		</tr> 		
 		
 		<tr>
			<td width="100">파일 업로드</td><td align="left">
			<input type="file" name="uploadFile"/></td>
		</tr>
 				
 		<tr>
 			<td colspan="2" align="center">
 				<input type="submit" value="글수정">
 				<input type="reset">
 				<input type="button" value="글목록" onClick="location='${ctxpath}/qna/list.do'">
 			</td>
 		</tr>		
 	
 	
 	<table></div></div>
 </form>

</body>
</html>