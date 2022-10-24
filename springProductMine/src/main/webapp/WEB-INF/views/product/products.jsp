<<<<<<< .mine
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
||||||| .r8
<%@ page contentType="text/html; charset=UTF-8"%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
>>>>>>> .r16
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< .mine
||||||| .r8
<%@ page import="java.util.List"%>
=======
<!-- 액션 태그 -->
<!-- scope 4총사 :    page,       request, session, application -->
<!-- scope객체 4총사 : pageContext, request, session, application -->
<%-- <jsp:useBean id="productDAO" class="kr.or.ddit.dao.ProductRepository" scope="session" /> --%>
>>>>>>> .r16
<!DOCTYPE html>
<html>
<head>
<<<<<<< .mine
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
||||||| .r8
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
=======
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
>>>>>>> .r16
<title>상품 목록</title>
</head>
<body>
<<<<<<< .mine
	<jsp:include page="menu.jsp" />
	<!-- --------------------상품목록 시작-------------------- -->
||||||| .r8
<!-- 머리글에 해당하는 menu.jsp파일의 내용을 포함하도록 include 액션태그 작성 -->
	<jsp:include page="menu.jsp"/>
=======
	<!-- include 액션 태그 -->
	<jsp:include page="menu.jsp" />
	
	<!-- --------------------상품목록 시작-------------------- -->
>>>>>>> .r16
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
<<<<<<< .mine
||||||| .r8
<!-- ========================= 상품목록 시작 =================================== -->
=======
	<!-- container : 이 안에 내용있다 -->
>>>>>>> .r16
	<div class="container">
<<<<<<< .mine
		<div class="row" >
			<form class="text-center">
				<input type="text" placeholder="검색어를 입력하세요" name="keyword"
					value="${param.keyword}" />
				<input type="submit" class="btn btn-info" value="검색" />
			</form>
		</div>
||||||| .r8
		<div class="row" style="justify-content: right;margin:0 0 30px 0;"> 
			<a href="/addProduct" class="btn btn-primary">상품추가</a>
		</div>
=======
		<!-- 행별 처리 -->
>>>>>>> .r16
		<div class="row" align="center">
<<<<<<< .mine
			<c:forEach var="product" items="${data}">
			<div class="col-md-4">
				<img src="/resources/images/${product.filename}"
				style="width:100%;" alt="${product.pname}" title="${product.pname}" />
				<h3>${product.pname}</h3>
				<p>${product.description}</p>
				<p>${product.unitPrice}원</p>	
				<p><a href="/detail?productId=${product.productId}"
					class="btn btn-secondary" role="button">
					상세정보&raquo;></a></p>			
			</div>
			</c:forEach>
||||||| .r8
			<!-- List<ProductVO> 한 행을 꺼내오면 ProductVO -->
				<div class="col-md-4">
					<h3></h3>
					<p></p>
					<p></p>
					<!-- 상품 아이디에 대한 상세 정보 페이지가 연결되도록 상세 정보 버튼 작성 -->
					<p><a href="" class="btn btn-secondary" role="button">상세 정보&raquo;</a></p>
				</div>
=======
			<c:forEach var="product" items="${data}">
			<!-- 열별 처리 -->
			<div class="col-md-4">
				<!-- /images/P1234.jpg -->
				<img src="/resources/images/${product.filename}"
				style="width:100%;" alt="${product.pname}" title="${product.pname}" />
				<h3>${product.pname}</h3>
				<p>${product.description}</p>
				<p>${product.unitPrice}원</p>	
				<p><a href="product.jsp?id=${product.productId}"
					class="btn btn-secondary" role="button">
					상세정보&raquo;></a></p>			
			</div>
			</c:forEach>
>>>>>>> .r16
		</div>
<<<<<<< .mine
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="button" class="btn btn-primary" value="상품등록"
				onclick="javascript:location.href='/addProduct'" />
			</div>
		</div>
||||||| .r8
=======
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="button" class="btn btn-primary" value="상품등록"
				onclick="javascript:location.href='addProduct.jsp'" />
			</div>
		</div>
>>>>>>> .r16
	</div>
	<!-- --------------------상품목록 끝-------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>










