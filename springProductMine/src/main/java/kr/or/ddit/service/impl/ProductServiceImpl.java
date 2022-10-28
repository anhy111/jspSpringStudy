package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProductDao;
import kr.or.ddit.service.ProductService;
import kr.or.ddit.util.FileUploadUtil;
import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductDao productDao;
	
	@Override
	public int insertProduct(ProductVO productVO) {	
		int result = this.productDao.insertProduct(productVO);
		
		if(result > 0) {
			// 파일업로드 및 insert 수행
			FileUploadUtil.fileUploadAction(productVO.getProductImage(),
					productVO.getProductId());
			
		}
		
		return result;
	}

	@Override
	public List<ProductVO> list(String keyword) {
		return this.productDao.list(keyword);
	}
	
	@Override
	public ProductVO selectDetail(ProductVO productVO) {
		return this.productDao.selectDetail(productVO);
	}
	@Override
	public int update(ProductVO productVO) {
		return this.productDao.update(productVO);
	}
	
	@Override
	public int delete(ProductVO productVO) {
		return this.productDao.delete(productVO);
	}
	
	@Override
	public int thankCustomer(CartVO cartVO) {
		
		int cartInCnt = this.productDao.insertCart(cartVO);
		log.info("cartInCnt : " + cartInCnt);
		return 0;
	}
}


