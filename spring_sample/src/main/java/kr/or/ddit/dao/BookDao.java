package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BookVO;

//매퍼xml(book_SQL.xml)을 실행시키는 
//DAO(Data Access Object) 클래스
//Repository 어노테이션 : 데이터에 접근하는 클래스
//스프링이 데이터를 관리하는 클래스라고 인지하여 자바빈으로 등록하여 관리함
@Repository
public class BookDao {
	//DI(Dependency Injection) : 의존성 주입
	//new 키워드를 통해 직접 생성하지 않고!!!
	//스프링이 미리 만들어 놓은(서버 실행 시 스프링이 미리 xml을 읽어
	//객체를 인스턴스화 해놓음)
	//sqlSessionTemplate 타입 객체를 BookDao 객체에 주입함
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	//<insert id="insert" parameterType="bookVO">
	public int insert(BookVO bookVO) {
		//book_SQL.xml 파일의 namespace가 book이고, id가 insert인
		//태그를 찾아 그 안에 들어있는 sql을 실행함
		//bookVO=>{"bookId":"","title":"총알탄 개똥이","category":"소설","price":10000,"insertDate":""}
		//insert,update,delete는 반영된 건수가 return됨
		//insert성공 : 1이상, 실패면 0
		int bookId = 0;
		int result = this.sqlSessionTemplate.insert("book.insert",bookVO);
		if(result>0) {//insert성공
			bookId = bookVO.getBookId();
		}else {
			bookId = 0;
		}
		//selectKey에 의해 생성된 기본키 값을 리턴해줌
		//bookVO(후)=>{"bookId":"1","title":"총알탄 개똥이","category":"소설","price":10000,"insertDate":""}
		return bookId;
	}
	
	//책 상세보기(p.71)
	public BookVO selectDetail(BookVO bookVO) {
		//쿼리를 실행해주는 객체?(힌트 : root_context.xml)
		//selectOne() 메소드 : 1행을 가져올 때 사용 / selectList() 메소드 : 결과 집합 목록 반환(다중행)
		//결과 행 수가 0일 때? null을 반환
		//결과 행 수가 2 이상일 때? TooManyResultsException 예외 발생
		//selectOne("namespace.id", 파라미터)
		return this.sqlSessionTemplate.selectOne("book.select_detail",bookVO);
	}
	
	//책 수정하기
	public int update(BookVO bookVO) {
		//update("namespace.id", 파라미터)
		return this.sqlSessionTemplate.update("book.update", bookVO);
	}
	
	//책 삭제하기
	public int delete(BookVO bookVO) {
		//delete("namespace.id",파라미터)
		return this.sqlSessionTemplate.delete("book.delete", bookVO);
	}
	
	//책 목록보기
	public List<BookVO> list(String keyword){
		//select결과를 목록으로 받음. selectList("namespace.id",파라미터)
		return this.sqlSessionTemplate.selectList("book.select_list", keyword);
	}
	
}


























