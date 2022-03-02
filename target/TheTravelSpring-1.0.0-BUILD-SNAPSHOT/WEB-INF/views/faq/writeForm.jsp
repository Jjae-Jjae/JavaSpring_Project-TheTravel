<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>writeForm.jsp</title>

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
	  
	  if($("#theme").val()==''){
		  alert("분류를 선택하세요")
		  $("#theme").focus();
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

<link rel="stylesheet" type="text/css"
	href="${ctxpath}/resources/css/style.css">
</head>
<body>



<div align="center">
	<h2>글쓰기 폼</h2>
    <div class="inputForm">
	<form method="post" name="writeForm"
		action="${ctxpath}/faq/writePro.do" onSubmit="return check()">
		<input type="hidden" name="num" value="${num}">


		<table class="box">
			<tr>
				<td>글쓴이</td>
				<td>
					<input type="text" name="writer" id="writer" value="${writer}" size="30">
				</td>
			</tr>

			<tr>
				<td>암호</td>
				<td>
					<input type="password" name="pw" id="pw" size="15">
				</td>
			</tr>

			<tr>
				<td>테마</td>
				<td>
					<select name="theme" id="theme">
						<option value=""></option>
						<option value="해외여행">해외여행</option>
						<option value="국내여행">국내여행</option>
						<option value="결제">결제</option>
						<option value="계정">계정</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>

			<tr>
				<td>글제목</td>
				<td>
				<input type="text" name="subject" id="subject" size="40">
				</td>
			</tr>

			<tr>
				<td>글내용</td>
				<td>
				<textarea name="content" id="content" rows="10" cols="50"></textarea>
				</td>
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
					<input type="button" value="글목록" onClick="location='${ctxpath}/faq/list.do'"></td>
			</tr>
		</table></div></div>

	</form>
</body>
</html>