<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style type="text/css">
	.imgs_wrap{
		width: 300px;
		margin-top: 50px;
	}
	
	.imgs_wrap img{
		max-width: 100%;
	}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	var duplicateCheck = false;
	var imgCheck = false;
	$(function(){
		// 중복 검사
		$("#duplicate").on("click",samDup);
		
		// 유효성
		$("#frm").submit(validation);
		
		// 이미지 미리보기
		let sel_file = [];
		
		$("#memImage").on("change",handleImgFileSelect);
		
		function handleImgFileSelect(e) {
			$(".imgs_wrap").html("");
			
			let files = e.target.files;
			let isImage = true;
			// 이미지가 여러개가 있을 수 있으므로 이미지를 분리하여 배열로 만듦
			let fileArr = Array.prototype.slice.call(files);
			
			fileArr.forEach(function(f){
				// 유효성 검사
				if(!f.type.match("image.*")){
					alert("이미지 확장자만 가능합니다.");
					isImage = false;
					return;
				}
				
				sel_file.push(f);
				
				let reader = new FileReader();
				reader.onload = function(e){
					// e.target : 이미지 객체
					// e.target.result : reader가 이미지를 다 읽은 결과
					let img_html = "<img src=\"" + e.target.result + "\" /><br>";
					
					$(".imgs_wrap").append(img_html);
				}
				// f: 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화
				reader.readAsDataURL(f);
			}); // end forEach
			if(isImage){
				imgCheck = true;
			}
		}// end handleImgFileSelect()
	});
	
	// 나의 중복체크
	function myDup(){
		let memId = $("[name='memId']").val();
		
		if(memId == ""){
			alert("아이디를 입력해주세요");
			return;
		}
		
		$.ajax({
			url: "/board/duplicate",
			method: "POST",
			data : {"memId" : memId},
			success:function(data){
				if(data == '1'){
					alert("아이디가 존재합니다");
				} else{	//중복 통과
					alert('사용 가능한 아이디 입니다.');
					$("#memId").attr("readonly", "readonly");
					$("#duplicate").attr("disabled","disabled");
					duplicateCheck = true;
				}
			}
		});
	}
	
	// 선생님 중복체크
	function samDup(){
		
		let memId = $("[name='memId']").val();
		
		if(memId==""){
			alert("아이디가 없습니다. 아이디를 입력해 주세요.");
			$("#memId").focus();
			return;
		}
		
		let data = {"memId" : memId};
		
		$.ajax({
			url: "/board/chkDup",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(data),
			type: "post",
			success:function(data){
				console.log("result : " + JSON.stringify(data));
				console.log("result.result : " + data.result);
				
				let dupRslt = data.result;
				let $btn = $("#btn");
				if(dupRslt > 0){
					alert("사용중인 아이디가 있습니다.");
					$("#memId").focus();
					$btn.attr("disabled","disabled");
				} else{
					alert("사용 가능한 아이디 입니다.");
					$("#memId").attr("readonly","readonly");
					$btn.attr("disabled",false);
					duplicateCheck = true;
				}
			}
		});
	}
	
	function validation(){
	
		let memHp = document.querySelector("#memHp").value;
		
		if(!duplicateCheck){
			alert("중복확인을 해주세요.");
			return false;
		}
		
	    if (!(/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(memHp))
	    		|| memHp.length < 12) {
	    	alert("유효하지않은 전화번호 입니다.");
			return false;
	    }
	    
	    if(!imgCheck){
	    	alert("이미지 확장자만 가능합니다.");
			return false;
	    }
	    
	}
</script>
</head>
<body>
<div class="card-body p-0">
    <!-- Nested Row within Card Body -->
    <div class="row">
        <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
        <div class="col-lg-7">
            <div class="p-5">
                <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Create an Member!</h1>
                </div>
                <form id="frm" class="user" action="/board/insert" method="post" enctype="multipart/form-data">
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user col-9" id="memId"
                            name="memId" placeholder="userId" required>
                        <input class="btn btn-primary col-2 offset-1" type="button" id="duplicate" value="중복확인" />
                    </div>
                    <div class="form-group row">
                        <input type="password" class="form-control form-control-user"
                            id="memPass" name="memPass" placeholder="password" required>
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memName" name="memName" placeholder="name" required>
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memJob" name="memJob" placeholder="job" required>
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memLike" name="memLike" placeholder="like" required>
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memHp" name="memHp" placeholder="Hp" required>
                    </div>
					<div class="mb-3">
					  <input class="form-control" type="file" id="memImage" name="memImage" multiple required>
					</div>
					<div class="input-group row imgs_wrap"></div>
                    <br>
                    <button id="btn" type="submit" class="btn btn-primary btn-user btn-block" disabled>
                        	등록
                    </button>
                    <a href="/board/list" class="btn btn-secondary btn-user btn-block">
                        	목록
                    </a>
                </form>
                <hr>
                <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>