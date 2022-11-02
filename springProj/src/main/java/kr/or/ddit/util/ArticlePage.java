package kr.or.ddit.util;

import java.util.List;

// 페이징 관련 정보 + 게시글 데이터
public class ArticlePage<T> {
	// 전체글 수
	private int total;
	// 현재 페이지 번호
	private int currentPage;
	// 전체 페이지 수
	private int totalPages;
	// 시작 페이지 번호
	private int startPage;
	// 종료 페이지 번호
	private int endPage;
	// 페이징 사이즈
	private int pageSize = 5;
	// 데이터
	private List<T> content;
	// 생성자(Constructor) : 페이징 정보 생성
	public ArticlePage(int total, int currentPage, int size, List<T> content) {
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		
		// 전체 글 / 화면에 보여질 행 수 => 전체 페이지 수
		totalPages = total / size;
		
		if(total % size > 0) {
			totalPages++;
		}
		
		// 시작 페이지 = 현재 페이지 / 페이지크기  * 페이지크기 + 1
		this.startPage = currentPage / pageSize * pageSize + 1;
		
		if(currentPage % pageSize == 0) {
			startPage -= pageSize;
		}
		
		endPage = startPage + (pageSize - 1);
		// 종료페이지 > 총페이지 => 총페이지로 변환
		endPage = endPage > totalPages ? totalPages : endPage;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<T> getContent() {
		return content;
	}
	public void setContent(List<T> content) {
		this.content = content;
	}
	
	public boolean hasNoArticles() {
		return total == 0;
	}
	
	public boolean hasArticles() {
		return total > 0;
	}
}
