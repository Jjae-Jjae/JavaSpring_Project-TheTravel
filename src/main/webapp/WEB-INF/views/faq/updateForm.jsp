<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<%--updateForm.jsp --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>updateForm.jsp</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="${ctxpath}/resources/js/script.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/style.css">





</head>
<body>
 <h2>글수정 폼</h2>
 <form name="writeForm" method="POST" action="${ctxpath}/faq/updatePro.do" onSubmit="return writeSave()">
 	<div align="center">
 	 <h2>글수정 폼</h2>
    <div class="inputForm">
      <table class="box">
 		<tr>
 			<td>글쓴이</td>
 			<td><input type="text" name="writer" id="writer" value="${fDto.writer}" size="30">
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
			<td>테마</td>
				<td>
					<select name="theme">
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
 			<td>FAQ 제목</td>
 			<td><input type="text" name="subject" id="subject" value="${fDto.subject}" size="50"></td>
 		</tr>
 				
 		<tr>
 			<td>FAQ 내용</td>
 			<td><textarea name="content" id="content" rows="10" cols="50">${fDto.content}</textarea></td>
 		</tr>	
 				
 		<tr>
 			<td colspan="2" align="center">
 				<input type="submit" value="FAQ수정">
 				<input type="reset">
 				<input type="button" value="FAQ목록" onClick="location='${ctxpath}/faq/list.do'">
 			</td>
 		</tr>		
 	
 	
 	</table></div></div>
 </form>

</body>
</html>