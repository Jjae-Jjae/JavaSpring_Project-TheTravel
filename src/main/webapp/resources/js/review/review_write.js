function  file_div(){
	var files=$('input[name="file"]')[0].files;
	var msg = "";

	for(var i= 0; i<files.length; i++){
        msg = msg + files[i].name + "\n";
    }
	$('#file_box').val(msg);

}