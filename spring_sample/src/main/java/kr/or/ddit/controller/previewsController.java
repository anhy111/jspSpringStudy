package kr.or.ddit.controller;

import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tiles.extras.module.ModularTilesListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.MemService;
import kr.or.ddit.vo.MemVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/previews")
@Slf4j
@Controller
public class previewsController {
	
	@Autowired
	MemService memService;
	
	// 요청 URI : /previews/write
	// 방식 : get
	@GetMapping("/write")
	public String write(@ModelAttribute MemVO memVO) {
		//forwarding
		return "previews/write";
	}
	
	/*
		request객체에 요청 파라미터가 들어있음
		VO -> 골뱅이ModelAttribute
		String, map, int -> 골뱅이RequestParam
		
		입력값 검증 대상의 도메인 클래스 직후에 BindingResult를 정의함
		BindingResult에는 요청 파라미터 데이터의 바인딩 에러(멤버변수에 없음)와
		입력값 검증 에러 정보가 저장됨
	 */
	@PostMapping("/writePost")
	public String writePost(@Validated MemVO memVO, BindingResult result) {
		
		log.info("memVO : " + memVO);
		// 입력값 검증 오류 발생 시 true 반환
		log.info("result.hasErrors() : " + result.hasErrors());
		
		// 입력값 검증 후 BindingResult가 제공하는 메서드를 이용하여 검사 결과 확인]
		/*
		 	1. hasErrors() : 오류가 발생한 경우 true 반환
		 	2. hasGlobalErrors() : 객체 레벨의 오류가 발생한 경우 true 반환
		 	3. hasFieldErrors() : 필드(멤버변수) 레벨의 오류가 발생한 경우 true 반환
		 	4. hasFieldErrors(String) : 인수에 지정한 필드에 오류 발생 시 true 반환
		 */
		if(result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			
			for(int i=0; i<allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				log.info("allError : " + objectError);
			}
			for(int i=0; i<globalErrors.size(); i++) {
				ObjectError objectError = globalErrors.get(i);
				log.info("globalErrors : " + objectError);
			}
			for(int i=0; i<fieldErrors.size(); i++) {
				FieldError fieldError = fieldErrors.get(i);
				log.info("fieldErrors : " + fieldError);
				log.info("fieldError.getDefaultMessage() : " + fieldError.getDefaultMessage());
			}
			return "previews/write";
		}
		
		int rslt = this.memService.memInsert(memVO);
		
		
		return "previews/write";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<MemVO> memVOList = this.memService.memList2();
		
		log.info("memVOList : " + memVOList);
		
		model.addAttribute("memVOList",memVOList);
		
		return "previews/list";
	}
	
	// 회원 상세보기
	@GetMapping("/detail")
	public String memDetail(@RequestParam String userNo
					, @ModelAttribute MemVO memVO
					, Model model) {
		
		log.info("userNo : " + userNo);
		
		memVO = this.memService.memDetail(userNo);
		log.info("memVO : " + memVO);
		
		model.addAttribute("memVO",memVO);
		
		return "previews/detail";
	}
	
	@ResponseBody
	@PostMapping("/detailPwCheck")
	public Map<String, String> detailPwCheck(@RequestBody MemVO memVO) {
		log.info("memVO : " + memVO);
		
		// 비밀번호 확인
		int result = this.memService.detailPwCheck(memVO);
		
		// 결과 리턴(1 이상이면 비밀번호 맞음. 0이면 비밀번호 다름)
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result",result + "");
		
		return resultMap;
	}
	
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute MemVO memVO
						, Model model) {
		
		log.info("memVO : " + memVO);
		
		int result = this.memService.memUpdate(memVO);
		
		model.addAttribute("memVO", memVO);
		log.info("result : " + result);
		
		return "redirect:/previews/detail?userNo="+memVO.getUserNo();			
	}
	
	@PostMapping("/deletePost")
	public String deletePost(@ModelAttribute MemVO memVO) {
		
		log.info("memVo : " + memVO);
		
		int result = this.memService.memDelete(memVO);
		log.info("result : " + result);
		
		return "redirect:/previews/list";
	}
}
