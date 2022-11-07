package kr.or.ddit.vo;

import java.util.Date;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

//자바빈 클래스
@Data
public class AttachVO {
	private String userNo;
	private int seq;
	@NotBlank
	private String filename;
	private int filesize;
	private Date regdate;
}
