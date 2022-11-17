<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	let $keyword;
	let rsltSearch = [];
	function insert(id){
		let select;
		$.each(rsltSearch,function(inx, val){
			if(val.bookId == id){
				select = this;
			}
		});
		$("#close").click();
		
		$("#title").val(select.title);
		$("#category > option[value='"+select.category+"']").attr("selected","true");
		$("#price").val(select.price);
		
		let dt = new Date(select.insertDate);
		
		let dtYY = dt.getFullYear();
		let dtMM = dt.getMonth() < 10 ? "0"+dt.getMonth() : dt.getMonth();
		let dtDD = dt.getDate()< 10 ? "0"+dt.getDate() : dt.getDate();
		let dtResult = dtYY + "-" + dtMM + "-" + dtDD;
		$("#insertDate").val(dtResult);
		CKEDITOR.instances.content.setData(select.content)
	}

	$(function() {
		CKEDITOR.replace("content");
		let $keyword = $("#keyword");
		let $search2 = $("#search2");

		$("#search").on("click", function() {
			let title = $("#title").val();
			$(".form-control-lg").val(title);
			$search2.click();
		});

		$search2.on("click", function() {
			let keyword = $keyword.val();

			let data = {
				"title" : keyword
			};

			$.ajax({
				url : "/book/searchBook",
				type : "post",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				datatype : "json",
				success : function(result) {
					$(".list-group").html("");
					rsltSearch = result;

					$.each(result, function(index, item){
						
						let dt = new Date(item.insertDate);
						
						let dtYY = dt.getFullYear();
						let dtMM = dt.getMonth() < 10 ? "0"+dt.getMonth() : dt.getMonth();
						let dtDD = dt.getDate()< 10 ? "0"+dt.getDate() : dt.getDate();
						let dtHH = dt.getHours()< 10 ? "0"+dt.getHours() : dt.getHours();
						let dtMI = dt.getMinutes()< 10 ? "0"+dt.getMinutes() : dt.getMinutes();
						let dtResult = dtYY + "-" + dtMM + "-" + dtDD + " " + dtHH + ":" + dtMI;
						
						
						let content = item.content.length < 50 
										? item.content 
										: item.content.substring(0,50)+"...";
						let filename;
						if(item.attachVOList.length > 0){
							filename = item.attachVOList[0].filename;
						} else{
							filename = "/file.png";
						}
						
						let str = `<div class="list-group-item">
									<div class="row">
										<div class="col-auto">
											<img class="img-fluid" src="/resources/upload` + filename +
												`" alt="Photo" style="max-height: 160px;">
										</div>
										<div class="col px-4">
											<div>
												<div class="float-right">` + dtResult + `</div>
												<h3 onclick="insert(\${item.bookId})">` + item.title + `</h3>
												<p class="mb-0">` + content + `</p>
											</div>
										</div>
									</div>`;
						$(".list-group").append(str);
					});
				}
			})
		});

	});
</script>
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">General</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<div style="clear: both;">
							<label for="title">제목</label>
						</div>
						<div style="width: 70%; float: left;">
							<input type="text" id="title" name="title" class="form-control" />
						</div>
						<div style="width: 30%; float: right;">
							<button type="button" id="search"
								class="btn btn-outline-info btn-block btn-flat"
								data-toggle="modal" data-target="#modal-lg">
								<i class="fa fa-book"></i>책 검색
							</button>
						</div>
					</div>
					<div class="form-group">
						<label for="category">카테고리</label> <select id="category"
							name="category" class="form-control custom-select">
							<option value="소설" selected>소설</option>
							<option value="에세이">에세이</option>
							<option value="어린이">어린이</option>
							<option value="요리">요리</option>
							<option value="수험서">수험서</option>
							<option value="자격증">자격증</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">가격</label> <input type="number" id="price"
							name="price" class="form-control" />
					</div>
					<div class="form-group">
						<label for="insertDate">입력 일자</label> <input type="date"
							id="insertDate" name="insertDate" class="form-control" />
					</div>
					<div class="form-group">
						<label for="content">책 내용</label>
						<textarea id="content" name="content" class="form-control"
							rows="4"></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card card-secondary">
				<div class="card-header">
					<h3 class="card-title">Budget</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="inputEstimatedBudget">Estimated budget</label> <input
							type="number" id="inputEstimatedBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputSpentBudget">Total amount spent</label> <input
							type="number" id="inputSpentBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputEstimatedDuration">Estimated project
							duration</label> <input type="number" id="inputEstimatedDuration"
							class="form-control">
					</div>
				</div>

			</div>

		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<a href="#" class="btn btn-secondary">Cancel</a> <input type="submit"
				value="Create new Project" class="btn btn-success float-right">
		</div>
	</div>

	<div class="modal fade" id="modal-lg" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">책 검색</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 검색영역 -->
					<div class="row">
						<div class="col-md-8 offset-md-2">
							<form action="">
								<div class="input-group">
									<input id="keyword" type="search"
										class="form-control form-control-lg" placeholder="찾을 책을 검색하삼">
									<div class="input-group-append">
										<button id="search2" type="button"
											class="btn btn-lg btn-default">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- 결과영역 -->
					<div class="row mt-3">
						<div class="col-md-10 offset-md-1">
							<div class="list-group"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-between">
						<button id="close" type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save
							changes</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
