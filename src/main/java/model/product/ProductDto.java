package model.product;



public class ProductDto {

	private String id;
	private String name;
	private int price;
	private String national;
	private String city;
	private String start;
	private String end;
	private String filename;
	
	

	public ProductDto(String id, String name, int price, String national, String city, String start, String end,
			String filename) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.national = national;
		this.city = city;
		this.start = start;
		this.end = end;
		this.filename = filename;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getNational() {
		return national;
	}
	public void setNational(String national) {
		this.national = national;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}

	public ProductDto() {
		super();
	}
	
	
	
}
