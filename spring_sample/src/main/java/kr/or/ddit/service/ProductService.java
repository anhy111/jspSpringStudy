package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ProductVO;

public interface ProductService {
	//메소드 시그니처
	//상품 등록
	public int insert(ProductVO productVO);
	//상품 목록
	public List<ProductVO> list();
	//상품 상세
	public ProductVO detail(String productId);
	
}
