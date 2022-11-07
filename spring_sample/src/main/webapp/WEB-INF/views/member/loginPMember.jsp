<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<!-- 제이쿼리 ui css -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <!-- 제이쿼리 style css -->
 <link rel="stylesheet" href="/resources/demos/style.css">
 <!-- 제이쿼리 js -->
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <!-- 제이쿼리 ui js -->
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>로그인</title>
<script type="text/javascript">
function fn_login2(){
	document.frm.action = "/member/registerIntCast";
	document.frm.submit();
}

function fn_ParamCorrect(){
	document.frm.action = "/member/registerParamCorrect";
	document.frm.submit();
}
</script>
</head>
<body>
	<!-- include 액션 태그 -->
	<jsp:include page="../shopping/menu.jsp" />
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<!-- --------------------로그인페이지 시작-------------------- -->
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<!-- 로그인을 실패했다면.. -->
			<c:if test="${error==1}">
				<div class="alert alert-danger">
					아이디와 비밀번호를 확인해 주세요
				</div>
			</c:if>
<!-- 			<form class="form-signin" action="/member/processLoginMember" -->
<!-- 				method="post"> -->
			<!-- /member/register?id=a001&password=java -->
			<form name="frm" class="form-signin" action="/member/register01" 
				method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label>
					<input type="text" class="form-control" placeholder="ID"
						name="id" required autofocus />
				</div>	
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label>
					<input type="password" class="form-control" placeholder="Password"
						name="password" required />
				</div>
				<div class="form-group">
					<label for="inputName" class="sr-only">name</label>
					<input type="text" class="form-control" placeholder="name"
						name="name" />
				</div>
				<div class="form-group">
					<label for="inputCoin" class="sr-only">coin</label>
					<input type="text" class="form-control" placeholder="coin"
						name="coin" />
				</div>
				<div class="form-group">
					<label for="inputBirth" class="sr-only">birth</label>
					<input type="date" class="form-control" placeholder="birth"
						name="birth" />
				</div>
				<!-- button type => submit / button / reset -->
				<button type="submit" class="btn btn btn-lg btn-success btn-block">
					로그인
				</button>
			</form>
			<a href="/member/registerByGet01?id=a001&birth=0805">
				/member/registerByGet01?id=a001&amp;birth=0805
			</a><br />
			<a href="/member/registerByGet01?id=a001&birth=2022-08-05">
				/member/registerByGet01?id=a001&amp;birth=2022-08-05
			</a><br />
			<a href="/member/registerByGet01?id=a001&birth=20220805">
				/member/registerByGet01?id=a001&amp;birth=20220805
			</a><br />
			<a href="/member/registerByGet01?id=a001&birth=2022/08/05">
				/member/registerByGet01?id=a001&amp;birth=2022/08/05
			</a><br />
		</div>
	</div>
	<!-- --------------------로그인페이지 끝-------------------- -->
	
	<jsp:include page="../shopping/footer.jsp" />
</body>
</html>











