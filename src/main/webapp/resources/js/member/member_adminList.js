	function goUserInfo(mem_id) {

		var userForm = $("#userInfoForm");
		userForm.append($('<input/>', {type: 'hidden', name: 'mem_id', id: 'mem_id' , value:mem_id }));
		userForm.submit();
	}
	
	function goUserDel(mem_id, level) {
		
		if(confirm(mem_id+'를 강퇴 하시겠습니까??')){
		var userForm = $("#userDelForm");
		userForm.append($('<input/>', {type: 'hidden', name: 'mem_id', id: 'mem_id' , value:mem_id }));
		userForm.append($('<input/>', {type: 'hidden', name: 'level', id: 'level' , value:level }));
		userForm.submit();
		}
	}
	
	 function Del() {
	 	return confirm('강퇴 하시겠습니까??')
	}
 	function check() {
	 	return confirm('레벨을 변경하시겠습니까?')
	}