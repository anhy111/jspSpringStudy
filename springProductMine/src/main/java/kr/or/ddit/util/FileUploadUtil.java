package kr.or.ddit.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.management.AttributeChangeNotification;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import kr.or.ddit.dao.ProductDao;
import kr.or.ddit.vo.AttachVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
public class FileUploadUtil {
	private static String uploadFolder = "C:\\Users\\PC-18\\git\\jspSpringStudy\\springProductMine\\src\\main\\webapp\\WEB-INF\\upload";
	
	// 파일 업로드 실행
	public static int fileUploadAction(MultipartFile[] multipartFiles, String tid) {
		log.info("파일 업로드 수행");
		
		List<AttachVO> attachVOList = new ArrayList<AttachVO>();
		
		// 1)파일 업로드 수행(연/월/일, UUID)
		File uploadPath = new File(uploadFolder, getFolder());
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile mpf : multipartFiles) {
			log.info("-----------------------------------");
			log.info("파일명: " + mpf.getOriginalFilename());
			log.info("파일 크기 : " + mpf.getSize());
			
			// IE처리 => 경로를 제외한 파일명만 추출
			String uploadFileName = mpf.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File savFile = new File(uploadPath, uploadFileName);
			
			int seq = 1;
			
			try {
				mpf.transferTo(savFile);
				
				AttachVO attachVO = new AttachVO();
				attachVO.setSeq(seq++);
				attachVO.setTid(tid);
				attachVO.setAttachName(getFolder().replace("\\", "/") + "/" + uploadFileName);
				log.info("attachName : " + getFolder().replace("\\", "/") + "/" + uploadFileName);
				attachVO.setAttachSize(Long.valueOf(mpf.getSize()).intValue());
				attachVO.setAttachType(Files.probeContentType(savFile.toPath()));
				
				attachVOList.add(attachVO);
				
				if(checkImageType(savFile)) {
					FileOutputStream thumbnail = new FileOutputStream(
							new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(mpf.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}// end for
		
		// 2)ATTACH 테이블에 다중 insert
		
		for(AttachVO attachVO : attachVOList) {
			log.info("attachVO : " + attachVO.toString());
		}
		
		ProductDao productDao = new ProductDao();
		productDao.insertAttach(attachVOList);
		
		log.info("파일 업로드 완료");
		return 0;
	}
	
	public static String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//이미지 체크(썸네일 용)
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	// 이미지의 경우 특별한 경우가 아니면 썸네일을 제작해줘야 함
	public static boolean checkImageType(File file) {
		//MIME 타입을 통해 이미지 여부 확인
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
	private static String uploadFile(String originalName, MultipartFile multipartFile) {
		// 랜덤수를 생성
		UUID uid = UUID.randomUUID();
		
		String createdFileName = uid.toString() + "_" + originalName;
		
		//복사 준비
		File target = new File(uploadFolder, createdFileName);
		
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
