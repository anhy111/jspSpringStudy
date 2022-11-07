<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">회원목록</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<form name="frm" action="/mem/memList" method="get">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label>Show <select name="size" id="show"
								aria-controls="dataTable"
								class="custom-select custom-select-sm form-control form-control-sm"><option
										value="10"
										<c:if test="${param.size=='10'}">selected</c:if>	
									>10</option>
									<option value="25"
										<c:if test="${param.size=='25'}">selected</c:if>
									>25</option>
									<option value="50"
										<c:if test="${param.size=='50'}">selected</c:if>
									>50</option>
									<option value="100"
										<c:if test="${param.size=='100'}">selected</c:if>
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
								  <option value="userNo"
								  		<c:if test="${param.cond=='userNo'}">selected</c:if>
								  >회원번호</option>
								  <option value="userId" 
								   		<c:if test="${param.cond=='userId'}">selected</c:if>
								   >회원아이디</option>
								  <option value="userName"
								  		<c:if test="${param.cond=='userName'}">selected</c:if>
								  >회원명</option>
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
										style="width: 10%;">번호</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Position: activate to sort column ascending"
										style="width: 20%;">회원 번호</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Office: activate to sort column ascending"
										style="width: 15%;">회원 아이디</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 20%;">회원 명</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Start date: activate to sort column ascending"
										style="width: 15%;">입력일자</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Salary: activate to sort column ascending"
										style="width: 10%;">활성화 여부</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Salary: activate to sort column ascending"
										style="width: 10%;">부여권한</th>
								</tr>
							</thead>
							<tbody>
							<!-- data.content => List<MemVO> memVOList -->
							<c:forEach var="memVO" items="${data.content}" varStatus="stat">
								<tr class="odd">
									<td class="sorting_1">${memVO.rnum}</td>
									<td>${memVO.userNo}</td>
									<td>${memVO.userId}</td>
									<td>${memVO.userName}</td>
									<td><fmt:formatDate value="${memVO.regDate}"
									pattern="yyyy-MM-dd" /> </td>
									<td>
									<c:if test="${memVO.enabled=='1'}">회원</c:if>
									<c:if test="${memVO.enabled=='0'}">탈퇴</c:if>
									</td>
									<td>
									<!-- memVO.memAuthVOList => List<MemAuthVO> -->
										<c:forEach var="memAuthVO" items="${memVO.memAuthVOList}" varStatus="stat">
											<c:choose>
												<c:when test="${memAuthVO.auth=='manager'}">
													<a href="#" class="btn btn-success btn-circle btn-sm"
													title="manager" alt="manager">
				                                        <i class="fas fa-check"></i>
				                                    </a>
			                                    </c:when>
			                                    <c:when test="${memAuthVO.auth=='employer'}">
				                                    <a href="#" class="btn btn-info btn-circle btn-sm"
				                                    title="employer" alt="employer">
				                                        <i class="fas fa-info-circle"></i>
				                                    </a>
			                                    </c:when>
			                                    <c:when test="${memAuthVO.auth=='employee'}">
				                                    <a href="#" class="btn btn-warning btn-circle btn-sm"
				                                    title="employee" alt="employee">
				                                        <i class="fas fa-exclamation-triangle"></i>
				                                    </a>
			                                    </c:when>
		                                    </c:choose>
										</c:forEach>
									</td>
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
	                     
	                  </div>
	               </div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous 
									<c:if test='${data.startPage lt 6}'>disabled</c:if>
								"
									id="dataTable_previous">
									<a href="/mem/memList?size=${map.size}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${data.startPage - 5}"
									aria-controls="dataTable" data-dt-idx="0" tabindex="0"
									class="page-link">Previous</a></li>
								<!-- data : ArticlePage 객체  -->
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
								<li class="paginate_button page-item
									<c:if test='${param.currentPage==pNo}'>active</c:if>
								">
								<!-- model.addAttribute("map", map); -->
								<a href="/mem/memList?size=${map.size}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${pNo}"
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
									href="/mem/memList?size=${map.size}&cond=${map.cond}&keyword=${map.keyword}&currentPage=${data.startPage + 5}" aria-controls="dataTable" data-dt-idx="7" tabindex="0"
									class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




