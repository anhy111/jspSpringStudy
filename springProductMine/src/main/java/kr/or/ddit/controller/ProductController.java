package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
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
	
	@RequestMapping(value = "/cart",method = RequestMethod.GET)
	public String cartList(ModelAndView mav) {
		
		return "product/cart";
	}
	
	@ResponseBody
	@RequestMapping(value = "/addCart/{productId}",method = RequestMethod.GET)
	public String addCart(HttpSession session, @PathVariable("productId") String productId){
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartlist");
		
		ProductVO productVO = new ProductVO();
		productVO.setProductId(productId);
		
		productVO = productService.selectDetail(productVO);
		if(cartList == null) {
			cartList = new ArrayList<ProductVO>();
		}
		
		boolean exist = false;
		for(ProductVO pv : cartList) {
			if(pv.getProductId().equals(productId)) {
				int quantity = pv.getQuantity();
				
				pv.setQuantity(++quantity);
				exist = true;
				break;
			}
		}
		
		if(!exist) {
			int quantity = productVO.getQuantity();
			productVO.setQuantity(++quantity);
			cartList.add(productVO);
		}
		
		session.setAttribute("cartlist", cartList);
		
		return "complite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/removeCart/{productId}",method = RequestMethod.GET)
	public String removeCart(HttpSession session, @PathVariable("productId") String productId){
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartlist");
		
		for(ProductVO pv : cartList) {
			if(pv.getProductId().equals(productId)) {
				cartList.remove(pv);
			}
		}
		
		return "complite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteCart",method = RequestMethod.GET)
	public String deleteCart(HttpSession session){
		
		
		session.removeAttribute("cartlist");
		
		
		return "complite";
	}
}
