package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface BookMapper {
	public List<BookVO> list();
	public BookVO detail(String bookId);
	public int updateBook(BookVO bookVO);
	public int delete(BookVO bookVO);
	public int insert(BookVO bookVO);
	public int getBookId();
}
