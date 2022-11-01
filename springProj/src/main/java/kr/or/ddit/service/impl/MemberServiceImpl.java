package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.dao.BookDao;
import kr.or.ddit.dao.MemberDao;
import kr.or.ddit.service.BookService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.util.FileUploadUtil;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	FileUploadUtil fileUploadUtil;
	
	
	@Override
	public List<MemVO> list() {
		return this.memberDao.list();
	}
	
	@Override
	public int insertMem(MemVO memVO) {
		int result = this.memberDao.insertMem(memVO);
		if(result > 0) {
			// 파일업로드 및 insert 수행 1)
//			FileUploadUtil.fileUploadAction(productVO.getProductImage(),
//					productVO.getProductId());
			
			// 파일업로드 및 insert 수행 2)
			fileUploadUtil.fileUploadAction(memVO.getMemImage(),
					memVO.getMemId());
		}
		return result;
	}
	
	// 메서드에 트랜잭션 애너테이션 부여
	/*
		회원 정보를 저장하다가 실패하거나 주소 정보를 저장하다가 실패하거나
		카드 정보를 저장하다가 실패하면 모두 저장이 되지 않고 rollback됨
	 */
	@Transactional
	@Override
	public int memberInsert(MemberVO memberVO) {
		this.memberDao.memberInsert(memberVO);
		this.memberDao.addressInsert(memberVO);
		
		List<CardVO> cardVOList = memberVO.getCardVOList();
		log.info("memberVO : " + memberVO);
		List<CardVO> cardVOList2 = new ArrayList<CardVO>();
		
		for(CardVO vo : cardVOList) {
			vo.setUserId(memberVO.getUserId());
			
			cardVOList2.add(vo);
		}
		
		return this.memberDao.insertCard(cardVOList2);
		
	}
	
	
}
