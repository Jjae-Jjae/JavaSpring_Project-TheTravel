/**
 * 
 */
function gotoDetail(Num, id) {
	
	$('#pageNum').val(Num);
	$('#review_id').val(id);

	$('#godetail').submit();
}