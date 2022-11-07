package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//자바빈 클래스
//PoJo(Plain oriented Java Object) 역할
@Data
public class MemberVO {
	private String userId;
	private String password;
	private String gender;
	private String nationality;
	private String[] carArray;
	//여부를 나타내는 체크박스의 경우 String, boolean으로 받을 수 있음
	private String developer;
	private boolean foreigner;
	
	private AddressVO address;
	private List<CardVO> cardList;
	//MEMBER테이블의 INTRODUCTION 컬럼의 자료형이 CLOB이더라도
	//String 타입의 멤버변수로 처리하면 됨
	private String introduction;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dateOfBirth;
	private MultipartFile picture;
	private MultipartFile picture2;
	/*
	 <input type="file" name="pictureList[0]" /><br />
	<input type="file" name="pictureList[1]" /><br />
	 */
	private List<MultipartFile> pictureList;
	//<input type="file" name="pictureMulti" multiple />
	private List<MultipartFile> pictureMulti;
}









