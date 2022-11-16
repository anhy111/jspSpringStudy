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
								data-userno="${bookVO.bookId}" 
								data-seq="${attachVO.seq}" 
								data-title2="${bookVO.title}" data-regDate="${attachVO.regdate}">
								<img src="/resources/upload${attachVO.filename}?v=1"
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
				<input type="text" id="txtUserNo" />
				<input type="text" id="txtSeq" />
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<p id="body-content">One fine body…</p>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="text-left">
				<button id="close" type="button" class="btn btn-default"
					data-dismiss="modal">Close</button>
				</div>
				<div class="text-right">
					<!-- 일반 모드 -->
					<span id="spn1" class="text-right">
						<button id="edit" type="button" class="btn btn-primary">수정</button>
						<button id="delete" type="button" class="btn btn-danger">삭제</button>
					</span>
					<!-- 일반 모드 끝 -->
					<!-- 수정 모드 -->
					<span id="spn2" class="text-right">
						<div class="input-group justify-content-between">
							<div class="custom-file text-left">
								<input type="file" class="custom-file-input"
										id="uploadFile" name="uploadFile" style="width: 200px;" />
								<label class="custom-file-label" for="uploadFile">Choose file</label>
							</div>
							<div class="text-right">
								<button id="uploadBtn" type="button" class="btn btn-success">확인</button>
								<button id="cancel" type="button" class="btn btn-warning">취소</button>
							</div>
						</div>
					</span>
					<!-- 수정 모드 끝 -->
				</div>
			</div>
		</div>

	</div>

</div>
<script type="text/javascript">
	var $spn1;
	var $spn2;

	$(function() {

		$spn1 = $("#spn1");
		$spn2 = $("#spn2");

		$spn2.css("display", "none");

		// data-id="..."
		$(".btn-modal").click(
				function() {
					let data = $(this).data("id");
					let title = $(this).data("title2");
					let regdate = $(this).data("regdate");
					let userNo = $(this).data("userno");
					let seq = $(this).data("seq");
					
					console.log("data : " + data + ", title : " + title +
								", userNo : " + userNo + ", seq : " + seq);

					$("#body-content").html(
							"<p class='text-right'>" + regdate
									+ "</p><img src='" + data
									+ "' style='width:100%' />");
					$(".modal-title").html(title);

					$spn1.css("display", "block");
					$spn2.css("display", "none");
					$("#txtUserNo").val(userNo);
					$("#txtSeq").val(seq);
					
				});

		let currentBookId = "${param.bookId}"
		let sel = "";

		$
				.ajax({
					url : "/book/listAjax",
					type : "get",
					datatype : "json",
					success : function(data) {
						let $select = $(".custom-select");

						$
								.each(
										data,
										function(index, item) {

											if (item.bookId == currentBookId) {
												sel = "selected='selected'";
											} else {
												sel = "";
											}

											$select
													.append("<option value='"
								+item.bookId+"'" + sel + ">"
															+ item.title
															+ "</option>");
										});
					}
				});

		$(".custom-select").on("change", function() {
			let bookId = $(this).val();

			location.href = "/gallery/list?bookId=" + bookId;
		});

		$("#edit").on("click", function() {
			$spn1.css("display", "none");
			$spn2.css("display", "block");
		});

		$("#cancel").on("click", function() {
			$spn1.css("display", "block");
			$spn2.css("display", "none");
		});

		
		// ajax 파일 업로드 구현 시작
		// 이미지 체킹
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	// 정규식
		let maxSize = 5242880 // 5MB
		
		function checkExtension(fileName, fileSize){ // 확장자, 크기 체킹
			if(fileSize >= maxSize){
				alert("파일 사이즈가 초과되었습니다.");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			
			return true;
			
		}
		
		
		$("#uploadBtn").on("click", function(e) {
			// 가상의 form 생성
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			
			// 파일 object안에 이미지를 가져오기
			let files = inputFile[0].files;

			// 가상의 form에 filedata 추가
			for(let i=0; i<files.length; i++){
				
				//파일 확장자, 크기 체크(exe, sh, zip, alz, 5MB이상 검출)
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				// <form><input type='file' name='uploadFile' /></form>
				formData.append("uploadFile",files[i]);
			}
			
			formData.append("userNo",$("#txtUserNo").val());
			formData.append("seq",$("#txtSeq").val());
			
			$.ajax({
				url:"/gallery/updatePost",
				processData:false,
				contentType:false,
				enctype: 'multipart/form-data', 
				data:formData,
				dataType:"json",
				type:"post",
				success:function(result){
					console.log("result : " + JSON.stringify(result));
				}
			})
		});
		// ajax 파일 업로드 구현 끝
		
		// 이미지 미리보기 시작
		let sel_file = [];
		$("#uploadFile").on("change",handleImgFileSelect);
		// e : onchange 이벤트 객체
		function handleImgFileSelect(e){
			// 이벤트가 발생된 타겟 안에 들어있는 이미지 파일들을 가져와보자
			let files = e.target.files;
			// 이미지가 여러개 있을 수 있으므로 이미지들을 각각 분리해서 배열로 만듦
			let fileArr = Array.prototype.slice.call(files);
			
			// 파일 타입의 배열 반복. f : 배열 안에 들어있는 각각의 이미지 파일 객체
			fileArr.forEach(function(f){
				// 이미지 파일이 아닌 경우 이미지 미리보기 실패 처리
				if(!f.type.match("image.*")){
					alert("이미지 확장자만 가능합니다.");
					return;
				}
				// 이미지 객체를 전역 배열타입 변수에 넣자
				sel_file.push(f);
				// 이미지 객체를 읽을 자바스크립트의 reader 객체 생성
				let reader = new FileReader();
				// e : reader가 이미지 객체를 읽는 이벤트
				reader.onload = function(e){
					// e.target : f(이미지 객체)
					// e.target.result : reader가 이미지를 다 읽은 결과
					let img_html = "<img src=\"" + e.target.result + "\" style='width:100%;'/>";
					// p 사이에 이미지가 렌더링되어 화면에 보임
					$("#body-content").html(img_html);
				}
				// f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
				reader.readAsDataURL(f);
			}); // end forEach
		}// end function
		// 이미지 미리보기 끝
		
		// 이미지 삭제
		$("#delete").on("click",function(){
			let userNo = $("#txtUserNo").val();
			let seq = $("#txtSeq").val();
			
			console.log("userNo : " + userNo + ", seq : " + seq);
			
			let data = {"userNo" : userNo,"seq" : seq };
			
			console.log("data : " + JSON.stringify(data));
			
			$.ajax({
				url:"/gallery/deletePost",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				dataType:"json",
				type:"post",
				success:function(result){
					if(result.result){
						location.reload();
					} else {
						alert("삭제에 실패했습니다.");
					}
				}
			});
		});
		
	});
</script>
