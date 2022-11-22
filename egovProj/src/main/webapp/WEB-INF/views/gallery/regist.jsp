<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/adminlte/plugins/sweetalert2/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/adminlte/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<script type="text/javascript">
	
	let sel_file = [];	// 이미지 객체 배열
	let select;			// 선택된 book객체
	// 이미지 미리보기 function
	function handleImgFileSelect(e) {
		$("#card-images").html("");
		let files = e.target.files;
		// 객체 -> 배열 변환
		let fileArr = Array.prototype.slice.call(files);
		
		// f: 각각의 이미지 파일
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.");
				return;
			}
			
			sel_file.push(f);
			
			// 이미지 읽어보자
			let reader = new FileReader();
			
			reader.onload = function(e){
				let img_html = "<img src=\"" + e.target.result + "\" style='width:50%;'/>";
				
				$("#card-images").append(img_html);
			}
			// 다음 이미지 파일(f)을 위해 리더를 초기화
			reader.readAsDataURL(f);
		});
	}// end handleImgFileSelect
	
	function fn_getInsertDate(geta){
		let dt = new Date(geta);
		let dtYY = dt.getFullYear();
		let dtMM = dt.getMonth() < 10 ? "0" + dt.getMonth() : dt.getMonth();
		let dtDD = dt.getDate()< 10 ? "0" + dt.getDate() : dt.getDate();
		let dtHH = dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours();
		let dtMI = dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes();
		let dtResult = dtYY + "-" + dtMM + "-" + dtDD + " " + dtHH + ":" + dtMI;
	   
		return dtResult;
	}


	let $keyword;
	let rsltSearch = [];
	
	function insert(id){

		$.each(rsltSearch,function(inx, val){
			if(val.bookId == id){
				select = this;
			}
		});
		$("#bookId").val(select.bookId);
		$("#title").val(select.title);
		$("#category").val(select.category).prop("selected",true);
		$("#price").val(select.price);
		
		$("#insertDate").val(fn_getInsertDate(select.insertDate));
		CKEDITOR.instances.content.setData(select.content)
		
		// 모달 닫기
		$("#modal-lg").modal("hide");
		
		$("#input_imgs").removeAttr("disabled");
	}

	$(function() {
		
		var Toast = Swal.mixin({
			toast: true,
			position: 'top-end',
			showConfirmButton: false,
			timer: 3000
		});
		  
		
		CKEDITOR.replace("content");
		let $keyword = $("#keyword");
		let $search = $("#search");
		
		
		$search.on("click", function() {
			let keyword = $keyword.val();
			
			let data = {
				"title" : keyword
			};
			
			// 스프링 시큐리티를 위한 토큰 처리(csrf) -> 볼토엔 큰 코스로 픽스!
			let header = "${_csrf.headerName}";
			let token = "${_csrf.token}";
			
			console.log("Header : " + header + ", token : " + token);
			
			
			$.ajax({
				url : "/book/searchBook",
				type : "post",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				datatype : "json",
				beforeSend:function(xhr){
					xhr.setRequestHeader(header, token);
				},
				success : function(result) {
					$(".list-group").html("");
					rsltSearch = result;
					$.each(result, function(index, item){
						
						
						let content = item.content + "...";
						content = content.length < 50 
										? content
										: content.substring(0,50);
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
												<div class="float-right">` + fn_getInsertDate(item.insertDate) + `</div>
												<h3><a href="javascript:insert(\${item.bookId})">` + item.title + `</a></h3>
												<p class="mb-0">` + content + `</p>
											</div>
										</div>
									</div>`;
						$(".list-group").append(str);
					});
				}
			})
		}); // and search function
		
		$("#input_imgs").on("change",handleImgFileSelect);
		
		$("#uploadBtn").on("click", function(){
			// 가상 폼(이미지들)
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			// 이미지 파일들을 변수에 담음
			let files = inputFile[0].files;
			
			console.log("files : ", files);
			
			// 가상폼인 formdata에 이미지를 넣자
			for(let i=0; i<files.length; i++){
				// uploadFile[]
				formData.append("uploadFile",files[i]);
			}
			
			let bookId = $("#bookId").val()
			formData.append("bookId", bookId);

			let header = "${_csrf.headerName}";
			let token = "${_csrf.token}";
			
			$.ajax({
				url:"/gallery/uploadAjaxAction",
				processData:false,
				contentType:false,
				data:formData,
				dataType:"json",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader(header, token);
				},
				success:function(data){
					let result = data.result;
					console.log("result : " + result);
					if(result){
						Toast.fire({
							icon:'success',
							title:'성공'
						});
						
						setTimeout(() => {
							location.href="/gallery/list?bookId=" + select.bookId;
						}, 3000);
					} else{
						Toast.fire({
							icon:'error',
							title:'실패'
						});
					}
				}
			})
			
		});

	});// end onload
</script>
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">도서 정보</h3>
					<input type="text" id="bookId" name="bookId" />
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
							<input type="text" id="title" name="title" class="form-control"
								readonly />
						</div>
						<div style="width: 30%; float: right;">
							<button type="button"
								class="btn btn-outline-info btn-block btn-flat"
								data-toggle="modal" data-target="#modal-lg">
								<i class="fa fa-book"></i>책 검색
							</button>
						</div>
					</div>
					<div class="form-group">
						<label for="category">카테고리</label> <select id="category"
							name="category" class="form-control custom-select">
							<option value="a0101" selected disabled>소설</option>
							<option value="a0102" disabled>에세이</option>
							<option value="a0103" disabled>어린이</option>
							<option value="a0104" disabled>요리</option>
							<option value="a0105" disabled>수험서</option>
							<option value="a0106" disabled>자격증</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">가격</label> <input type="number" id="price"
							name="price" class="form-control" readonly />
					</div>
					<div class="form-group">
						<label for="insertDate">입력 일자</label> <input type="text"
							id="insertDate" name="insertDate" class="form-control" readonly />
					</div>
					<div class="form-group">
						<label for="content">책 내용</label>
						<textarea id="content" name="content" class="form-control"
							rows="4" readonly></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card card-secondary">
				<div class="card-header">
					<h3 class="card-title">이미지 정보</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<!-- 미리보기 이미지 시작 -->
				<div class="card-body" id="card-images">
					
				</div>
				<!-- 미리보기 이미지 끝 -->
				<div class="card-footer">
					<div class="input-group">
						<div class="custom-file">
							<input type="file" class="custom-file-input" disabled
								id="input_imgs" name="uploadFile" multiple> <label class="custom-file-label"
								for="input_imgs">Choose file</label>
						</div>
						<div class="input-group-append">
							<span class="input-group-text" id="uploadBtn"
								style="cursor: pointer;" >Upload</span>
						</div>
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
							<div class="input-group">
								<input id="keyword" type="text"
									class="form-control form-control-lg" placeholder="찾을 책을 검색하삼">
								<div class="input-group-append">
									<button id="search" type="button"
										class="btn btn-lg btn-default">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 결과영역 -->
					<div class="row mt-3">
						<div class="col-md-10 offset-md-1">
							<div class="list-group"></div>
						</div>
					</div>
					<div class="modal-footer">
						<button id="close" type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
