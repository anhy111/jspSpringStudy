<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 등록</title>
<script type="text/javascript" src="/resources/js/validation.js"></script>
</head>
<body>
<!-- 머리글에 해당하는 menu.jsp파일의 내용을 포함하도록 include 액션태그 작성 -->
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><spring:message code="title"/></h1>
		</div>
	</div>
<!-- ========================= 상품 등록 시작 =================================== -->
	<div class="container">
		<div class="text-right">
			<a href="?language=ko">Korea</a> | <a href="?language=en">English</a>
		</div> 
		<form name="newProduct" action="/addProduct" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="productId"/></label>
				<div class="col-sm-3">
					<input type="text" id="productId" name="productId" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="pname"/></label>
				<div class="col-sm-3">
					<input type="text" id="pname" name="pname" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="unitPrice"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="description"/></label>
				<div class="col-sm-3">
					<textarea id="description" name="description" rows="2" cols="50" class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="manufacturer"/></label>
				<div class="col-sm-3">
					<input type="text" id="manufacturer" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="category"/></label>
				<div class="col-sm-3">
					<input type="text" id="category" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="unitInStock"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitInStock" name="unitInStock" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="condition"/></label>
				<div class="col-sm-5">
					<input type="radio" id="condition1" name="condition" value="New"/><spring:message code="condition_New"/>
					<input type="radio" id="condition2" name="condition" value="Old"/><spring:message code="condition_Old"/>
					<input type="radio" id="condition3" name="condition" value="Refurbished"/><spring:message code="condition_Refurbished"/>					
				</div>
			</div>
			<!-- ch07에서 추가됨 -->
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="productImage"/></label>
				<div class="col-sm-5">
					<input type="file" id="productImage" name="productImage" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="<spring:message code='button'/>" onclick="checkAddProduct()"/>
					<a href="products" class="btn btn-warn"><spring:message code="productList"/></a>
				</div>
			</div>
		</form>
	</div>
	<!-- ========================= 상품 등록 끝 ================================= -->
	<jsp:include page="footer.jsp"/>
</body>
</html>