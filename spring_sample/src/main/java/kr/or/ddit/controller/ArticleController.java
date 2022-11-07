package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.ArticleService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ArticleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/article")
@Controller
public class ArticleController {
	// IoC(Inversion of Controll)
	@Inject
	ArticleService articleService;
	
	//골뱅이ModelAttribute ArticleVO articleVO의 articleVO이름과
	//<form:form modelAttribute="articleVO" 이름을 통해 
	//뷰(jsp)와 컨트롤러(java) 간에 연결이 됨
	// 요청 URI : /article/write
	@GetMapping("/write")
	public String write(@ModelAttribute ArticleVO articleVO
			, HttpServletRequest request) {
		log.info("articleVO : " + articleVO.toString());
		
		HttpSession session = request.getSession();
		//session에서 id를 받아왔다고 하자
		articleVO.setWriterId("a001");
		
		//forwarding
		return "article/write";
	}
	
	// 요청 URI : /article/writePost
	// 요청 파라미터 : ?writerId=a001&writerName=&title=&artContent=asdf
	//골뱅이Validated : 입력값 검증 기능을 활성화
	/* p.384
	  BindingResult에는 요청 파라미터의 바인딩 오류와 입력값 검증(숫자타입의 멤버변수에 문자가 옴)  오류 정보가 저장됨
	   - hasErrors() : 오류 발생 시 true를 반환 
	 */
	@PostMapping("/writePost")
	public String writePost(@Validated ArticleVO articleVO,
			BindingResult brResult) {
		/*
		 ArticleVO(articleNo=0, writerId=a001, writerName=개똥이, title=닥터로이어
		    , artContent=<p>내용입니다요</p>
			, regdate=null, moddate=null, readCnt=0)
		 */
		// 도메인클래스(ArticleVO의 writerName 및 title 멤버변수에 오류가 발생함
		// brResult.hasErrors() => true
		log.info("brResult.hasErrors() : " + brResult.hasErrors());
		//오류 발생 시
		if(brResult.hasErrors()) {
			//검사 결과 오류 확인
			List<ObjectError> allErrors = brResult.getAllErrors();
			//객체와 관련된 오류
			List<ObjectError> globalErrors = brResult.getGlobalErrors();
			//멤버변수와 관련된 오류
			List<FieldError> fieldErrors = brResult.getFieldErrors();
			
			for(ObjectError objectError : allErrors) {
				log.info("allError : " + objectError);
			}
			
			for(ObjectError objectError : globalErrors) {
				log.info("globalError : " + objectError);
			}
			
			for(FieldError fieldError: fieldErrors) {
				log.info("fieldError : " + fieldError.getDefaultMessage());
			}
			
			//redirect로는 안되고, forwarding만 됨
			return "article/write";
		}
		
		log.info("articleVO : " + articleVO.toString());
		
		int result = this.articleService.insert(articleVO);
		
		log.info("글입력 result : " + result);
		
		return "redirect:/article/write";
	}
	
	//요청 URI : /article/list?show=10&cond=title&keyword=개똥이&currentPage=3
	//RedirectAttributes 타입 : 일회성으로 데이터를 전달하는 용도로 사용
	@GetMapping("/list")
	public String list(Model model,@RequestParam Map<String,String> map,
			RedirectAttributes rttr) {
		//map : {show=10, cond=title, keyword=개똥이, currentPage=3}
		log.info("map : " + map);
		
		//한 화면에 보여지는 행의 수(기본 10행)
		int page = 10;
		//http://localhost/article/list 일 때 map.size() => 0
		if(map.size()>0) {
			if(map.get("show").length()>0) {
				 page = Integer.parseInt(map.get("show"));
			}
		}else {	//map이 null일 때 처리. /article/list
			map.put("show", "10");
			map.put("cond", "");
			map.put("keyword", "");
			map.put("currentPage", "1");
		}
		
		String currentPage = map.get("currentPage");
		//현재 페이지가 null이라면 1로 세팅
		if(currentPage==null) {
			currentPage = "1";
			map.put("currentPage","1");
		}
		
		//글 검색 후 목록 리턴
		List<ArticleVO> list = this.articleService.list(map);
		
		//전체 행의 수(total). map : {show=10, cond=title, keyword=개똥이, currentPage=2} 포함
		int total = this.articleService.getTotal(map);
		
		if(list!=null) {
			log.info("list : " + list.get(0).toString());
		}
		//select 결과 list를 페이징 객체에 태워서 보냄
		//(전체 글 수, 현재페이지, 한 화면에 보여질 행 수, select 결과 list)
		model.addAttribute("data", new ArticlePage<ArticleVO>(total
					, Integer.parseInt(currentPage), page, list));
		
		//jsp쪽으로 검색어 정보를 던져줌 map : {show=10, cond=title, keyword=개똥이, currentPage=2}		
		model.addAttribute("map", map);
		//redirect용
//		rttr.addFlashAttribute("map", map);
		
		//forwarding
		return "article/list";
	}
	
	// 요청 URI /article/detail?articleNo=1
	// 스프링에서는 요청 파라미터(articleNo=1)를 매개변수로 받을 수 있음
	// 파라미터는 String인데 spring에서 int로 자동 형변환해줌
	@GetMapping("/detail")
	public String detail(int articleNo, Model model) {
		log.info("articleNo : " + articleNo);
		
		ArticleVO articleVO = this.articleService.detail(articleNo);
		
		model.addAttribute("data", articleVO);
		
		//forwarding
		return "article/detail";
	}
	
	// 파라미터 : {"articleNo":"79","writerId":"a001","writerName":"개똥이","title":"제목","artContent":"내용"}
	// 요청 URI : /article/updatePost
	@PostMapping("/updatePost")
	public String updatePost(RedirectAttributes rat,
			int articleNo, String writerId, String writerName
			, @RequestParam String title, @RequestParam("artContent") String artContent,
			@RequestParam Map<String,String> map,
			@ModelAttribute ArticleVO articleVO) {
		//ArticleVO(rnum=0, articleNo=98, writerId=a001, writerName=개똥이98
		//, title=닥터로이어98, artContent=<p>방가워유98</p>
		//, regdate=null, moddate=null, readCnt=0)
		log.info("articleVO : " + articleVO.toString());
		
		int result = this.articleService.update(articleVO);
		
		// /article/detail?articleNo=1
		rat.addFlashAttribute("articleNo", articleVO.getArticleNo());
		
		//redirect
		return "redirect:/article/detail?articleNo="+articleVO.getArticleNo();
	}
	
	//파라미터 : {"articleNo":"79","writerId":"a001","writerName":"개똥이","title":"제목","artContent":"내용"}
	//요청 URI : /article/deletePost
	@PostMapping("/deletePost")
	public String delete(int articleNo
			, @ModelAttribute ArticleVO articleVO) {
		
		int result = this.articleService.delete(articleNo);
		
		log.info("result : " + result);
				
		//redirect
		return "redirect:/article/list";
	}
}














