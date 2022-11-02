package kr.or.ddit.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.CaptureVO;

@Repository
public class CaptureDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<CaptureVO> select(CaptureVO captureVO) {
		return this.sqlSessionTemplate.selectList("capture.select", captureVO);
	}
	

	public int insert(CaptureVO captureVO) {
		return this.sqlSessionTemplate.insert("capture.insert",captureVO);
	}
	

}
