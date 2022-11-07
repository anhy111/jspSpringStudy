package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//자바빈 클래스 -> 1) 멤버변수 2) 기본생성자 3) getter/setter메소드
//PoJo(Plain oriented Java Object : 본연의 자바를 사용하자)에 어긋남..
@Data
public class ProductVO {
	//멤버변수
	private String productId;
	private String pname;
	private int unitPrice;
	private String description;
	private String manufacturer;
	private String category;
	private int unitsInStock;
	private String condition;
	private String filename;
	private int quantity;
	private MultipartFile[] productImage;	//첨부파일
}
