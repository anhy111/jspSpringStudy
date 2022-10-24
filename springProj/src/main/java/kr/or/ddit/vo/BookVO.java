package kr.or.ddit.vo;

import java.util.Date;

// 자바빈 클래스
// 1) 멤버변수 2) 기본 생성자 3) getter/setter 메소드
public class BookVO {
	
	// 1) 멤버변수
	private int bookId;      //도서코드
	private String title;    //제목
	private String category; //카테고리
	private int price;       //가격
	private Date insertDate; //입력일자
	
	// 2) 기본 생성자
	public BookVO() {}
	
	// 3) getter/setter 메소드
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	@Override
	public String toString() {
		return "BookVO [bookId=" + bookId + ", title=" + title + ", category=" + category + ", price=" + price
				+ ", insertDate=" + insertDate + "]";
	}
	
	
}
