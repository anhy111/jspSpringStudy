<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<title>회원 가입</title>
<script type="text/javascript">
	function checkForm(){
		//아이디 입력 체크
// 		if(!document.newMember.id.value){
// 			alert("아이디를 입력하세요");
// 			document.newMember.id.focus();
// 			return false;
// 		}
			
		//비밀번호 입력 체크
// 		if(!document.newMember.password.value){
// 			alert("비밀번호를 입력하세요");
// 			document.newMember.password.focus();
// 			return false;
// 		}
		
		//비밀번호 확인
// 		if(document.newMember.password.value !=
// 			document.newMember.password_confirm.value){
// 			alert("비밀번호를 동일하게 입력하세요");
// 			return false;
// 		}
		
		//생일을 조립해보자
		//birthyy + birthmm + birthdd
		let mm = document.newMember.birthmm.value;
		if(mm<10){
			mm = "0" + mm;
		}
		
		let dd = document.newMember.birthdd.value;
		if(dd<10){
			dd = "0" + dd;
		}
		
		let birth = document.newMember.birthyy.value + "-" +
					mm + "-" + dd
		console.log("birth : " + birth);
		
		//이메일도 조립해보자
		let mail = document.newMember.mail1.value + "@" + 
				   document.newMember.mail2.value;
		console.log("mail : " + mail);
		
		//birth와 mail이 form태그의 요소로 들어가 있어야 함
		document.newMember.birth.value = birth;
		document.newMember.mail.value  = mail;
		
		document.newMember.submit();
// 		return true;
	}
	
	//다음 우편번호 검색
	function openHomeSearch(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				$("[name=postNum]").val(data.zonecode);
				$("[name=addr1]").val(data.address);
				$("[name=addr2]").val(data.buildingName);
				$("[name=address]").val(data.zonecode + " " + data.address + " " + data.buildingName);
			}
		}).open();
	}
</script>
</head>
<body>
	<!-- include 액션 태그 -->
<%-- 	<jsp:include page="../shopping/menu.jsp" /> --%>
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>
	
	<!-- --------------------회원 가입 시작-------------------- -->
	<!-- form태그의 onsubmit속성 : 핸들러함수를 일단 먼저 거치고 오셈
		1) 핸들러함수에서 return true; 시에는 submit을 수행
		2) 핸들러함수에서 return false; 시에는 중지 
	-->
	<div class="container">
		<!--  onsubmit="return checkForm()" -->
		<form:form modelAttribute="pmemberVO" name="newMember" class="form-horizontal" 
		action="/member/processAddMember" method="post">
			<div class="form-group row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<form:input path="id" class="form-control" placeholder="id" />
					<font color="red">
						<form:errors path="id" />
					</font>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<form:password path="password" class="form-control" placeholder="password" />
					<font color="red">
						<form:errors path="password" />
					</font>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input type="password" name="password_confirm" class="form-control" 
					placeholder="password confirm" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<form:input path="name" class="form-control" 
					placeholder="name" />
					<font color="red">
						<form:errors path="name" />
					</font>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-3">
					<form:radiobutton path="gender" value="남" label="남" />
					<form:radiobutton path="gender" value="여" label="여" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4">
					<form:hidden path="birth" value="" />
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" />
					<select name="birthmm">
						<option value="">월</option>
						<c:forEach var="mm" begin="1" end="12" step="1">
							<option value="${mm}">${mm}</option>
						</c:forEach>					
					</select>
					<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<form:hidden path="mail" value="" />
					<input type="text" name="mail1" maxlength="50" />@
					<select name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
					<font color="red">
						<form:errors path="mail" />
					</font>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<form:input path="phone" class="form-control" 
					placeholder="phone" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="postNum" class="form-control"
					placeholder="우편번호" readonly /> 
					<a href="javascript:openHomeSearch()" class="btn btn-primary btn-icon-split btn-sm">
                         <span class="icon text-white-50">
                             <i class="fas fa-flag"></i>
                         </span>
                         <span class="text">검색</span>
                     </a>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-3">
					<input type="text" name="addr1"  class="form-control"
					placeholder="주소" /> 
					<input type="text" name="addr2"  class="form-control"
					placeholder="상세주소" /> 
					
					<form:input path="address" class="form-control" 
					placeholder="address" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="등록" onclick="checkForm()" />
					<input type="reset" class="btn btn-primary" value="취소"  />
				</div>
			</div>
			<!--
			아작났어..유.피씨다타써.에..
			로보트에 
			스시 랑 피쉬
			 -->
			<sec:csrfInput/>
		</form:form>
	</div>
	<!-- --------------------회원 가입 끝-------------------- -->
	
<%-- 	<jsp:include page="../shopping/footer.jsp" /> --%>
</body>
</html>















