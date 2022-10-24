<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 수정</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/validation.js"></script>
<script type="text/javascript">
	$(function() {
		let condition = "${data.condition}";
		$("input[type=radio]").val(function(p_inx,p_val) {
			if(p_val == condition){
				this.checked = true;
			}
		});
	});
</script>
</head>
<body>
<!-- 머리글에 해당하는 menu.jsp파일의 내용을 포함하도록 include 액션태그 작성 -->
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 추가</h1>
		</div>
	</div>
<!-- ========================= 상품 등록 시작 =================================== -->
	<div class="container">
		<form name="newProduct" action="/update" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" id="productId" value="${data.productId}" name="productId" class="form-control" readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" id="pname" value="${data.pname}" name="pname" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품가격</label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" value="${data.unitPrice}" name="unitPrice" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품설명</label>
				<div class="col-sm-3">
					<textarea id="description" name="description" rows="2" cols="50" class="form-control">${data.description}</textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" id="manufacturer" value="${data.manufacturer}" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" id="category" value="${data.category}" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고수</label>
				<div class="col-sm-3">
					<input type="text" id="unitInStock" value="${data.unitInStock}" name="unitInStock" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<input type="radio" id="condition1" name="condition" value="New"/>신규상품
					<input type="radio" id="condition2" name="condition" value="Old"/>중고상품
					<input type="radio" id="condition3" name="condition" value="Refurbished"/>재생상품				
				</div>
			</div>
			<!-- ch07에서 추가됨 -->
<!-- 			<div class="form-group row"> -->
<%-- 				<label class="col-sm-2"><spring:message code="productImage"/></label> --%>
<!-- 				<div class="col-sm-5"> -->
<!-- 					<input type="file" id="productImage" name="productImage" class="form-control"> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="수정" onclick="checkAddProduct()"/>
					<a href="/products" class="btn btn-warn">상품목록</a>
				</div>
			</div>
		</form>
	</div>
	<!-- ========================= 상품 등록 끝 ================================= -->
	<jsp:include page="footer.jsp"/>
</body>
</html>