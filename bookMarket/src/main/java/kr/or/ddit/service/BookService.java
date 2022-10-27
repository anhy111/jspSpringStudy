package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface BookService {
	public int insertBook(BookVO bookVO);
	public List<BookVO> list();
	public BookVO selectDetail(BookVO bookVO);
}
