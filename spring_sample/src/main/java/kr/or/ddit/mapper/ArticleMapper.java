package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ArticleVO;

public interface ArticleMapper {
	//글 입력
	public int insert(ArticleVO articleVO);
	//글 목록
	public List<ArticleVO> list(Map<String,String> map);
	//전체 행의 수(total). map : {show=10, cond=title, keyword=개똥이, currentPage=2} 포함
	public int getTotal(Map<String,String> map);
	//글 상세보기 
	public ArticleVO detail(int articleNo);
	//글 수정하기
	public int update(ArticleVO articleVO);
	//글 삭제하기
	public int delete(int articleNo);
}
