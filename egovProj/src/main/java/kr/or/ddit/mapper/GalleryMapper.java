package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

public interface GalleryMapper {
	public BookVO list(BookVO bookVO);
	public int attachUpdate(AttachVO attachVO);
	public int attahcDelete(AttachVO attachVO);
}
