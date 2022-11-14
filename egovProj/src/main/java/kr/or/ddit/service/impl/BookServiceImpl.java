package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	BookMapper bookMapper;
	
	@Override
	public List<BookVO> list() {
		return bookMapper.list();
	}
	
	@Override
	public BookVO detail(String bookId) {
		return bookMapper.detail(bookId);
	}
	
	@Override
	public int update(BookVO bookVO) {
		return bookMapper.updateBook(bookVO);
	}
	
	@Override
	public int delete(BookVO bookVO) {
		return bookMapper.delete(bookVO);
	}
	
	@Override
	public int insert(BookVO bookVO) {
		return bookMapper.insert(bookVO);
	}
	
	@Override
	public int getBookId() {
		return bookMapper.getBookId();
	}
}
