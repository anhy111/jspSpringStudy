<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>회원 가입</title>
<style type="text/css">
	.imgs_wrap{
		width:300px;
		margin-top:50px;
	}
	.imgs_wrap img{
		max-width:100%;
	}
</style>
<script type="text/javascript">
$(function(){
	//이미지 미리보기 시작///////////////////////////////
	let sel_file = [];
	//input type=file id=input_imgs... 바뀌는 이벤트
	$("#input_imgs").on("change",handleImgFileSelect);
	//파라미터e : onchange 이벤트 객체
	function handleImgFileSelect(e){
		//이벤트가 발생된 타겟 안에 들어있는 이미지 파일들을 가져와보자
		let files = e.target.files;
		//이미지가 여러개가 있을 수 있으므로 이미지들을 분리해서 배열로 만듦
		let fileArr = Array.prototype.slice.call(files);
		//파일 타입의 배열 반복. f : 배열 안에 들어있는 각각의 이미지 파일 객체
		fileArr.forEach(function(f){
			//이미지 파일이 아닌 경우 이미지 미리보기 실패처리
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.");
				//함수 종료
				return;
			}
			//이미지 객체를 전역 배열타입 변수에 넣자
			sel_file.push(f);
			//이미지 객체를 읽을 자바스크립트의 reader 객체 생성
			let reader = new FileReader();
			//e : reader가 이미지 객체를 읽는 이벤트
			reader.onload = function(e){
				//e.target : 이미지 객체
				//e.target.result : reader가 이미지를 다 읽은 결과
				let img_html = "<img src=\"" + e.target.result + "\" />";
				//div 사이에 이미지가 렌더링되어 화면에 보임
				//객체.append : 누적, .html : 새로고침, innerHTML : J/S
				$(".imgs_wrap").html(img_html);
			}
			//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화함
			reader.readAsDataURL(f);
		});//end forEach
		
	}
	//이미지 미리보기 끝/////////////////////////////////
	
	//id가 btnDupChk인 버튼을 클릭하면 이벤트를 처리해보자
	$("#btnDupChk").on("click",function(){
		//ajax 비동기통신을 통해 id가 userId인 요소의 값이
		//데이터베이스에 있는 mem 테이블에 있는지를 체킹
		//contentType : 보내는 데이터 형식
		//dataType : 응답 데이터 형식
		let userId = $("#userId").val();
		//json데이터
		let data = {"userId":userId};
		
		$.ajax({
			url:"/mem/dupChk",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			success:function(result){
				console.log("result : " + JSON.stringify(result));
				//json 응답 데이터 처리
				//.each : jQuery의 반복문
				//첫번째 인자로 index를 주고, 두번째 인자로 item(콜백함수)를 줌
				//index를 기준으로 반복을 함
				$.each(result,function(index,item){
					//item : {"result", "1"}
					let rslt = item;
					console.log("rslt : " + rslt);
					if(rslt=="1"){
						alert("해당 아이디가 이미 있습니다.");
						$("#userId").val("");						
					}
				});
			}
		});			
	});
	//중복 시 alert("이미 id가 등록되어 있습니다.")
	
	//비밀번호 확인 체크
	//아이디가 userPwConfirm인 요소의 focus가 out이 되었을 때 
	//아이디가 userPw인 요소의 값과 비교하여 
	//다르면 alert("비밀번호확인을 다시 해주세요. 비밀번호가 다릅니다.")
	$("#userPwConfirm").on("focusout",function(){
		let userPwConfirm = $("#userPwConfirm").val().trim();
		let userPw = $("#userPw").val().trim();
		//비밀번호확인이 다르다면
		if(userPwConfirm!=userPw){
			alert("비밀번호확인을 다시 해주세요. 비밀번호가 다릅니다.");
		}
	});
	
	let cnt = 1;
	//javascript에서 jSTL값을 받기***
	let userNoStr = "<c:out value='${userNo}' />";
	console.log("userNoStr : " + userNoStr);
	
	/* javascript sessionStorage : 자바스크립트의 세션*/
	sessionStorage.setItem("no",userNoStr);
	
	let noStr = sessionStorage.getItem("no");
	console.log("noStr : " + noStr);
		
	//+버튼 클릭 시 다음을 추가해줌. memAuthVOList[1].auth -> memAuthVOList[2].auth
	$("button[name='add']").on("click",function(){
		let str = "<input type='hidden' name='memAuthVOList["+cnt+"].userNo' value='${userNo}' />";
			str += "<select name='memAuthVOList["+cnt+"].auth' class='form-control'>";
			str +="<option value='manager'>관리자</option>";
			str +="<option value='employee'>직원</option>";
			str +="<option value='employer'>고용주</option>";
			str +="</select>";
			
		$("#divAuth").append(str);
		cnt++;
	});
	
	$("button[name='del']").on("click",function(){
		console.log(cnt);
		//memAuthVOList[0].auth는 남겨놓아야 하므로
		if(cnt>1){
			$("#divAuth").children().last().remove();
			$("#divAuth").children().last().remove();
			cnt--;
		}
	});
	//id가 divAuth인 요소의 last 자식 요소로 넣어줌
	//-버튼 클릭 시 id가 divAuth인 요소의 last 자식 요소를 제거함(counter를 챙기기)
	//카운터가 0인 요소는 -를 계속 클릭하더라도 사라지지 않도록 처리.
	/*
	<select path="memAuthVOList[1].auth" class="form-control">
		<option value="manager">관리자</option>
		<option value="employee">직원</option>
		<option value="employer">고용주</option>
	</select>
	*/
});
</script>

</head>
<body>
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>
	
	<!-- ///////////// 회원 가입 시작 ///////////////////// -->
	<div class="container">
		<form:form modelAttribute="memVO" action="/mem/memRegistPost" class="form-horizontal"
				method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="imgs_wrap">
				
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">회원사진</label>
				<div class="col-sm-5">
					<input type="file" name="memImage" id="input_imgs" class="form-control" multiple />
				</div>
			</div>			
			<div class="form-group row">
				<label class="col-sm-2">회원번호</label>
				<div class="col-sm-3">
					<!-- 텍스트박스. 올해연도+세자리일련번호 -->
					<form:input path="userNo" class="form-control"
					placeholder="회원번호" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">회원ID</label>
				<div class="col-sm-3">
					<!-- 텍스트박스 + 버튼 -->
					<form:input path="userId" class="form-control"
					placeholder="회원ID" />
					<button type="button" id="btnDupChk" class="btn btn-primary">중복확인</button>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<!-- 텍스트박스(password) -->
					<form:password path="userPw" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<!-- 텍스트박스(password) -->
					<input type="password" name="userPwConfirm" id="userPwConfirm"
						class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">회원명</label>
				<div class="col-sm-3">
					<!-- 텍스트박스 -->
					<form:input path="userName" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">권한</label>
				<div class="col-sm-3" id="divAuth">
					<!-- 선택박스, +버튼, -버튼 -->
					<!-- 관리자(manager), 직원(employee), 고용주(employer) -->
					<button type="button" name="add" class="btn btn-primary">+</button>
					<button type="button" name="del" class="btn btn-primary">-</button>
					<input type="hidden" name="memAuthVOList[0].userNo" value="${userNo}" />
					<form:select path="memAuthVOList[0].auth" class="form-control">
						<form:option value="manager">관리자</form:option>
						<form:option value="employee">직원</form:option>
						<form:option value="employer">고용주</form:option>
					</form:select>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10" style="text-align:center;float:right;">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-danger">취소</button>
				</div>
			</div>
		</form:form>
	</div>
	<!-- ///////////// 회원 가입 끝 ///////////////////// -->
</body>
</html>















