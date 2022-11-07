package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

//자바빈 클래스
//PoJo(Plain oriented Java Object)의 퇴보
@Data
public class CardVO {
	//카드번호 
	private String no;
	//유효기간 20251210
	@DateTimeFormat(pattern="yyyyMMdd")
	private Date validMonth;
	private String validMonth2;
}








