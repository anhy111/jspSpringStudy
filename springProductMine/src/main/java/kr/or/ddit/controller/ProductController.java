package kr.or.ddit.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;
import kr.or.ddit.vo.CartDetVO;
import kr.or.ddit.vo.CartVO;
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
	
	// 1) 로그인한 사용자만 접근 가능
	// 골뱅이PreAuthorize("isAuthenticated()")
	// 2) 회원권한을 가진 사용자만 접근 가능
	// 골뱅이PreAuthorize("hasRole('ROLE_MEMBER')")
	// 3) 회원권한 또는 관리자권한을 가진 사용자만 접근 가능
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView mav,
				@RequestParam(value = "keyword", required = false) String keyword) {
		
		// Model
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
	
//	@ResponseBody
//	@RequestMapping(value = "/removeCart/{productId}",method = RequestMethod.GET)
//	public String removeCart(HttpSession session, @PathVariable("productId") String productId){
//		
//		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartlist");
//		
//		for(int i=0; i<cartList.size(); i++) {
//			ProductVO pv = cartList.get(i);
//			if(pv.getProductId().equals(productId)) {
//				cartList.remove(i);
//			}
//		}
//		
//		return "complite";
//	}
	
//	@ResponseBody
//	@RequestMapping(value = "/deleteCart",method = RequestMethod.GET)
//	public String deleteCart(HttpSession session){
//		
//		
//		session.removeAttribute("cartlist");
//		
//		
//		return "complite";
//	}
	
	//요청URI : /removeCart?productId=P1238
	@RequestMapping(value="/removeCart",method = RequestMethod.GET)
	public String removeCart(@RequestParam String productId, Model model, 
			@ModelAttribute ProductVO productVO, HttpServletRequest request) {
			log.info("productId : " + productId);
			
			HttpSession session = request.getSession();
			ArrayList<ProductVO> cartlist =
			(ArrayList<ProductVO>)session.getAttribute("cartlist");
			
			for(int i=0;i<cartlist.size();i++){
				if(cartlist.get(i).getProductId().equals(productId)){
					cartlist.remove(cartlist.get(i));
				}//end if
			}//end for
			return  "product/cart";
	}
	
	@RequestMapping(value="/deleteCart",method=RequestMethod.GET)
	public String deleteCart(@RequestParam String cartId,
			HttpSession session) {
		log.info("cartId : " + cartId);	
		
		//cartId가 없네? => cart.jsp이동
		if(cartId==null || cartId.trim().equals("")){
			return "redirect:/cart";
		}
		
		session.invalidate();	//모든 세션을 삭제
		
		return "redirect:/cart";
	}
	
	@RequestMapping(value="/shippingInfo",method=RequestMethod.GET)
	public String shippingInfo(@RequestParam String cartId,
			Model model) {
		log.info("cartId : " + cartId);
		
		model.addAttribute("cartId", cartId);
		
		return "/product/shippingInfo";
	}

	@RequestMapping(value="/processShippingInfo", method = RequestMethod.POST)
	public ModelAndView processShippingInfo(ModelAndView mav, @ModelAttribute CartVO cartVO, HttpServletResponse response) throws Exception {
		
		Cookie cartId = new Cookie("Shipping_cartId",
				URLEncoder.encode(cartVO.getCartId(),"UTF-8"));
		Cookie name = new Cookie("Shipping_name",
				URLEncoder.encode(cartVO.getName(),"UTF-8"));
		Cookie shippingDate = new Cookie("Shipping_shippingDate",
				URLEncoder.encode(cartVO.getShippingDate(),"UTF-8"));
		Cookie country = new Cookie("Shipping_country",
				URLEncoder.encode(cartVO.getCountry(),"UTF-8"));
		Cookie zipCode = new Cookie("Shipping_zipCode",
				URLEncoder.encode(cartVO.getZipCode(),"UTF-8"));
		Cookie addressName = new Cookie("Shipping_addressName",
				URLEncoder.encode(cartVO.getAddressName(),"UTF-8"));
		Cookie addressDetail = new Cookie("Shipping_addressDetail",
				URLEncoder.encode(cartVO.getAddressDetail(),"UTF-8"));
		
		//쿠키의 유효 기간을 1일로 설정(초단위)->60*60
		cartId.setMaxAge(24*60*60);
		name.setMaxAge(24*60*60);
		shippingDate.setMaxAge(24*60*60);
		country.setMaxAge(24*60*60);
		zipCode.setMaxAge(24*60*60);
		addressName.setMaxAge(24*60*60);
		addressDetail.setMaxAge(24*60*60);
		
		//생성된 쿠키를 등록 (서버에서 생성이 되어 response객체에 담겨서 클라이언트로 가져와짐)
		response.addCookie(cartId);
		response.addCookie(name);
		response.addCookie(shippingDate);
		response.addCookie(country);
		response.addCookie(zipCode);
		response.addCookie(addressName);
		response.addCookie(addressDetail);
		
		//주문서 페이지로 이동
		
		mav.setViewName("product/orderConfirmation");
		
		return mav;
	}

	
	@RequestMapping(value = "/orderConfirmation",method = RequestMethod.GET)
	public String orderConfirmation() {
		return "product/orderConfirmation";
	}
	
	@RequestMapping(value = "/thankCustomer",method = RequestMethod.GET)
	public String thankCustomer(HttpServletRequest request,
			CartVO cartVO) throws UnsupportedEncodingException {
	//1. 쿠키 정보를 가져와 CART 테이블로 insert
      String Shipping_name = "";
      String Shipping_zipCode = "";
      String Shipping_country = "";
      String Shipping_addressName = "";
      String Shipping_addressDetail = "";
      String Shipping_shippingDate = "";
      String Shipping_cartId = "";

      Cookie[] cookies = request.getCookies();
      
      //쿠키의 개수만큼 반복
      for(int i=0;i<cookies.length;i++){
         Cookie thisCookie = cookies[i];
         if(thisCookie.getName().equals("Shipping_name")){
            Shipping_name = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setName(Shipping_name);
         }
         if(thisCookie.getName().equals("Shipping_zipCode")){
            Shipping_zipCode = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setZipCode(Shipping_zipCode);
         }
         if(thisCookie.getName().equals("Shipping_country")){
            Shipping_country = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setCountry(Shipping_country);
         }
         if(thisCookie.getName().equals("Shipping_addressName")){
            Shipping_addressName = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setAddressName(Shipping_addressName);
         }
         if(thisCookie.getName().equals("Shipping_addressDetail")){
        	 Shipping_addressDetail = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
        	 cartVO.setAddressDetail(Shipping_addressDetail);
         }
         if(thisCookie.getName().equals("Shipping_shippingDate")){
            Shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setShippingDate(Shipping_shippingDate);
         }
         if(thisCookie.getName().equals("Shipping_cartId")){
            Shipping_cartId = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
            cartVO.setCartId(Shipping_cartId);
         }
      }
      
      HttpSession session = request.getSession();
      List<ProductVO> list = (List<ProductVO>)session.getAttribute("cartlist");
      
      List<CartDetVO> cartDetVOList = new ArrayList<CartDetVO>();
      for(ProductVO vo : list) {
    	  CartDetVO cartDetVO = new CartDetVO();
    	  cartDetVO.setCartId(cartVO.getCartId());
    	  cartDetVO.setProductId(vo.getProductId());
    	  cartDetVO.setUnitPrice(vo.getUnitPrice());
    	  cartDetVO.setQuantity(vo.getQuantity());
    	  cartDetVO.setAmount(vo.getUnitPrice() * vo.getQuantity());
    	  cartDetVOList.add(cartDetVO);
      }
      cartVO.setCartDetVOList(cartDetVOList);
      
      this.productService.thankCustomer(cartVO);
      
      //forwarding
      return "product/thankCustomer";
	}
	
	@RequestMapping(value = "/checkOutCancelled",method = RequestMethod.GET)
	public String checkOutCancelled() {
		return "product/checkOutCancelled";
	}
	
	// PRODUCT 테이블의 기본키 자동 생성
	// JSON 데이터로 return
	@ResponseBody
	@PostMapping("/getProductId")
	public Map<String, String> getProductId(){
		Map<String, String> map = new HashMap<String, String>();
		String productId = this.productService.getProductId();
		
		log.info("productId : " + productId);
		map.put("productId", productId);
		
		return map;
	}
	
}
