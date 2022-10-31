package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

// 서비스 interface : 비즈니스 로직
public interface BookService {
	public int insert(BookVO bookVO);
	public BookVO selectDetail(BookVO bookVO);
	public List<BookVO> list(String keyword);
	public int update(BookVO bookVO);
	public int delete(int bookId);
	public int insertAttach(List<AttachVO> attachVOList);
}
