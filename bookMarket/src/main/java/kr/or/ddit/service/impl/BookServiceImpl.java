package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.BookDao;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;


@Service
public class BookServiceImpl implements BookService{
	@Autowired
	BookDao bookDao;
	
	@Override
	public int insertBook(BookVO bookVO) {
		return this.bookDao.insertBook(bookVO);
	}
	
	@Override
	public List<BookVO> list() {
		return this.bookDao.list();
	}
	
	@Override
	public BookVO selectDetail(BookVO bookVO) {
		return this.bookDao.selectDetail(bookVO);
	}
}
