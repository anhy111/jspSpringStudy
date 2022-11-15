<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
<div class="col-12">
	<div class="card card-primary">
		<div class="card-header">
			<!-- 도서선턱 시작 -->
			<!-- 
				ajax를 통해 append
			 -->
			<select class="custom-select"></select>
			<!-- 도서선택 끝 -->
		</div>
		<div class="card-body">
			<div class="row">
				<!-- 모달을 띄우는 방법
				1. Button으로 띄우기
				<button type="button" class="btn btn-default"
				data-toggle="modal" data-target="#modal-default">
				Launch Default Model
				</button> 
				
				2. a 태그로 띄우기
				<a data-toggle="modal" href="#modal-default">Open Modal</a>
				
				3. 기타 요소로 띄우기
				<p data-toggle="modal" data-target="#modal-default">Open Modal</a>
				-->
				<c:forEach var="attachVO" items="${bookVO.attachVOList}"
					varStatus="stat">
					<c:if test="${stat.count <= 12}">
						<div class="col-sm-2">
							<a href="#" class="btn btn-modal" data-toggle="modal"
								data-title="sample 1 - white" data-target="#modal-default"
								data-id="/resources/upload${attachVO.filename}"
								data-title="${bookVO.title}" data-regDate="${attachVO.regdate}">
								<img src="/resources/upload${attachVO.filename}"
								class="img-fluid mb-2" alt="white sample" />
							</a>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal-default" aria-hidden="true"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Default Modal</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<p id="body-content">One fine body…</p>
			</div>
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>

	</div>

</div>
<script type="text/javascript">
	$(function() {
		// data-id="..."
		$(".btn-modal").click(
				function() {
					let data = $(this).data("id");
					let title = $(this).data("title");
					let regdate = $(this).data("regdate");

					$("#body-content").html(
							"<p class='text-right'>" + regdate
									+ "</p><img src='" + data
									+ "' style='width:100%' />");
					$(".modal-title").html(title);
				});
		

		
		let currentBookId = "${param.bookId}"
		let sel = "";
		
		$.ajax({
			url : "/book/listAjax",
			type : "get",
			datatype:"json",
			success:function(data){
				let $select = $(".custom-select");
				
				$.each(data, function(index, item){
					
					if(item.bookId == currentBookId){
						sel = "selected='selected'";
					} else{
						sel = "";
					}
					
					$select.append("<option value='"
								+item.bookId+"'" + sel + ">"+item.title+"</option>");
				});
			}
		});
		
		$(".custom-select").on("change",function(){
			let bookId = $(this).val();
			
			location.href = "/gallery/list?bookId=" + bookId;
		});
	});
</script>
