<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" -->
<!--    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/validation.js"></script>
<title>상품 등록</title>
</head>
<body>
<!-- 첨부파일을 서버에 전송하는 방식
1) form 태그를 이용하여 업로드
	- 브라우저의 제한이 없어야 하는 경우(크롬, 파이어폭스, 엣지, 오페라, 웨일)
	- 페이지 이동과 동시에 첨부파일 업로드
	- iframe 태그를 이용하여 화면 이동 없이 첨부파일 처리
2) Ajax를 이용 
	- input type="file"을 이용하고 Ajax로 처리
	- HTML5의 Drag and Drop 기능이나 jQuery 라이브러리를 이용
-->
<!-- 첨부파일 API 
1) cos.jar : 2002년도에 개발 종료됨(사용 비추)
2) commons-fileupload : 가장 일반적으로 많이 사용함(사용 강추)
-->
<%-- 	<jsp:include page="./menu.jsp" /> --%>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<!-- http://localhost/addProduct.jsp -->
	<!-- -------------- 상품 등록 시작 ------p.203----------------- -->
	<!-- 내용 -->
	<div class="container">
		<div class="text-right">
			<a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
		</div>
		<form name="newProduct" action="<%=request.getContextPath()%>/product/processAddProduct" 
		class="form-horizontal" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" id="productId" name="productId" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" id="pname" name="pname" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-3">
					<input type="text" name="description" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제고수</label>
				<div class="col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New" />신규 제품
					<input type="radio" name="condition" value="Old" />중고 제품
					<input type="radio" name="condition" value="Refurbished" />재생 제품
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품 이미지</label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="등록"
					onclick="CheckAddProduct()" />
					<button type="button" class="btn btn-info"  
					onclick="javascript:location.href='/product/products'">목록보기</button>
				</div>
			</div>
			<sec:csrfInput/>
		</form>
	</div>
	<!-- -------------- 상품 등록 끝 ----------------------- -->
	
<%-- 	<jsp:include page="footer.jsp" /> --%>
	
</body>
</html>





