package kr.or.ddit.vo;

import java.util.Date;

public class AttachVO {
	private int seq;
	private String tid;
	private String attachName;
	private int attachSize;
	private String attachType;
	private Date registDate;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getAttachName() {
		return attachName;
	}
	public void setAttachName(String attchName) {
		this.attachName = attchName;
	}
	public int getAttachSize() {
		return attachSize;
	}
	public void setAttachSize(int attchSize) {
		this.attachSize = attchSize;
	}
	public String getAttachType() {
		return attachType;
	}
	public void setAttachType(String attchType) {
		this.attachType = attchType;
	}
	public Date getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Date registDate) {
		this.registDate = registDate;
	}
	@Override
	public String toString() {
		return "AttachVO [seq=" + seq + ", tid=" + tid + ", attchName=" + attachName + ", attchSize=" + attachSize
				+ ", attchType=" + attachType + ", registDate=" + registDate + "]";
	}
	
	
}
