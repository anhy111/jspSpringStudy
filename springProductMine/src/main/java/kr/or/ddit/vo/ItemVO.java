package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ItemVO {
	private int itemId;
	private String itemName;
	private int price;
	private String description;
	private String pictureUrl;
	private String pictureUrl2;
	
	private MultipartFile picture;
	
	private List<ItemAttachVO> atchList;
	
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPictureUrl() {
		return pictureUrl;
	}
	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	
	public String getPictureUrl2() {
		return pictureUrl2;
	}
	public void setPictureUrl2(String pictureUrl2) {
		this.pictureUrl2 = pictureUrl2;
	}
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	public List<ItemAttachVO> getAtchList() {
		return atchList;
	}
	public void setAtchList(List<ItemAttachVO> atchList) {
		this.atchList = atchList;
	}
	@Override
	public String toString() {
		return "ItemVO [itemId=" + itemId + ", itemName=" + itemName + ", price=" + price + ", description="
				+ description + ", pictureUrl=" + pictureUrl + ", pictureUrl2=" + pictureUrl2 + ", picture=" + picture
				+ ", atchList=" + atchList + "]";
	}

	
}
