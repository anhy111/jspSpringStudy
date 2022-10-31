package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.BookDao;
import kr.or.ddit.dao.MemberDao;
import kr.or.ddit.service.BookService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.MemVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberDao memberDao;
	
	
	@Override
	public List<MemVO> list() {
		return this.memberDao.list();
	}
	
}
