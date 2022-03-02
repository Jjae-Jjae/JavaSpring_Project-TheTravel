	var flag = 0; //id 중복체크 플래그
	
	
	function openDaumPostcode(){
	   new daum.Postcode({
	      oncomplete:function(data){
	         document.getElementById('zipcode').value=data.zonecode;
	         document.getElementById('addr').value=data.address;
	       }
	   }).open();
	}//openDaumPostcode()---

	function confirmIdCheck(){
	    if($('#id').val()==''){
       alert("ID를 입력하세요");
    }else{
      $.ajax({
         type:'POST',
         url:'../member/idCheck.do',
         data:"id="+$('#id').val(),
         dataType:'JSON',
         success:function(data){            
            if(data.check==-1){
               alert("사용 중인 ID입니다.");
               $('#id').val('').focus();
               flag = 0
            }else if(data.check==1){//사용가능한
               //$('#idcheck').val('1');//id중복 체크가 되었을때 
               alert("사용 가능 한 ID입니다.");
               $('#pw').focus();
               flag = 1;
            }
         }
       });
    }//else end
 }//confirmIdCheck() end

	function check(){
	 //데이터 유효성 체크
	 if($('#id').val()==''){
		 alert("ID를 입력 하세요");
		 $('#id').focus();
		 return false;
	 }
	 
	 if(flag != 1){
	     alert("ID중복체크를 진행해 주세요");
		 $('#id').focus();
		 return false;
	 }
	
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
		 alert("암호와 암호 확인이 일치하지 않습니다 . 다시 입력 하세요");
		 $('#pw2').val('');
		 $('#pw').val('').focus();
		 return false;
	 }
	 
	 if($('#name').val()==''){
		 alert("이름을 입력 하세요");
		 $('#name').focus();
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
             $("#tel3").val("");
             $("#telConfirm").show();
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
                 $("#nameConfirm1").text(String + "님 환영합니다");
             } else {
                 $("#nameConfirm1").hide();
                 $("#nameConfirm2").show();
                 $("#name").val("");
                 //$("#name").focus();
             }
         }
     })

     $("#idConfirm1").hide();
     $("#id").on("blur", function () {
         if ($("#id").val() != "") {
             var String = $("#id").val();
             var reg = /^[a-z][a-z0-9]{5,14}$/g;
             var result = reg.exec(String);
             if (!result) {
                 $("#idConfirm1").show();
                 $("#idConfirm2").hide();
                 $("#id").val("");
                 // $("#id").focus();
             } else {
                 $("#idConfirm1").hide();
                 $("#idConfirm2").hide();
             }
         }
     })

     $("#pwConfirm2").hide();
     $("#pw").on("blur", function () {
         if ($("#pw").val() != "") {
             var String = $("#pw").val();
             var reg =
                 /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{7,12}$/g;
             var result = reg.exec(String);
             if (!result) {
                 $("#pwConfirm1").hide();
                 $("#pwConfirm2").show();
                 $("#pw").val("");
                 // $("#password1").focus();
             } else {
                 $("#pwConfirm1").hide();
                 $("#pwConfirm2").hide();
             }
         }
     })

     $("#pwConfirm3").hide();
     $("#pwConfirm4").hide();
     $("#pw2").on("blur", function () {
         if ($("#password2").val() != "") {

             if ($("#pw").val() == $("#pw2").val() && $("#pw").val() != "") {
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