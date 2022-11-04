<%@page import="com.fasterxml.jackson.databind.deser.impl.CreatorCandidate.Param"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("[name='show']").on("change",function(){
			
			let currentPage = "${param.currentPage}";
			if(currentPage==""){
				currentPage = 1;
			}
			location.href="<%=request.getContextPath()%>/board/list?currentPage=1&show="
							+ this.value;
		});
	});
</script>
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">Member Table</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<form name="frm" id="frm" action="/board/list" method="get">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label>Show <select id="show" name="show"
								aria-controls="dataTable"
								class="custom-select custom-select-sm form-control form-control-sm">
									<option value="10"
										<c:if test='${param.show eq 10}'>selected</c:if>
										>10</option>
									<option value="25"
									<c:if test='${param.show eq 25}'>selected</c:if>
										>25</option>
									<option value="50"
									<c:if test='${param.show eq 50}'>selected</c:if>
										>50</option>
									<option value="100"
									<c:if test='${param.show eq 100}'>selected</c:if>
										>100</option></select> entries
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter">
							<label>
								<input type="search" name="keyword"
								class="form-control form-control-sm" 
								placeholder="검색어를 입력하세요"
								aria-controls="dataTable"
								value="${param.keyword}">
							</label>
							<label>
								<button type="submit" class="btn btn-primary btn-icon-split btn-sm">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-flag"></i>
                                    </span>
                                    <span class="text">통합검색</span>
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
									<th class="sorting sorting_desc" tabindex="0"
										aria-controls="dataTable" rowspan="1" colspan="1"
										aria-label="Name: activate to sort column ascending"
										style="width: 57px;" aria-sort="descending">ID</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Position: activate to sort column ascending"
										style="width: 61px;">Name</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Office: activate to sort column ascending"
										style="width: 49px;">Job</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 31px;">Like</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 31px;">HP</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th rowspan="1" colspan="1">ID</th>
									<th rowspan="1" colspan="1">Name</th>
									<th rowspan="1" colspan="1">Job</th>
									<th rowspan="1" colspan="1">Like</th>
									<th rowspan="1" colspan="1">HP</th>
								</tr>
							</tfoot>
							<tbody id="mytbody">
								<c:forEach var="mem" items="${data.content}" varStatus="stat">
									<c:if test="${stat.count%2 == 0}">
										<tr class="even" style="background-color:#f0f8ff;">
									</c:if>
									<c:if test="${stat.count%2 != 0}">
										<tr class="odd">
									</c:if>
										<td class="sorting_1">${mem.memId}</td>
										<td><a href="/board/detail?memId=${mem.memId}">${mem.memName}</a></td>
										<td>${mem.memJob}</td>
										<td>${mem.memLike}</td>
										<td>${mem.memHp}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="offset-10 col-sm-2" align="right">
						<a href="/board/insert" class="btn btn-info btn-icon-split"> <span
							class="icon text-white-50"> <i class="fas fa-info-circle"></i>
						</span> <span class="text">회원 등록</span>
						</a>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-5">
						<div class="dataTables_info" id="dataTable_info" role="status"
							aria-live="polite">
							<!-- EL 태그 정리
									== : eq(equla)
									!= : ne(not equal)
									< : lt
									> : gt
									<= : le
									>= : ge
								 -->
							
							<c:if test="${param.show==null}">
								<c:set var="show" value="10" />
							</c:if>
							<c:if test="${param.show!=null}">
								<c:set var="show" value="${param.show}" />
							</c:if>
							<c:if test="${param.currentPage==null}">
								<c:set var="currentPage" value="1" />
							</c:if>
							<c:if test="${param.currentPage!=null}">
								<c:set var="currentPage" value="${param.currentPage}" />
							</c:if>
							<c:set var="endRow" value="${currentPage * show}" />
							<c:set var="startRow" value="${endRow-(show-1)}" />
							<!-- startRow 계산 후 표시할 endRow 계산 -->
							<c:if test="${endRow gt data.total}">
								<c:set var="endRow" value="${data.total}" />
							</c:if>
							<!-- 시작행번호 : 종료행 번호 - (10-1) -->
							Showing ${startRow} to ${endRow} of ${data.total} entries
						</div>
					</div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<li
									class="paginate_button page-item previous 
									<c:if test='${data.startPage lt 6}'>disabled</c:if>"
									id="dataTable_previous"><a href="/board/list?currentPage=${data.startPage-5}&show=${show}"
									aria-controls="dataTable" data-dt-idx="0" tabindex="0"
									class="page-link">Previous</a></li>
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
									<li class="paginate_button page-item
										<c:if test='${currentPage==pNo}'>active</c:if>
										"><a
										href="/board/list?currentPage=${pNo}&show=${show}"
										aria-controls="dataTable" data-dt-idx="1" tabindex="0"
										class="page-link">${pNo}</a></li>
								</c:forEach>
								<li class="paginate_button page-item next
									<c:if test="${data.endPage ge data.totalPages}">disabled</c:if>"
									id="dataTable_next"><a
									href="/board/list?currentPage=${data.startPage+5}&show=${show}" aria-controls="dataTable" data-dt-idx="7" tabindex="0"
									class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
