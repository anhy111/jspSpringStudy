package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;
import kr.or.ddit.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public ModelAndView addProduct(ModelAndView mav) {
		mav.setViewName("product/addProduct");
		
		return mav;
	}
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public ModelAndView addProductPost(ModelAndView mav, @ModelAttribute ProductVO productVO) {
		int result = this.productService.insertProduct(productVO);
		
		if(result > 0) { //입력 성공
			mav.setViewName("redirect:/detail?productId=" + productVO.getProductId());
		}else { //입력 실패
			mav.setViewName("redirect:/addproduct");
		}
		
		return mav;
	}
	

	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView mav,
				@RequestParam(value = "keyword", required = false) String keyword) {
		
		List<ProductVO> data = this.productService.list(keyword);
		
		mav.setViewName("product/products");
		mav.addObject("data", data);
		
		return mav;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, ProductVO productVO) {
		ProductVO data = this.productService.selectDetail(productVO);
		
		mav.setViewName("product/product");
		mav.addObject("data",data);
		mav.addObject("productId", data.getProductId());
		return mav;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(ProductVO productVO, ModelAndView mav) {
		
		ProductVO data = this.productService.selectDetail(productVO);
		
		mav.addObject("data",data);
		
		mav.setViewName("product/update");
		return mav;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView updatePost(@ModelAttribute ProductVO productVO, ModelAndView mav) {
		
		int result = this.productService.update(productVO);
		log.info("Condition:" + productVO.getCondition());
		if(result > 0) {
			mav.setViewName("redirect:/detail?productId="+productVO.getProductId());
		} else {
			mav.setViewName("redirect:/update?productId="+productVO.getProductId());			
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/delete",method = RequestMethod.GET)
	public ModelAndView delete(ModelAndView mav,
						@ModelAttribute ProductVO productVO) {
		
		int result = this.productService.delete(productVO);
		
		if(result > 0) {
			mav.setViewName("redirect:/products");
		} else {
			mav.setViewName("redirect:/detail?productId="+productVO.getProductId());			
		}
		
		return mav;
	}
	
	
}
