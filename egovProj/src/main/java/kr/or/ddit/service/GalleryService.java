package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

public interface GalleryService {
	public BookVO list(BookVO bookVO);
	public int attachUpdate(AttachVO attachVO);
	public int attahcDelete(AttachVO attachVO);
}
