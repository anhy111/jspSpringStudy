package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BookVO;

@Repository
public class BookDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insertBook(BookVO bookVO) {
		return this.sqlSessionTemplate.insert("book.insert",bookVO);
	}
	
	public List<BookVO> list(){
		return this.sqlSessionTemplate.selectList("book.list");
	}
	
	public BookVO selectDetail(BookVO bookVO) {
		return this.sqlSessionTemplate.selectOne("book.selectOne",bookVO);
	}
}
