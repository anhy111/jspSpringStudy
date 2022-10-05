<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@page import="ch04.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="ch04.dao.ProductRepository"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" 
	href="/resources/css/bootstrap.min.css">
<title>도서 등록</title>
</head>
<body>
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">도서 등록</h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
 <div class="container">
	<form name="newProduct" action="processAddBook.jsp"
		class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
			<label class="col-sm-2">도서코드</label>
			<div class="col-sm-3">
				<input type="text" name="bookId" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2">도서명</label>
			<div class="col-sm-3">
				<input type="text" name="name" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2">가격</label>
			<div class="col-sm-3">
				<input type="text" name="unitPrice" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2">저자</label>
			<div class="col-sm-3">
				<input type="text" name="author" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2">출판사</label>
			<div class="col-sm-3">
				<input type="text" name="publisher" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">출판일</label>
			<div class="col-sm-3">
				<input type="text" name="releaseDate" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">총페이지 수</label>
			<div class="col-sm-3">
				<input type="text" name="totalPages" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상세정보</label>
			<div class="col-sm-5">
				<textarea rows="2" cols="50" name="description"
				class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">분류</label>
			<div class="col-sm-3">
				<input type="text" name="category" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">재고수</label>
			<div class="col-sm-3">
				<input type="text" name="unitsInStock" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상태</label>
			<div class="col-sm-3">
				<input type="text" name="condition" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				파일 : <input type="file" name="filename">
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-primary" value="등록" />
			</div>
		</div>
		<hr>
	</form>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->
<jsp:include page="footer.jsp"/>
</body>
</html>