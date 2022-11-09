<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

</head>
<body>
	<jsp:include page="../product/menu.jsp" />
	
	<!-- --------------------상품상세 시작-------------------- -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	<div class="container">
	<!-- 
		action속성의 값은 항상 /login으로 정해짐
		name 속성의 값은 username, password로 정해짐
	 -->
		<form action="/login" method="post">
			<div class="row">
				<div class="bd-example">
					<c:if test="${error != null}">
						<div class="mb-3">
						  <input type="text" class="form-control is-invalid" 
						  	placeholder="${error}" value="${error}" readonly="true" />
						</div>
					</c:if>
					<c:if test="${logout != null}">
						<div class="mb-3">
						  <input type="text" class="form-control is-invalid" 
						  	placeholder="${logout}" value="${logout}" readonly="true" />
						</div>
					</c:if>
					<div class="mb-3">
					  <label for="exampleFormControlInput1" class="form-label">아이디</label>
					  <input type="text" name="username" class="form-control" id="username" placeholder="아이디" />
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlInput1" class="form-label">비밀번호</label>
					  <input type="password" name="password" class="form-control" id="password" placeholder="비밀번호" />
					</div>
					<div class="mb-3">
						<input type="submit" value="로그인" />
					</div>
				</div>
			</div>
			<!-- CSRF 토큰처리 -->
			<sec:csrfInput/>
		</form>
	</div>
	<!-- --------------------상품상세 끝-------------------- -->
	
	<jsp:include page="../product/footer.jsp" />
</body>
</html>