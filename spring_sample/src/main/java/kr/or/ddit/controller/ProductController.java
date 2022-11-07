package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;


//프링이에게 "이거 컨트롤러야. 그니까, 자바빈으로 등록해줘야해"
//클래스레벨
@Slf4j
@RequestMapping(value="/product")
@Controller
public class ProductController {
	//프링이는 인터페이스를 좋아해
	@Autowired
	ProductService productService;
	
	//메소드레벨
	//골뱅이RequestMapping(value="/welcome",method=RequestMethod.GET)
	//URI => /localhost/product/welcome
	@GetMapping("/welcome")
	public String welcome() {
		//mav.setViewName("shopping/welcome");
		//return mav;
		return "shopping/welcome";
	}
	
	//URI => /localhost/product/addProduct
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/addProduct")
	public String addProduct() {
		// /WEB-INF/views/shopping/addProduct.jsp
		return "shopping/addProduct"; 
	}
	
	//URI => localhost/product/processAddProduct(post)
	//골뱅이RequestMapping(value="/processAddProduct",method=RequestMethod.POST)
	
	//요청파라미터 => {"productId":"P1234","pname":"iPhone 6s","unitPrice":800000,"description":"4.7-inch, 1334x750"
	//	,"manufacturer":"Apple",
	//"category":"Smart Phone","unitsInStock":1000,"condition":"New","productImage":""}
	
	//	productVO => 
	//	{"productId":"P1234","pname":"iPhone 6s","unitPrice":800000,"description":"4.7-inch, 1334x750"
	//	,"manufacturer":"Apple",
	//"category":"Smart Phone","unitsInStock":1000,"condition":"New","productImage":""}
	//골뱅이RequestParam -> 파라미터가 String일때
	//골뱅이ModelAttribute -> 파라미터가 VO타입용일 때
	@PostMapping("/processAddProduct")
	public String processAddProduct(@ModelAttribute ProductVO productVO, HttpServletRequest request) {
		//ProductVO(productId=P1234, pname=개똥이폰, unitPrice=1000000
		//, description=좋다, manufacturer=samsung, category=Smart Phone
		//, unitsInStock=1000, condition=New, filename=null
		//, quantity=0, productImage=파일객체)
		HttpSession session = request.getSession();
		String realPath = session.getServletContext().getRealPath("/"); 
		
		log.info("realPath : " + realPath);
		
		log.info("productVO : " + productVO.toString());
		//업로드 폴더 경로 설정
		String uploadFolder 
			= "C:\\eGovFrameDev-3.10.0-64bit\\workspace\\springProj\\src\\main\\webapp\\resources\\upload";
		
		//날짜 계층형 폴더 생성 시작-------------------
			//(어디에?, 무엇을?)
		File uploadPath = new File(uploadFolder,UploadController.getFolder());
			//연월일 폴더가 없다면 생성해보자
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}		
		//날짜 계층형 폴더 생성 끝-------------------
		
		//첨부파일 객체를 VO에서 가져옴
//		private MultipartFile[] productImage;	//첨부파일
		MultipartFile[] productImage = productVO.getProductImage();
		
		for(MultipartFile multipartFile : productImage) {
			log.info("파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일크기 : " + multipartFile.getSize());
			
			//실제 파일명 알아내기(PRODUCT 테이블의 FILENAME 컬럼의 값으로 넣을것임)
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE에서 파일명의 경로를 처리 => C:\\Users\\개똥이.jsp => 개똥이.jsp
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			//randomUUID() : 임의의 값을 생성
			UUID uuid = UUID.randomUUID();
			//sadfpoisdfjpoidsfadfsaoidfs_개똥이.jsp
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			//(목적지?, 파일명?) 설계
			File saveFile = new File(uploadPath,uploadFileName);
			
			//파일을 목적지로 복사하려면 파라미터가 File객체여야 함
			//구현
			try {
				//파일 복사
				multipartFile.transferTo(saveFile);
				
				//ProductVO.filename 멤버변수에 파일명을 세팅
				// /2022/07/25/aslfksajdlfsd_개똥이.jsp
				productVO.setFilename(UploadController.getFolder().replace("\\", "/") + "/" + uploadFileName);
				
				//썸네일 만들기 시작--------------------
					//이미지인지 체킹
					if(UploadController.checkImageType(saveFile)) {
						//썸네일 => s_이미지파일명(바이너리 파일 생성)
						FileOutputStream thumbnail = 
								new FileOutputStream(
										new File(uploadPath, "s_" + uploadFileName)
										);
						//InputStream과 java.io.File 객체를 이용하여
						//썸네일 파일 생성. width:100px, height:100px
						Thumbnailator.createThumbnail(
								multipartFile.getInputStream(),thumbnail,300,300
								);
						thumbnail.close();
					}
				//썸네일 만들기 끝--------------------
			} catch (IllegalStateException e) {
				log.info(e.getMessage());
			} catch (IOException e) {
				log.info(e.getMessage());
			}
		}
		
		//상품 등록
		int result = this.productService.insert(productVO);
		
		log.info("result : " + result);
		
		//25번째 줄의 addProduct()메소드를 실행하는 방법
		//1) this.addProduct();
		//2) redirect => URI 재요청 => 데이터 전달(x), ?id=a001(o)
		return "redirect:/product/products";
	}
	
	//URI => http://locahost/product/products
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') and hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@Secured({"ROLE_ADMIN","ROLE_MEMBER"})
	@GetMapping("/products")
	public String products(Model model) {
		//상품 목록
		List<ProductVO> list = this.productService.list();
		
		//Model : 데이터
		//View : jsp 경로 / redirect할 경로
//		ModelAndView mav = new ModelAndView();
		
//		mav.addObject("list", list);
		model.addAttribute("list", list);
		
//		mav.setViewName("shopping/products");				
//		return mav;
		//products.jsp를 찾아서 처리 => forwarding
		return "shopping/products";
	}
	
	//상품 상세
	//URI => localhost/product/product
	//요청파라미터(HTTP 파라미터) => ?id=P1234
	//로그인한 사용자만 접근 가능
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/product")
	public String product(@RequestParam(value="id") String productId,
			Model model, HttpServletRequest request) {
		
		log.info("productId : " + productId);
		
		ProductVO productVO = this.productService.detail(productId);
		
		model.addAttribute("productVO", productVO);
		//forwarding
		return "shopping/product";
	}
	
	//장바구니(세션)에 담기
	//URI => localhost/product/addCart?id=P1234
	@PostMapping("/addCart")
	public String addCart(@RequestParam(value="id") String productId,
			HttpServletRequest request) {
		log.info("productId : " + productId);
		
		//요청파라미터 값이 null이면 상품 목록으로 이동
		if(productId==null||productId.trim().equals("")) {
			return "redirect:/product/products";
		}
		
		//P1234 상품이 있는지 찾아보자
		ProductVO product = this.productService.detail(productId);
		//상품 결과가 없다면..
		if(product == null) {
			//[상품이 없음] 예외처리 페이지로 이동
			return "redirect:/product/exceptionNoProductId";
		}
		//request객체에 들어있는 session을 가져오자
		//장바구니(세션) => 세션의 명 : cartlist
		//session.getAttribute("cartlist") => Object
		HttpSession session = request.getSession();
		ArrayList<ProductVO> list = (ArrayList<ProductVO>)session.getAttribute("cartlist");
		
		//장바구니가 없다면.. 생성해주자.
		if(list == null) {
			list = new ArrayList<ProductVO>();
			//cartlist라는 세션명으로 생성
			session.setAttribute("cartlist", list);
		}
		
		//장바구니가 있다면.. 다음을 실행하자
		int cnt = 0;
		//1)장바구니에 P1234 상품이 이미 들어있는 경우
		// 	private int quantity;	//상품을 장바구니에 담은 개수
		//	quantity를 1 증가
		//2)장바구니에 P1234 상품이 없는 경우
		//  장바구니에 상품을 넣어주고
		//	quantity를 1로 처리
		//list : 장바구니에 들어있는 상품 목록
		for(int i=0;i<list.size();i++) {
			/*장바구니 => list => list.size() : 2
			 get(0) : P1234|상품명1|3|...
			 get(1) : P1235|상품명2|1|...
			 */
			/*파라미터로 넘어온 productId
			 P1234
			 */
			if(list.get(i).getProductId().equals(productId)) {
				//장바구니에 이미 상품이 있더라..
				cnt++;
				list.get(i).setQuantity(list.get(i).getQuantity()+1);
			}
		}
		//장바구니에 해당 상품이 없다면..
		if(cnt==0) {
			//130번줄에서 P1234의 상품을 찾았음
			product.setQuantity(1);	
			//장바구니에 신규로 상품을 1개 담음
			list.add(product);
		}
		
		//redirect => URI 재요청
		return "redirect:/product/product?id="+productId;
	}
	
	//URI => /product/cart
	@GetMapping("/cart")
	public String cart() {
		//cart.jsp를 컴파일 -> 응답
		//forwarding
		return "shopping/cart";
	}
	
	//URI => /product/exceptionNoProductId
	@GetMapping("/exceptionNoProductId")
	public String exceptionNoProductId() {
		//forwarding
		return "shopping/exceptionNoProductId";
	}
	
	//로그인 처리
	//URI
}











