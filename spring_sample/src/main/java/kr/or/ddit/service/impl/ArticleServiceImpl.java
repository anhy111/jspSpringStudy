package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ArticleMapper;
import kr.or.ddit.service.ArticleService;
import kr.or.ddit.vo.ArticleVO;

@Service
public class ArticleServiceImpl implements ArticleService {
	//DI(Dependency(의존성) Injection(주입))
	@Inject
	private ArticleMapper articleMapper;
	
	//글 입력
	@Override
	public int insert(ArticleVO articleVO) {
		return this.articleMapper.insert(articleVO);
	}
	
	//글 목록
	@Override
	public List<ArticleVO> list(Map<String,String> map){
		return this.articleMapper.list(map);
	}
	
	//전체 행의 수(total). map : {show=10, cond=title, keyword=개똥이, currentPage=2} 포함
	@Override
	public int getTotal(Map<String,String> map) {
		return this.articleMapper.getTotal(map);
	}
	
	//글 상세보기 
	@Override
	public ArticleVO detail(int articleNo) {
		return this.articleMapper.detail(articleNo);
	}
	
	//글 수정하기
	@Override
	public int update(ArticleVO articleVO) {
		return this.articleMapper.update(articleVO);
	}
	
	//글 삭제하기
	@Override
	public int delete(int articleNo) {
		return this.articleMapper.delete(articleNo);
	}
}














