package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.ItemVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@RequestMapping(value = "/item")
@Slf4j
@Controller
public class ItemController {
	
	private String uploadPath = "C:\\Users\\PC-18\\git\\jspSpringStudy\\springProductMine\\src\\main\\webapp\\WEB-INF\\upload";

	@GetMapping("register")
	public String registerForm() {
		return "item/register";
	}
	
	// 상품 등록
	@PostMapping("/register")
	public String register(ItemVO itemVO, Model model) {
		log.info("itemVO : " + itemVO.toString());
		
		MultipartFile file = itemVO.getPicture();
		
		log.info("originalName : " + file.getOriginalFilename());
		log.info("size : " + file.getSize());
		log.info("contentType : " + file.getContentType());

		String createdFileName = uploadFile(file.getOriginalFilename(), file);
		
		model.addAttribute("msg", "등록이 완료되었습니다.");
		
		return "item/success";
	}
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "item/uploadForm";
	}
	
	// 다중 이미지 업로드
	// name="uploadFile"과 MultipartFile[] uploadFile은 동일해야함
	@PostMapping("/uploadFormAction")
	public String uploadFromAction(MultipartFile[] uploadFile,
				Model model) {
		//MultipartFile file : 스프링에서 제공해주는 타입
		/*
			잘 쓰는 법
			String.. = file.getOriginalFileName() : 업로드 되는 파일의 이름(실제 파일명)
			boolean.. = file.isEmpty() : 파일이 없다면 true
			long.. = file.getSize() : 업로드 되는 파일의 코기
			file.tranferTo(File f) : 파일을 저장
			
			잘안쓰는것
			Stirng.. = file.getName()
			byte[].. = file.getBytes() : byte[]로 파일 데이터 변환
			InputStream.. = getInputStream() : 파일 데이터와 연결된 InputStream을 반
		 */
		//make folder 시작 연/월/일-----------
		File uploadFolder = new File(uploadPath, getFolder());
		log.info("uploadForder : " + uploadFolder);
		
		// 폴더가 없으면 생성
		if(uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		//make folder 끝 -------------------
		for(MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------------");
			// 이미지 명
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload file Size : " + multipartFile.getSize());
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			log.info("only file name : " + uploadFileName);
			
			// 이미지 파일 중복 방지
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			// File 객체 설계(복사할 대상 경로(서버쪽), 파일명(uuid)가 붙은)
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				//파일 복사 실행
				multipartFile.transferTo(saveFile);
				
				//썸네일 처리 시작----------------------
				if(checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(
								new File(uploadFolder,"s_"+uploadFileName));
					//썸네일 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
							thumbnail, 100, 100);
					thumbnail.close();
				}
				//썸네일 처리 끝----------------------
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		} //end for
		
		model.addAttribute("msg","업로드 성공");
		return "item/success";
	}
	
	public String getFolder() {
		//2022-10-28형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 날짜 객체 생성(java.util패키지)
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//이미지 체크(썸네일 용)
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	// 이미지의 경우 특별한 경우가 아니면 썸네일을 제작해줘야 함
	public boolean checkImageType(File file) {
		/*
		  .jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		 */
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType :" + contentType); //image/jpeg, image/png, image/gif
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 파일 복사(client 파일 -> 서버로 복사)
	private String uploadFile(String originalName, MultipartFile multipartFile) {
		// 랜덤수를 생성
		UUID uid = UUID.randomUUID();
		
		String createdFileName = uid.toString() + "_" + originalName;
		
		//복사 준비
		File target = new File(uploadPath, createdFileName);
		
		//복사 실행
		try {
			multipartFile.transferTo(target);
		} catch (IllegalStateException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} 
		
		return createdFileName;
		
	}
	
	
}
