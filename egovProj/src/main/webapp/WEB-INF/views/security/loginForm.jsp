<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>AdminLTE 3 | Log in (v2)</title>
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="/resources/adminlte/plugins/fontawesome-free/css/all.min.css">
<!-- icheck bootstrap -->
<link rel="stylesheet"
	href="/resources/adminlte/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="/resources/adminlte/dist/css/adminlte.min.css">
</head>
<body class="login-page" style="min-height: 466px;">
	<div class="text-center" style="justify-content: center; display: flex;">
		<div class="login-box">

			<div class="card card-outline card-primary">
				<div class="card-header text-center">
					<a href="../../index2.html" class="h1"><b>Admin</b>LTE</a>
				</div>
				<div class="card-body">
					<p class="login-box-msg">Sign in to start your session</p>
					<form action="/login" method="post">
						<div class="input-group mb-3">
							<input type="text" name="username"
								 class="form-control" placeholder="아이디를 입력해주세요">
							<div class="input-group-append">
								<div class="input-group-text">
									<span class="fas fa-envelope"></span>
								</div>
							</div>
						</div>
						<div class="input-group mb-3">
							<input type="password" name="password"
							 	class="form-control" placeholder="비밀번호를 입력해주세요">
							<div class="input-group-append">
								<div class="input-group-text">
									<span class="fas fa-lock"></span>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-8">
								<div class="icheck-primary">
									<input type="checkbox" name="remember-me"
										id="remember"> 
									<label for="remember"> Remember Me </label>
								</div>
							</div>

							<div class="col-4">
								<button type="submit" class="btn btn-primary btn-block">Sign
									In</button>
							</div>

						</div>
						<sec:csrfInput/>
					</form>
				</div>

			</div>

		</div>
	</div>

	<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
	<script
		src="/resources/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/adminlte/dist/js/adminlte.min.js?v=3.2.0"></script>
</body>
</html>
