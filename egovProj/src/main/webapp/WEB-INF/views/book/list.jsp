<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="card">
	<div class="card-header">
		<h3 class="card-title">DataTable with default features</h3>
	</div>

	<div class="card-body">
		<div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">
				<div class="col-sm-12">
					<table id="example1"
						class="table table-bordered table-striped dataTable dtr-inline"
						aria-describedby="example1_info">
						<thead>
							<tr>
								<th class="sorting sorting_asc" tabindex="0"
									aria-controls="example1" rowspan="1" colspan="1"
									aria-label="bookId: activate to sort column descending"
									aria-sort="ascending">bookId</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Title: activate to sort column ascending">Title</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Category: activate to sort column ascending">Category</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Price: activate to sort column ascending">Price</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Insert Date: activate to sort column ascending"
									style="">Insert Date</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="bookVO" items="${bookVOList}" varStatus="stat">
							<c:if test="${stat.count%2!=0}"><tr class="odd"></c:if>
							<c:if test="${stat.count%2==0}"><tr class="even"></c:if>
								<td class="dtr-control sorting_1" tabindex="0">${bookVO.bookId}</td>
								<td><a href="/book/detail?bookId=${bookVO.bookId}">${bookVO.title}</a></td>
								<td>${bookVO.category}</td>
								<td><fmt:formatNumber value="${bookVO.price}" pattern="#,###" /></td>
								<td><fmt:formatDate value="${bookVO.insertDate}" pattern="yyyy-MM-dd"/></td>
							</tr>
							</c:forEach>

						</tbody>
						<tfoot>
							<tr>
								<th rowspan="1" colspan="1">bookId</th>
								<th rowspan="1" colspan="1">Title</th>
								<th rowspan="1" colspan="1">Category</th>
								<th rowspan="1" colspan="1">Price</th>
								<th rowspan="1" colspan="1" style="">Insert Date</th>
							</tr>
						</tfoot>
					</table>
					<div class="row">
						<div class="col text-right">
							<br>
							<a href="/book/insert" class="btn btn-primary">등록</a>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>