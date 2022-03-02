<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../module/jsp-header.jsp" %>
<%-- updateForm.jsp --%>

<%-- 임시 테스트 admin 처리 --%>
<%
session.setAttribute("userId", "admin");  
String userId = (String)session.getAttribute("userId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="../resources/css/notice/style.css">

<script type="text/javascript">

function init(){
	//분류 콤보박스 : 화면로드 시 서버에서 받아온 값으로 선택해준다. 
	dbOptVal = "${dto.category}";
	
	optCount = document.updateForm.category.options.length;
	
	for(i=0; i < optCount; i++) {
		optVal = document.updateForm.category.options[i].value;
	
		if(dbOptVal == optVal){ //서버에서 받아온 값과 같으면 select 처리
			document.updateForm.category.options[i].selected = "selected";
		}
	}
}
	
</script>
</head>
<body onLoad="init()">

<c:if test="${'admin' ne sessionScope.userId}">
	<h2>관리자 권한이 필요합니다</h2>
</c:if>

<c:if test="${'admin' eq sessionScope.userId}">	
	<form name="updateForm" method="post" action="${ctxpath}/notice/updatePro.do?num=${num}&pageNum=${pageNum}">
<div align="center">
    <div class="inputForm">
      <table class="box">      
		  <tr>
		    <td>
		<table width="60%" height ="80" cellpadding="2">
			<tr>
				<td align="left">
					<font size="+2">
						<strong>공지사항</strong>
					</font>
				</td>
		
				<td align="right">
					<input type="submit" value="수정">&nbsp;
					<input type="reset" value="취소">&nbsp;
					<input type="button" value="목록" onClick="location='${ctxpath}/notice/list.do?pageNum=${pageNum}'">
				</td>
			</tr>
		</table>		
		
		<table width="80%" cellpadding="3" class="box">
			<tr>
				<td width="100">작성자</td>
				<td><input style="border: none; width: 100%;" type="text" name="writer" id="writer" value="${dto.writer}" size="30"></td>
			</tr>
			
			<tr>
				<td>제목</td>
				<td><input style="border: none; width: 100%;" type="text" name="subject" id="subject" value="${dto.subject}" size="70"></td>
			</tr>
					
			<tr>
				<td>분류</td>
				<td>
					<table align="left">
						<tr>					
							<td  >
								<select style="border: 1; width: 100%;" name="category" id="category" value="${dto.category}">
									<option value="">선택하세요</option>								
									<option value="국제선">국제선</option>
									<option value="국내선">국내선</option>
									<option value="패키지">패키지</option>
									<option value="자유여행">자유여행</option>
								</select>													
							</td>
						</tr>
					</table>			
				</td>
			</tr>		
					
			<tr>
				<td>내용</td>
				<td>
					<textarea style="width: 100%; resize: none;" rows="10" cols="50" name="content" id="content"> ${dto.content}</textarea>
				</td>
			</tr>	
							
		</table>
       </td></tr>
     </table>
     </div>
     </div>
	</form>
</c:if>

</body>
</html>