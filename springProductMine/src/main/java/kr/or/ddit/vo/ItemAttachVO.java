package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

// lombok은 PoJo에서 멀어진다
//@Data
public class ItemAttachVO {
	private int seq;
	private int itemId;
	private String fullname;
	private Date regdate;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ItemAttachVO [seq=" + seq + ", itemId=" + itemId + ", fullname=" + fullname + ", regdate=" + regdate
				+ "]";
	}
	
	
}
