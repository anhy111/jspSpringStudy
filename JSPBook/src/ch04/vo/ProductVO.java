package ch04.vo;

import java.io.Serializable;

// ProductVO : PRODUCT 테이블의 1행을 담음
// VO : Value Object 
// 자바빈 클래스(멤버변수, 기본생성자, getter/setter)
// implements Serializable : 직렬화 인터페이스 구현
public class ProductVO implements Serializable {
	// 생략가능
	private static final long serialVersionUID =
				-4274700572038677000L;
	
	// 멤버변수
	private String productId;	// 상품 아이디(PRODUCT테이블의 PRODUCT_ID 컬럼)
	private String pname;	// 상품명
	private int unitPrice; // 상품가격
	private String description; // 상품설명
	private String manufacturer; //제조사
	private String category; //분류
	private int unitsInStock;	// 재고수
	private String condition;	// 신상품 or 중고품 or 재생품
	
	// ch07에서 추가
	private String fileName;	// 이미지 파일명
	
	// ch 13에서 추가
	private int quantity;	// 장바구니에 담은 개수
	
	// 기본생성자
	public ProductVO() {}
	
	public ProductVO(String productId, String pname, int unitPrice) {
		this.productId = productId;
		this.pname = pname;
		this.unitPrice = unitPrice;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getUnitsInStock() {
		return unitsInStock;
	}

	public void setUnitsInStock(int unitsInStock) {
		this.unitsInStock = unitsInStock;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "ProductVO [productId=" + productId + ", pname=" + pname + ", unitPrice=" + unitPrice + ", description="
				+ description + ", manufacturer=" + manufacturer + ", category=" + category + ", unitsInStock="
				+ unitsInStock + ", condition=" + condition + ", fileName=" + fileName + ", quantity=" + quantity + "]";
	}
	
	
	
}
