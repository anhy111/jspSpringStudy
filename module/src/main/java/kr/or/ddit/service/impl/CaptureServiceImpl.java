package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.CaptureDao;
import kr.or.ddit.service.CaptureService;
import kr.or.ddit.vo.CaptureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CaptureServiceImpl implements CaptureService{
	
	@Autowired
	CaptureDao captureDao;
	

	@Override
	public int insert(CaptureVO captureVO) {
		return this.captureDao.insert(captureVO);
	}
	
	@Override
	public List<CaptureVO> select(CaptureVO captureVO) {
		return this.captureDao.select(captureVO);
	}
	
}
