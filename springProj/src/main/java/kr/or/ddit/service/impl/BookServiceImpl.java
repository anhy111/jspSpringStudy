package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.BookDao;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

@Service
public class BookServiceImpl implements BookService{
	// 객체를 스프링이 관리해줌.
	// db접글을 위해 dao 인스턴스를 주입받는다.
	@Autowired
	BookDao bookDao;
	
	@Override
	public int insert(BookVO bookVO) {
		return this.bookDao.insert(bookVO);
	}
	
	@Override
	public BookVO selectDetail(BookVO bookVO) {
		return this.bookDao.selectDetail(bookVO);
	}
	
	@Override
	public List<BookVO> list(String keyword) {
		return this.bookDao.list(keyword);
	}
	
	@Override
	public int update(BookVO bookVO) {
		return this.bookDao.update(bookVO);
	}
	
	@Override
	public int delete(int bookId) {
		return this.bookDao.delete(bookId);
	}
	
	@Override
	public int insertAttach(List<AttachVO> attachVOList) {
		return this.bookDao.insertAttach(attachVOList);
	}
}
