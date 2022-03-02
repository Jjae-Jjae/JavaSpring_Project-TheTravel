<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
<%-- ReviewWrite.jsp --%>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${ctxpath}/resources/css/review/review.css">

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${ctxpath}/resources/js/review/review_write.js"></script>

</head>
<body>
<div align="center">
<font size="5" >리뷰쓰기<br><br></font>

<form method="post" id="writeForm" name="writeForm" action="${ctxpath}/review/writePro.do?" enctype="multipart/form-data">
  <table class="box card">
    <tr>
      <td colspan="2" align="center">
      </td>
    </tr>
    <tr valign="middle">
      <td align="center">
        <div id="score">
		<select name="score" id="score">
		  <option value="0">☆☆☆☆☆</option>
		  <option value="1">★☆☆☆☆</option>
		  <option value="2">★★☆☆☆</option>
		  <option value="3">★★★☆☆</option>
		  <option value="4">★★★★☆</option>
		  <option value="5">★★★★★</option>
		</select>
		</div>
	  </td>
    </tr>
    
    <tr valign="middle" >
      <td align="center"><textarea rows="50" cols="100" name="content" id="content" class="content_box" placeholder="리뷰를 작성해 주세요!"></textarea></td>
    </tr>
    
    <tr>
      <td align="left">
        <div class="filebox">
            <label for="file"><img src="${ctxpath}/resources/imgs/review/camera.PNG"> 업로드</label>
            <input type="file" name="file" id="file" multiple="multiple" accept=".gif, .jpg, .png" onchange="file_div()">
          <textarea rows="50" cols="100" id="file_box" placeholder="업로드 사진 목록"></textarea>
        </div>
      </td>
    </tr>
    <tr>
      <td>
      <div class="container">
	        <div class="item deleForm_div">
	          <input type="submit" value="등록" class="div_btn">
	        </div>
	        <div class="item deleForm_div">
	          <input type="reset" class="div_btn">
	        </div> 
	  	  </div>
      </td>
    </tr>
  </table>
<input type="hidden" name="pro_no" id="pro_no" value="${pro_no}"> 
<input type="hidden" name="review_id" id="review_id" value="${review_id}"> 
<input type="hidden" name="writer" id="writer" value="${sessionScope.userId}"> 
</form>
</div>
</body>
</html>