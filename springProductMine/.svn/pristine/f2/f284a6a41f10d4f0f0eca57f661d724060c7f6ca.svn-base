package kr.or.ddit.vo;

import java.io.Serializable;

// ProductVO : PRODUCT 테이블의 1행을 담는다.
// VO : Value Object
// 자바빈 클래스 (멤버변수, 기본생성자, getter/setter 메소드) 
// => 이 3 가지가 자바빈 규약(프로토콜)을 지켰다고 본다
// implements Serializable : 직렬화. 인터페이스를 상속받음(생략가능)
public class ProductVO implements Serializable{
	// 생략가능
	private static final long serialVersionUID = -42747005203867000L;
	
	// 멤버변수
	private String productId; // 상품 아이디(PRODUCT테이블의 PRODUCT_ID 컬럼)
	private String pname; // 상품명
	private int unitPrice; // 상품가격
	private String description; // 상품 설명
	private String manufacturer; // 제조사
	private String category; // 분류
	private int unitInStock; // 재고수
	private String condition; // 신상품 or 중고품 or 재생품
	
	// ch07에서 추가함
	private String filename; // 이미지 파일명
	

	// ch13에서 추가함
	private int quantity; // 장바구니에 상품을 담은 개수
	

	// 기본생성자
	public ProductVO() {}
	
	// 상품 아이디, 상품명, 상품 가격 파라미터들을 매개변수로 받는 생성자 -> 멤버변수에 할당
	public ProductVO(String productId, String pname, int unitPrice) {
		this.productId = productId;
		this.pname = pname;
		this.unitPrice = unitPrice;
	}
	
	// getter / setter 메소드
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

	public int getUnitInStock() {
		return unitInStock;
	}

	public void setUnitInStock(int unitInStock) {
		this.unitInStock = unitInStock;
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

	public String getFilename() {
		return filename;
	}
	
	public void setFilename(String filename) {
		this.filename = filename;
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
				+ description + ", manufacturer=" + manufacturer + ", category=" + category + ", unitInStock="
				+ unitInStock + ", condition=" + condition + ", filename=" + filename + ", quantity=" + quantity + "]";
	}
	
}
