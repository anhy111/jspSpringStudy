package kr.or.ddit.vo;

public class AddressVO {
	private String userId;
	private String postCode;
	private String address;
	private String addressDetail;
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	@Override
	public String toString() {
		return "AddressVO [postCode=" + postCode + ", address=" + address + ", addressDetail=" + addressDetail + "]";
	}
	
	
}
