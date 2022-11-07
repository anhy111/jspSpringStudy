<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<div class="card shadow mb-4">
	<div class="card-body">
		<div class="table-responsive">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<!-- /article/list?show=10&cond=title&keyword=개똥이-->
				<form name="frm" id="frm" action="/article/list" method="get">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label>Show <select name="show" id="show"
								aria-controls="dataTable"
								class="custom-select custom-select-sm form-control form-control-sm"><option
										value="10"
										<c:if test="${param.show=='10'}">selected</c:if>	
									>10</option>
									<option value="25"
										<c:if test="${param.show=='25'}">selected</c:if>
									>25</option>
									<option value="50"
										<c:if test="${param.show=='50'}">selected</c:if>
									>50</option>
									<option value="100"
										<c:if test="${param.show=='100'}">selected</c:if>
									>100</option></select> entries
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter">
							<label>검색 
								<select name="cond" aria-controls="dataTable"
									class="custom-select custom-select-sm form-control form-control-sm">
								  <option value="">전체</option>
								  <option value="title"
								  		<c:if test="${param.cond=='title'}">selected</c:if>
								  >글제목</option>
								  <option value="writerName" 
								   		<c:if test="${param.cond=='writerName'}">selected</c:if>
								   >작성자</option>
								  <option value="artContent"
								  		<c:if test="${param.cond=='artContent'}">selected</c:if>
								  >글내용</option>
								</select>
							</label>
							<label>
								<input type="search" name="keyword"
								class="form-control form-control-sm" 
								placeholder="검색어를 입력하세요"
								aria-controls="dataTable" 
								value="${param.keyword}" />
							</label>
							<label>
								<button type="submit" class="btn btn-primary btn-icon-split btn-sm">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-flag"></i>
                                    </span>
                                    <span class="text">검색</span>
                                </button>
							</label>
						</div>
					</div>
				</div>
				</form>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered dataTable" id="dataTable"
							width="100%" cellspacing="0" role="grid"
							aria-describedby="dataTable_info" style="width: 100%;">
							<thead>
								<tr role="row">
									<th class="sorting sorting_asc" tabindex="0"
										aria-controls="dataTable" rowspan="1" colspan="1"
										aria-sort="ascending"
										aria-label="Name: activate to sort column descending"
										style="width: 10%;">글번호</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Position: activate to sort column ascending"
										style="width: 40%;">글제목</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Office: activate to sort column ascending"
										style="width: 20%;">작성자</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 15%;">작성일</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Start date: activate to sort column ascending"
										style="width: 15%;">조회수</th>
								</tr>
							</thead>
							<tbody>
							<!-- model.addAttribute("data", list); -->
							<!-- data : 페이징 처리 전 List<ArticleVO> list
										페이징 처리 후 ArticlePage 객체
							 -->
							<!-- data.content : List<ArticleVO> list -->
							<!-- row : ArticleVO articleVO -->
							<c:forEach var="row" items="${data.content}" varStatus="stat">
								<c:if test="${stat.count%2==0}">
									<tr class="even">
								</c:if>
								<c:if test="${stat.count%2!=0}">
									<tr class="odd">
								</c:if>
									<td class="sorting_1">${row.rnum}</td>
									<td><a href="/article/detail?articleNo=${row.articleNo}">${row.title}</a></td>
									<td>${row.writerName}</td>
									<td>
										<fmt:formatDate value="${row.regdate}" 
										pattern="yyyy.MM.dd" />
									</td>
									<td>${row.readCnt}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-5">
						<div class="dataTables_info" id="dataTable_info" role="status"
							aria-live="polite">
							<c:if test="${param.show==null}">
								<c:set var="show" value="1" />
							</c:if>
							<c:if test="${param.show!=null}">
								<c:set var="show" value="${param.show}" />
							</c:if>
							<!-- scope(공유영역) : page(기본), request, session, application -->
							<!-- 종료행 : currentPage * show -->
							<c:set var="endRow" value="${data.currentPage * show}" />							
							<!-- 시작행 : 종료행 - (size-1) -->
							<c:set var="startRow" value="${endRow - (show-1)}" />
							<!-- 전체행수 : total -->
							<c:if test="${endRow > data.total}">
		                        <c:set var="endRow" value="${data.total}"/>
		                     </c:if>
							Showing ${startRow} to ${endRow} of ${data.total} entries
						</div>
					</div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<!-- class="..... disabled => 비활성 -->
								<li class="paginate_button page-item previous 
										<c:if test='${data.startPage lt 6}'>disabled</c:if>
									"
									id="dataTable_previous">
									<a href="/article/list?show=${map.show}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${data.startPage-5}"
									aria-controls="dataTable" data-dt-idx="0" tabindex="0"
									class="page-link">Previous</a></li>
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
								<!-- class="..... active" => 현재페이지. 파랑색을 띔 -->
								<li class="paginate_button page-item
									<c:if test='${param.currentPage==pNo}'>active</c:if>
								">
								<!-- 
									1) 검색 안함 : ?show=&cond=&keyword=&currentPage=3 
									2) 검색 함    : ?show=10&cond=title&keyword=개똥이&currentPage=3
								-->
								<a href="/article/list?show=${map.show}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${pNo}"
									aria-controls="dataTable" data-dt-idx="1" tabindex="0"
									class="page-link">${pNo}</a></li>
								</c:forEach>
								<!-- EL태그 정리 
									== : eq(equal)
									!= : ne(not equal)
									<  : lt(less than)
									>  : gt(greater than)
									<= : le(less equal)
									>= : ge(greater equal)
								 -->
								<li class="paginate_button page-item next
									<c:if test='${data.endPage ge data.totalPages}'>disabled</c:if>
								" id="dataTable_next"><a
									href="/article/list?show=${map.show}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${data.startPage+5}" aria-controls="dataTable" data-dt-idx="7" tabindex="0"
									class="page-link">Next</a></li>
									<a href="/article/write" class="btn btn-primary btn-icon-split btn-sm"
									style="position:absolute;left:80%;">
		                               <span class="icon text-white-50">
		                                   <i class="fas fa-flag"></i>
		                               </span>
		                               <span class="text">글작성</span>
		                           </a>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


