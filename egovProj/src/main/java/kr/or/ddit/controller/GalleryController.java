package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@RequestMapping("/gallery")
@Slf4j
@Controller
public class GalleryController {

	@Autowired
	GalleryService galleryService;
	
	@GetMapping("/list")
	public String list(Model model, BookVO bookVO) {
		
		bookVO = this.galleryService.list(bookVO);
		
		log.info("bookVO : " + bookVO);
		
		model.addAttribute("bodyTitle","이미지 목록");
		model.addAttribute("bookVO",bookVO);
		
		return "gallery/list";
	}
	
	@ResponseBody
	@PostMapping("/deletePost")
	public Map<String, String> deletePost(@RequestBody AttachVO attachVO) {
		
		log.info("attahcVO : " + attachVO);
		
		int result = this.galleryService.attahcDelete(attachVO);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result",result+"");
		
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/updatePost")
	public AttachVO updatePost(MultipartFile[] uploadFile,
				@ModelAttribute AttachVO attachVO) {
		
		log.info("uploadFile : " + uploadFile);
		log.info("attachVO : " + attachVO);
		
		String uploadFolder = 
				"C:\\eGovFrameDev-3.10.0-64bit\\workspace\\jspSpringStudy\\egovProj\\src\\main\\webapp\\resources\\upload";
		
		// 연월일 폴더 생성
		File uploadPath = new File(uploadFolder,getFolder());
		log.info("upload Path : " + uploadPath);
		
		// 만약 연원일 폴더가 없으면 생성
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		String uploadFileName = "";
		//파일 배열로부터 파일을 하나씩 가져와보자.
		for(MultipartFile multipartFilefile : uploadFile) {
			log.info("-----------------------------------");
			log.info("upload File Name : " + multipartFilefile.getOriginalFilename());
			log.info("upload File Size : " + multipartFilefile.getSize());
			uploadFileName = multipartFilefile.getOriginalFilename();
			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 시작----------------------------
			// java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID();
			// 원래의 파일 이름과 구분하기 위해  _를 붙임
			uploadFileName = uuid.toString() + "_" + uploadFileName; 
			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 끝 ----------------------------
			
			// File객체 설계(복사할 대상 경로, 파일명)
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				// 파일 복사 실행
				// 정한 경로 + 파일명으로 실제 파일을 저장
				multipartFilefile.transferTo(saveFile);
				
				// 썸네일 처리
				// 이미지인지 체크
				if(checkImageType(saveFile)) {
					FileOutputStream thumnbail = new FileOutputStream(
								new File(uploadPath, "s_" + uploadFileName)
							);
					// 썸네일 생성
					Thumbnailator.createThumbnail(multipartFilefile.getInputStream(),
								thumnbail,100,100);
					thumnbail.close();
				}
				
				// ATTACH 테이블에 반영
				String folder = getFolder().replace("\\", "/");
				attachVO.setFilename("/" + folder + "/" + uploadFileName);
				int result = galleryService.attachUpdate(attachVO);
				
				if(result > 0) {
					return attachVO;
				}
				
			} catch (Exception e) {
				log.error(e.getMessage());
				return null;
			}// end try
		}// end for
		
		return null;
	}
	
	public String getFolder() {
		// 2022-11-16 형식(format) 지정
		// 간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		// 2022-11-16
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//이미지 판단. 썸네일은 이미지만 가능
	public boolean checkImageType(File file) {
		// MIME 타입 .jpeg/ .jpg의 MIME타입 : image/jpeg
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 이 파일이 이미지가 아닐 경우
		return false;
	}
}
