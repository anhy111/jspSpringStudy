package kr.or.ddit.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.velocity.tools.config.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.MemService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.MemVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mem")
@Controller
public class MemController {
	@Autowired
	MemService memService;
	
	// 요청 URI : /mem/memRegist
	@GetMapping("/memRegist")
	public ModelAndView memRegist(MemVO memVO) {
		memVO.setUserNo(memService.makeUserNo());
		
		ModelAndView mav = new ModelAndView();
		//회원의 번호를 모델에 담아서 jsp로 보냄
		mav.addObject("userNo", memVO.getUserNo());
		mav.setViewName("mem/memRegist");
		
		//forwarding
		return mav;
	}
	
	// {"userId":userId}
	// 요청URI : /mem/dupChk
	//골뱅이RequestBody : json을 받을 때
	//골뱅이ResponseBody : json을 보낼 때
	@ResponseBody
	@PostMapping("/dupChk")
	public Map<String,String> dupChk(@RequestBody MemVO memVO) {
		log.info("memVO : " + memVO.toString());
		//중복 아이디 체크
		int cnt = this.memService.dupChk(memVO);
		
		Map<String,String> map = new HashMap<String,String>();
		
		//1 : 있다 / 0 : 없다
		if(cnt<1) {
			map.put("result", "0");
		}else {
			map.put("result", "1");
		}
		
		return map;
	}
	
	//요청 URI : /mem/memRegistPost
	@PostMapping("/memRegistPost")
	public String memRegistPost(@Validated MemVO memVO,
			BindingResult brResult) throws IllegalStateException, IOException {
		//MemVO(userNo=2022002, userId=b001, userPw=java, userName=개똥이, coin=0
		//, regDate=null, updDate=null, enabled=null, 
		//memAuthVOList=[MemAuthVO(userNo=2022002, auth=manager)
		//, MemAuthVO(userNo=2022002, auth=employee), MemAuthVO(userNo=2022002, auth=employer)])
		log.info("memVO : " + memVO.toString());
		//회원등록화면으로 redirect
		//톰캣 : 헤이, 크롬! /mem/memRegist 다시 요청해달라매?
		//크롬 : 응, 내가 그랬지.
		//톰캣 : 그럼 다시 요청해줘. 내가 처리해줄게
		//크롬 : 응, 알겠어 다시 /mem/memRegist 요청했어. 처리해줘
		//톰캣 : 응, 나도 처리할게
		if(brResult.hasErrors()) {	//유효성 검사 결과 오류 발생
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
			return "mem/memRegist";
		}
		
		// 업로드 될 폴더 설정
		String uploadFolder = "D:\\A_TeachingMaterial\\06_spring\\springProj\\src\\main\\webapp\\resources\\upload";
		// 연/월/일 폴더 생성
		String uploadFolderPath = getFolder();
		// 폴더 생성(계획)
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		//계획된 경로에 폴더가 없다면 생성
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		//memVO 객체로부터 MultipartFile[] 타입의 파일 객체를 꺼내와보자
		MultipartFile[] uploadFile = memVO.getMemImage();
		//attach테이블에 입력할 목록을 생성
		List<AttachVO> attachVOList = new ArrayList<AttachVO>();
		int cnt = 1;
		//파일 객체 배열로부터 하나씩 파일객체를 꺼내보자
			for(MultipartFile multipartFile : uploadFile) {
				//실제파일명 가져오기
				String uploadFileName = multipartFile.getOriginalFilename();
				//IE 처리 => 경로를 제외한 파일명만 추출
				//c:\\temp\\개똥이.jpg => 개똥이.jpg
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
				//UUID 붙이기
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString() + "_" + uploadFileName;
						
				//memVO 객체의 filename 멤버변수에 실제 파일명을 넣어줌
				//	/2022/08/03   /   UUID_개똥이.jpg
				memVO.setFilename(uploadFolderPath.replace("\\", "/") + 
						"/" + uploadFileName);
				
				//파일업로드 처리
				//uploadPath : static폴더및연월일까지
				//uploadFileName : UUID_실제파일명
				//계획
				File saveFile = new File(uploadPath, uploadFileName);
				//실행
				multipartFile.transferTo(saveFile);
				
				AttachVO attachVO = new AttachVO();
//				attachVO.setUserNo(memVO.getUserNo());
				attachVO.setSeq(cnt++);	//1을 attachVO에 setting한 후에 1 증가
				attachVO.setFilename(memVO.getFilename());
				//Long.valueOf(multipartFile.getSize()).intValue()
				attachVO.setFilesize((int)multipartFile.getSize());
				
				attachVOList.add(attachVO);
			}
		//attach테이블에 list형태로 입력하기 위함
		memVO.setAttachVOList(attachVOList);
			
		//회원 및 회원권한 insert
		int result = this.memService.insert(memVO);
		
		if(result>0) { //입력 성공
			return "redirect:/mem/memRegist?result=1";
		}else {	//입력 실패
			return "redirect:/mem/memRegist?result=0";
		}
	}
	
	//날짜 계층형 폴더
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		//str : 2022-08-03
		String str = sdf.format(date);
		//2022폴더 > 08폴더 > 03폴더
		return str.replace("-", File.separator);
	}
	
	//요청 URI : /mem/memList
	//요청 파라미터 : ?size=10&cond=&keyword=2022
	@GetMapping("/memList")
	public String memList(Model model, @RequestParam Map<String,String> map
			, @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage) {
		//map : {size=10, cond=userName, keyword=127}
		log.info("map : " + map);
		if(map==null) {
			map.put("size","10");
			map.put("cond",null);
			map.put("keyword",null);
			map.put("currentPage","1");
		}
		
		map.put("currentPage", currentPage+"");
		//map : {size=10, cond=userName, keyword=127, currentPage=1}
		int total = this.memService.memTotal(map);
		List<MemVO> memVOList = this.memService.memList(map);
		
		//페이징처리(util 패키지의 ArticlePage.java를 통해 페이징 처리해보자)
		//목록 하단의 페이징은 일단 하지 말고, 한 화면에 10개가 출력되도록 처리
		
		model.addAttribute("data", new ArticlePage<MemVO>(total, currentPage, 10, memVOList));
		//요청 파라미터를 받은 map을 model의 속성의 값으로 포함
		
		model.addAttribute("map", map);
		
		//forwarding
		return "mem/memList";
	}
}
















