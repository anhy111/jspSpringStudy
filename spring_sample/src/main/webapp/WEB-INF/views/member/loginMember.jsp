<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
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
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<!-- --------------------로그인페이지 시작-------------------- -->
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<!-- 로그인을 실패했다면.. -->
			<c:if test="${error==1}">
				<div class="alert alert-danger">
					아이디와 비밀번호를 확인해 주세요
				</div>
			</c:if>
<!-- 			<form class="form-signin" action="/member/processLoginMember" -->
<!-- 				method="post"> -->
			<!-- /member/register?id=a001&password=java -->
			<form name="frm" class="form-signin" action="/login" 
				method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label>
					<input type="text" class="form-control" placeholder="ID"
						name="username" required autofocus />
				</div>	
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label>
					<input type="password" class="form-control" placeholder="Password"
						name="password" required />
				</div>
				<!-- 자동 로그인 
				- 로그인하면 특정 시간 동안 다시 로그인 할 필요가 없는 기능(초 단위로 설정)
				- 스프링 시큐리티는 메모리나 Database(data-source-ref="dataSource")를 사용하여 처리
				- security:remember-me 태그를 이용하여 security-context.xml 설정 파일을 수정함
				-->
				<div class="form-group">
                    <div class="custom-control custom-checkbox small">
                        <input type="checkbox" 
                        	name="remember-me" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">Remember
                            Me</label>
                    </div>
                </div>
				<!-- button type => submit / button / reset -->
				<button type="submit" class="btn btn btn-lg btn-success btn-block">
					로그인
				</button>
				
				<sec:csrfInput />
			</form>
			
		</div>
	</div>
	<!-- --------------------로그인페이지 끝-------------------- -->
	
</body>
</html>











