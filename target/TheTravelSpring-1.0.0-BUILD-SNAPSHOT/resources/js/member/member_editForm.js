	function openDaumPostcode(){
	   new daum.Postcode({
	      oncomplete:function(data){
	         document.getElementById('zipcode').value=data.zonecode;
	         document.getElementById('addr').value=data.address;
	       }
	   }).open();
	}//openDaumPostcode()---
	
	function check(){
	 if($("#pw").val()==''){
		 alert("암호를 입력 하세요");
		 $("#pw").focus();
		 return false;
	 }
	 
	 if($("#pw2").val()==''){
		 alert("암호확인를 입력 하세요");
		 $("#pw2").focus();
		 return false;
	 }
	 
	 if($('#pw').val() != $('#pw2').val()){
		 alert("암호와 암호 확인이 일티하지 않습니다 . 다시 입력 하세요");
		 $('#pw2').val('');
		 $('#pw').val('').focus();
		 return false;
	 }
	 
	 if($('#name').val()==''){
		 alert("이름을 입력 하세요");
		 $('#name').focus();
		 return false;
	 }

	 if($('#email').val()=='' || $('#email2').val()==''){
		 alert("메일을 입력 하세요");
		 $('#email').focus();
		 return false;
	 }
	 
	 if($('#tel').val()=='' || $('#tel2').val()=='' || $('#tel3').val()==''){
		 alert("번호를 입력 하세요");
		 $('#tel').focus();
		 return false;
	 }	 
	 
	 if($('#addr').val()==''){
		 alert("주소를 입력 하세요");
		 $('#addr').focus();
		 return false;
	 }
	 
	 if($('#addr2').val()==''){
		 alert("상세주소를 입력 하세요");
		 $('#addr2').focus();
		 return false;
	 }
	 return true;
	}//check()-end
	
	 $(function () {
	 
 	 $("#telConfirm").hide();
 	 $("#nameConfirm1").hide();
 	 $("#tel2").on("blur", function () {
	 	if ($("#tel2").val() != "") {
	 		var String = $("#tel2").val();
            var reg = /^[0-9]{4}$/g;
            var result = reg.exec(String);
            $("#telConfirm").show();
            if (!result) {
             $("#tel2").val("");
             $("#telConfirm").show();
             } else {
             $("#telConfirm").hide();
             }
        }
     })
     
          
     $("#tel3").on("blur", function () {
	 	if ($("#tel3").val() != "") {
	 		var String = $("#tel3").val();
            var reg = /^[0-9]{4}$/g;
            var result = reg.exec(String);
            if (!result) {
             $("#telConfirm").show();
             $("#tel3").val("");
             } else {
             $("#telConfirm").hide();
             }
          }
     })   
	
	 
     $("#nameConfirm1").hide();
     $("#nameConfirm2").hide();
     $("#name").on("blur", function () {
         if ($("#name").val() != "") {
             var String = $("#name").val();
             var reg = /^[가-힣]{2,}$/g;
             var result = reg.exec(String);
             if (result) {
                 $("#nameConfirm2").hide();
                 $("#nameConfirm1").show();
             } else {
                 $("#nameConfirm1").hide();
                 $("#nameConfirm2").show();
                 $("#name").val("");
                 //$("#name").focus();
             }
         }
     })
 
 })