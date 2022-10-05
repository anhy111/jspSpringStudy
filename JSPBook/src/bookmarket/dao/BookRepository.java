package bookmarket.dao;

import java.util.ArrayList;
import java.util.List;

import bookmarket.dto.Book;
import ch04.vo.ProductVO;

public class BookRepository {
	private static BookRepository bookRepository = new BookRepository();
	public static BookRepository getInstance() {
		return bookRepository;
	}
	
	List<Book> listOfBooks;
	
	private BookRepository() {
		listOfBooks = new ArrayList<Book>();
		Book html = new Book("P2345","HTML5+CSS3",15000);
		html.setAuthor("황재호");
		html.setCategory("Hello Coding");
		html.setDescription("워드나 PPT 문서를 만들 수 있나요? 그러면 문제 없습니다. 지금 바로 페이지 제작에 도전해보세요. 지금 당장 컴퓨터가 없어도\r\n" + 
				"괜찮습니다. 코드와 실행 화면이 바로 보여서 눈으..");
		html.setPublisher("한빛미디어");
		html.setUnitsInStock(2000);
		html.setTotalPages(200);
		html.setReleaseDate("2005년05월");
		html.setFileName("P2345.jpg");
		listOfBooks.add(html);
		
		
		Book java = new Book("P2346","쉽게 배우는 자바 프로그래밍",27000);
		java.setAuthor("우종종");
		java.setCategory("IT모바일");
		java.setDescription("객체지향의 핵심과 자바의 현대적 기능을 충실히 다루면서도초보자가 쉽게 학습할 수 있게 구성했습니다. 시각화 도구를 활용\r\n" + 
				"한 개념설명과 군더더기 없는 핵심 코드를 통해 개념과 구현...");
		java.setPublisher("한빛아카데미");
		java.setUnitsInStock(2000);
		java.setTotalPages(200);
		java.setReleaseDate("2005년05월");
		java.setFileName("P2346.jpg");
		listOfBooks.add(java);
		
		Book spring = new Book("P2347","스프링 4 입문",27000);
		spring.setAuthor("하세가와 유이치, 오오노 와타루, 토키코레이(권은철 전민수)");
		spring.setCategory("IT모바일");
		spring.setDescription("스트링은 단순히 사용 방법만 익히는 것보다 아키텍처를 어떻게 이해하고 설계하는지가 더 중요합니다. 예제를 복사해 붙여넣는\r\n" + 
				"식으로는 실제 개발에서 스프링을 제대로 활용할 수 없습니다.");
		spring.setPublisher("한빛미디어 ");
		spring.setUnitsInStock(2000);
		spring.setTotalPages(200);
		spring.setReleaseDate("2005년05월");
		spring.setFileName("P2347.jpg");
		listOfBooks.add(spring);
	}
	
	public List<Book> getAllBooks(){
		return listOfBooks;
	}
	
	public Book getBookById(String bookId) {
		// 자바빈 객체 선언
		Book bookById = null;
		
		// listOfProducts의 크기만큼 반복
		/*
		P1234	iPhone 6s	800000	4.7-inch, 1334X750 Renina HD display	Smart Phone	Apple	1000	New
	 	P1235	LG PC 그램	1500000	13.3-inch, IPS LED display	Notebook	LG	1000	Refurbished
	 	P1236	Galaxy Tab S	900000	212.8*125.6*6.6mm, Super AMOLED display	Tablet	Samsung	1000	Old
		*/
		for(int i=0; i<listOfBooks.size(); i++) {
			Book vo = listOfBooks.get(i);
			if(vo==null || vo.getBookId()==null) {
				continue;
			}
			
			if(vo.getBookId().equals(bookId)) {
				bookById = vo;
				break;
			}
		}
		
		return bookById;
	}
	
	public void addBook(Book book) {
		listOfBooks.add(book);
	}
}
