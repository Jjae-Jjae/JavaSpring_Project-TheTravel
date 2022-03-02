<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="../module/jsp-header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>등록하기</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css"
	href="../resources/css/product/choice.css">
<title>Insert title here</title>

<style>
@font-face {
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/paybooc-Bold.woff')
		format('woff');
	font-family: 'paybooc-Bold';
	font-weight: normal;
	font-style: normal;
}

#all:hover, li:hover {
	cursor: pointer;
	background-color: rgb(255, 160, 51);
}

#reg{
	padding: 5px;
	width: 70%;
	font-size: 18px;
}


.table {
	width: 80%;
	margin: 0 auto;
}
select, option{
	font-family: 'paybooc-Bold';
	font-weight: normal;
	font-style: normal;
	font-size: 20px;
}

.table td {
	/* 	border: 1px solid black; */
	height: 50px;
	font-family: 'paybooc-Bold';
	font-weight: normal;
	font-style: normal;
	font-size: 20px;
}

.table td:nth-child(1) {
	width: 5%;
	background-color:rgb(187, 188, 241);
	padding-left:20px;
}

.table td:nth-child(2) {
	width: 50%;	

}

.table td:nth-child(2) input {
	/* line-height: 30px; */
	border: 1px solid rgb(187, 188, 241);
	height: 50px;
		font-family: 'paybooc-Bold';
	font-weight: normal;
	font-style: normal;
	font-size: 20px;
	width:100%;
}

input:focus {
	outline:none;
}
</style>
<script>
	$(function() {
		function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
		
		$(".datepicker").datepicker(
				{
					yearRange : "2021:2022", //연도 범위
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ], // 요일의 한글 형식.
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ], // 월의 한글 형식.
					dateFormat : 'yy-mm-dd'
				});
		// 		$("#reg").on("click",function(){
		// 			var count=0;
		// 			if($("input").val()==''){
		// 				alert("모두 입력해주세요");
		// 			}
		// 			alert(count);
		// 			alert("!");
		// 		return false;		
		// 		})

		

	});

	function optionChange(e) {
		var domestic = [ "수도권", "강원도", "충청도", "경상도", "전라도", "제주도", "울릉/독도" ];
		var abroad = [ "아시아", "유럽", "아프리카", "기타" ];
		var target = document.getElementById("city");

		if (e.value == "a")
			var d = domestic;
		else if (e.value == "b")
			var d = abroad;

		target.options.length = 0;

		for (x in d) {
			var opt = document.createElement("option");
			opt.value = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}
</script>
</head>
<body>



	<form method="post" action="${ctxpath}/product/upload.do"
		enctype="multipart/form-data">
		<table class=table>
			<!-- 			<tr> -->
			<!-- 				<td>상품id</td> -->
			<!-- 				<td><input type=text name=id readonly></td> -->
			<!-- 			</tr> -->
			<tr>
				<td>여행상품명</td>
				<td><input type=text name=name required></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type=text name=price required></td>
			</tr>
			<tr>
				<td>국가</td>
				<td>
				<select id="national" name=national onchange="optionChange(this)">
						<option>선택하세요</option>
						<option value="a">국내</option>
						<option value="b">해외</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>여행도시</td>
				<td><select id=city name=city>
						<option>선택하세요.</option>
				</select></td>
			</tr>
			<tr>
				<td>출발 날짜</td>
				<td><input type=text class="datepicker" name=start required></td>
			</tr>
			<tr>
				<td>도착 날짜</td>
				<td><input type=text class="datepicker" name=end required></td>
			</tr>
			<tr>
<!-- 				<td>사진 첨부</td> -->
				<td><input type="file" name="file" /></td>
			</tr>
			<tr>
			  <td colspan="2" align="center">
				  <input type=submit id=reg value=등록하기>
			  </td>
			</tr>

		</table>
		
	</form>
</body>
</html>