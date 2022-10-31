package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.ProductVO;

public interface ProductService {
	//메소드 시그니처
	
	//PRODUCT 테이블에 insert
	public int insertProduct(ProductVO productVO);
	public List<ProductVO> list(String keyword);
	public ProductVO selectDetail(ProductVO productVO);
	public int update(ProductVO productVO);
	public int delete(ProductVO productVO);
	// cart 및 cart_det 테이블에 insert
	public int thankCustomer(CartVO cartVO);
	
	public int insertAttach(List<AttachVO> attachVOList);
	public String getProductId();
}
