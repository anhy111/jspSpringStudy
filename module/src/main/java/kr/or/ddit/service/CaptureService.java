package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CaptureVO;

// 서비스 interface : 비즈니스 로직
public interface CaptureService {
	public List<CaptureVO> select(CaptureVO captureVO);
	public int insert(CaptureVO captureVO);
}
