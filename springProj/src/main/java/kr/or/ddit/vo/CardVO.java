package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CardVO {
	private String userId;
	private String no;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date validMonth;
}
