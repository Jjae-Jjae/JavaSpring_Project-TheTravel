package model.notice;

public class NoticeSearchDto {
	private String searchText;
	private String category;
	private String pageNum;

	public NoticeSearchDto() {}

	public String getSearchText() {
		return searchText;
	}

	public String getCategory() {
		return category;
	}
	
	public String getPageNum() {
		return pageNum;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}	
		
}
