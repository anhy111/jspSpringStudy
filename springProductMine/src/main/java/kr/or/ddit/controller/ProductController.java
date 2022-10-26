package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import kr.or.ddit.vo.ShippingVO;
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
	

	@RequestMapping(value = "/addCart",method = RequestMethod.POST)
	public String addCart(@RequestParam String productId,
					ModelAndView model, @ModelAttribute ProductVO productVO,
					HttpServletRequest request) {
		
		if(productId == null) {
			return "redirect:/detail?productId="+productId;
		}
		
		ProductVO vo = this.productService.selectDetail(productVO);
		
		if(vo == null) {
			return "redirect:/exceptionNoProductId";
		}
		
		HttpSession session = request.getSession();
		
		List<ProductVO> list = (List<ProductVO>)session.getAttribute("cartlist");
		
		if(list==null) {
			list = new ArrayList<>();
			
			session.setAttribute("cartlist", list);
		}
		
		int cnt = 0;	// 장바구니에 상품이 담긴 개수
		
		for(int i=0; i<list.size(); i++) {
			ProductVO pv = list.get(i);
			if(pv.getProductId().equals(productId)) {
				cnt++;
				pv.setQuantity(pv.getQuantity()+1);
			}
		}
		
		if(cnt == 0) {
			vo.setQuantity(1);
			list.add(vo);
		}
		
		for(ProductVO pv : list) {
			log.info("pv : " + pv.toString());
		}
		
		return "redirect:/detail?productId="+productId;
	}
	
	@ResponseBody
	@RequestMapping(value = "/removeCart/{productId}",method = RequestMethod.GET)
	public String removeCart(HttpSession session, @PathVariable("productId") String productId){
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartlist");
		
		for(int i=0; i<cartList.size(); i++) {
			ProductVO pv = cartList.get(i);
			if(pv.getProductId().equals(productId)) {
				cartList.remove(i);
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
	
	@RequestMapping(value = "/shippingInfo",method = RequestMethod.GET)
	public String shippingInfo(HttpSession session) {
		
		return "product/shippingInfo";
	}
	
	@RequestMapping(value = "/shippingInfo",method = RequestMethod.POST)
	public String shippingInfoPost(ShippingVO shippingVO, HttpSession session) {
		
		if(shippingVO.isNullOrEmpty()) {
			return "redirect:/shippingInfo";
		}
		
		session.setAttribute("Shipping", shippingVO);
		
		return "redirect:/orderConfirmation";
	}
	
	@RequestMapping(value = "/orderConfirmation",method = RequestMethod.GET)
	public String orderConfirmation() {
		return "product/orderConfirmation";
	}
	
	@RequestMapping(value = "/thankCustomer",method = RequestMethod.GET)
	public String thankCustomer() {
		return "product/thankCustomer";
	}
	
	@RequestMapping(value = "/checkOutCancelled",method = RequestMethod.GET)
	public String checkOutCancelled() {
		return "product/checkOutCancelled";
	}
	
	
}
