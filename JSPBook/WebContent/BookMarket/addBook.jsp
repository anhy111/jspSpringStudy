<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="ch04.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="ch04.dao.ProductRepository"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" 
	href="/resources/css/bootstrap.min.css">
<title>도서 등록</title>
<script type="text/javascript" src="/resources/js/bookValidation.js"></script>
</head>
<body>
<fmt:setLocale value="${param.language}"/>
<fmt:bundle basename="bookBundle.message">
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3"><fmt:message key="title"></fmt:message></h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
 <div class="container">
 	<div class="text-right">
		<a href="?language=ko">Korea</a>|<a href="?language=en">English</a>
		<a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
	</div>
	<form name="bookForm" action="processAddBook.jsp"
		class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="bookId"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="bookId" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="name"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="name" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="unitPrice"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="unitPrice" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="author"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="author" class="form-control">
			</div>
		</div>	
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="publisher"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="publisher" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="releaseDate"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="releaseDate" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="totalPages"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="totalPages" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="description"></fmt:message></label>
			<div class="col-sm-5">
				<textarea rows="2" cols="50" name="description"
				class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="category"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="category" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="unitsInStock"></fmt:message></label>
			<div class="col-sm-3">
				<input type="text" name="unitsInStock" class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2"><fmt:message key="bookId"></fmt:message></label>
			<div class="col-sm-5">
				<input type="radio" id="condition1" name="condition" value="New"><fmt:message key="condition_New"></fmt:message>
				<input type="radio" id="condition2" name="condition" value="Old"><fmt:message key="condition_Old"></fmt:message>
				<input type="radio" id="condition3" name="condition" value="Refurbished"><fmt:message key="condition_Refubished"></fmt:message>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<fmt:message key="bookImage"></fmt:message> : <input type="file" name="filename">
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="button" class="btn btn-primary" value="<fmt:message key="button"></fmt:message>"
					onclick="f_check()" />
			</div>
		</div>
		<hr>
	</form>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->

<jsp:include page="footer.jsp"/>
</fmt:bundle>
</body>
</html>