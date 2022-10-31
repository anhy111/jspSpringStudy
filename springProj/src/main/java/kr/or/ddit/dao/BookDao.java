package kr.or.ddit.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

// 매퍼xml(book_SQL.xml)을 실행시키는
// DAO(Data Access Object) 클래스
// Repository 어노테이션 : 데이터에 접근하는 자바빈 객체로 스프링에 등록해줌
@Repository
public class BookDao {
	// 1. DI(Dependency Injection) : 의존성 주입
	// new 키워드를 통해 직접 생성하지 않고 
	// 스프링이 미리 만들어 놓은(서버 실행 시 미리 root-context.xml을 읽어서
	//						자바빈 객체로 인스턴스화 해놓음)
	//	sqlSessionTemplate 타입 객체를 BookDao 객체에 주입하여 사용
	// 2. IoC(Inversion of Control) : 제어의 역전
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insert(BookVO bookVO) {
		// namespace.id 태그 실행
		// insert, update, delete의 결과로 0 또는 1이상(반영개수) 반환
		return this.sqlSessionTemplate.insert("book.insert",bookVO);
	}
	
	public BookVO selectDetail(BookVO bookVO) {
		// sqlSessionTemplate : 쿼리를 실행해주는객체(root-context.xml)
		// selectOne() 메서드 : 1행을 가져올 때 사용/ selectList()메서드 : 결과 집합 목록 변환(다중행)
		// 결과 행 수가 0이면? null 반환
		// 결과 행 수가 2이상이면? TooManyResultsException 예외 발생
		// .selectOne("namespace.id", 파라미터)
		return this.sqlSessionTemplate.selectOne("book.select_detail",bookVO);
	}
	
	public List<BookVO> list(String keyword) {
		return this.sqlSessionTemplate.selectList("book.list", keyword);
	}
	
	public int update(BookVO bookVO) {
		return this.sqlSessionTemplate.update("book.update",bookVO);
	}
	
	public int delete(int bookId) {
		return this.sqlSessionTemplate.delete("book.delete",bookId);
	}
	public int insertAttach(List<AttachVO> attachVOList) {
		return sqlSessionTemplate.update("book.insertAttach", attachVOList);
	}
}
