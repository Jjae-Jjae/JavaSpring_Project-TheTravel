  function check(){
	  if($('#id').val()==''){
		 alert("ID를 입력 하세요");
		 $('#id').focus();
		 return false;
	 }
	
	 if($("#pw").val()==''){
		 alert("암호를 입력 하세요");
		 $("#pw").focus();
		 return false;
	 }
	  return true;
  }
  
  function checkChange(userPw){
    if($('#id').val()==''){
		 alert("ID를 입력 하세요");
		 $('#id').focus();
		 return false;
	 }
  
     if($("#pw").val()==''){
		 alert("현재암호를 입력 하세요");
		 $("#pw").focus();
		 return false;
	 }
	 
     if($("#pw2").val()==''){
		 alert("변경 암호를 입력 하세요");
		 $("#pw2").focus();
		 return false;
	 }
	 
	 if($("#pw3").val()==''){
		 alert("암호확인를 입력 하세요");
		 $("#pw3").focus();
		 return false;
	 }
	 
	 if($('#pw2').val() != $('#pw3').val()){
		 alert("암호와 암호 확인이 일치하지 않습니다 . 다시 입력 하세요");
		 $('#pw3').val('');
		 $('#pw2').val('').focus();
		 return false;
	 }
	 
	 if($('#pw').val() == $('#pw3').val()){
		 alert("이전암호와 같습니다 . 다시 입력 하세요");
		 $('#pw3').val('');
		 $('#pw2').val('').focus();
		 return false;
	 }
	 
	 if($('#pw').val() != userPw ){
		 alert("암호를 틀렸습니다");
		 $('#pw').val('');
		 $('#pw').val('').focus();
		 return false;
	 }
	 
	 return true;
  }
  
$(function () {
     $("#pwConfirm2").hide();
     $("#pw2").on("blur", function () {
         if ($("#pw2").val() != "") {
             var String = $("#pw2").val();
             var reg = 
                 /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{7,12}$/g;
             var result = reg.exec(String);
             if (!result) {
                 $("#pwConfirm1").hide();
                 $("#pwConfirm2").show();
                 $("#pw2").val("");
                 // $("#password1").focus();
             } else {
                 $("#pwConfirm1").hide();
                 $("#pwConfirm2").hide();
             }
         }
     })

     $("#pwConfirm3").hide();
     $("#pwConfirm4").hide();
     $("#pw3").on("blur", function () {
         if ($("#password2").val() != "") {

             if ($("#pw2").val() == $("#pw3").val() && $("#pw2").val() != "") {
                 $("#pwConfirm3").show();
                 $("#pwConfirm4").hide();
             } else {
                 $("#pwConfirm3").hide();
                 $("#pwConfirm4").show();
                 $("#pwConfirm4").val("");
                 //  $("#pwConfirm4").focus();
             }
         }
     })


 })