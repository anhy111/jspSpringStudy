package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.mapper.GalleryMapper;
import kr.or.ddit.service.BookService;
import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

@Service
public class GalleryServiceImpl implements GalleryService {
	
	@Autowired
	GalleryMapper galleryMapper;
	
	@Override
	public BookVO list(BookVO bookVO) {
		return galleryMapper.list(bookVO);
	}
	
	@Override
	public int attachUpdate(AttachVO attachVO) {
		return galleryMapper.attachUpdate(attachVO);
	}
	
	@Override
	public int attahcDelete(AttachVO attachVO) {
		return galleryMapper.attahcDelete(attachVO);
	}
}
