package com.fcryan.dto;

public class PageMakerDTO {
	private int totalCount; // 17         // 전체 데이터 개수
	private int startPage;  //1           // 시작 페이지 번호
	private int endPage;    // 2         // 끝 페이지 번호
	private boolean prev;  // false            // 이전 페이지
	private boolean next;  // false          // 이후 페이지
	private int displayPageNum = 10; // 화면에 보여지는 블럭 수
	private int finalPage;
	
	private CriteriaDTO criDto;  // page(1), pagestart(1), perPageNum(10)

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}
	
	private void calcData() {
		// Math 클래스의 ceil 메서드는 무조건 소수점을 올림함 0.2 = 1로 처리
		endPage = (int)Math.ceil(criDto.getPage() / (double)displayPageNum) * displayPageNum;
		//                             1  /  10  * 10
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int)(Math.ceil(totalCount / (double)(criDto.getPerPageNum() / criDto.getPage())));
		//                                17 / 10 / 1
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		prev = startPage == 1 ? false : true;
		next = (endPage * (criDto.getPerPageNum()/criDto.getPage())) >= totalCount ? false : true;
		
		finalPage = (int)Math.ceil(totalCount / (double)(displayPageNum)); 
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

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public CriteriaDTO getCriDto() {
		return criDto;
	}

	public void setCriDto(CriteriaDTO criDto) {
		this.criDto = criDto;
	}
	
	public int getFinalPage() {
		return finalPage;
	}

	public void setFinalPage(int finalPage) {
		this.finalPage = finalPage;
	}

	@Override
	public String toString() {
		return "PageMakerDTO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", prev=" + prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", finalPage="
				+ finalPage + ", criDto=" + criDto + "]";
	}

}
