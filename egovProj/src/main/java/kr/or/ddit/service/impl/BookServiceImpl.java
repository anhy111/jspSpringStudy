package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
//		return bookMapper.updateBook(bookVO);
		log.info("Before bookVO : " + bookVO);
		
		int result = bookMapper.insert(bookVO);
		
		log.info("after bookVO : " + bookVO);
		
		return result;
		
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
	
	@Override
	public List<BookVO> searchBook(BookVO bookVO) {
		return bookMapper.searchBook(bookVO);
	}
}
