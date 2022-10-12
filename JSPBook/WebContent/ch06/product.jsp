<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="ch04.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="ch04.dao.ProductRepository"%>
<%@page errorPage="exceptionNoProductId.jsp"%>
<!DOCTYPE html>
<%	
	String id = request.getParameter("id").toString();
	ProductRepository productRepository = ProductRepository.getInstance();
	ProductVO productVO = productRepository.getProductById(id);
%>
<c:set var="productVO" value="<%=productVO%>" scope="page" />
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 상세</title>
</head>
<body>
<fmt:setLocale value="${param.language}"/>
<fmt:bundle basename="bundle.message">
<jsp:include page="../ch06/menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3"><fmt:message key="productDetail"></fmt:message></h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
<div class="container">
	<div class="text-right">
		<a href="?language=ko&id=${productVO.productId }">Korea</a>|<a href="?language=en&id=${productVO.productId }">English</a>
	</div>
	<div class="row" align="center">
		<div class="col-md-6">
			<h3>${productVO.pname }</h3>
			<p>
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhIDxF9Dyj9c6K7DVThI-y8wC0JmyDy8GZMQ&usqp=CAU">
			</p>
			<p>${productVO.description }</p>
			<p>
				<b><fmt:message key="productId"></fmt:message> : </b>
				<span class="badge badge-danger">${productVO.productId}</span>
			</p>
			<p>
				<b><fmt:message key="manufacturer"></fmt:message> :</b> ${productVO.manufacturer }
			</p>
			<p>
				<b><fmt:message key="category"></fmt:message> :</b> ${productVO.category}
			</p>
			<p>
				<b><fmt:message key="unitsInStock"></fmt:message> :</b> ${productVO.unitsInStock}
			</p>
			<h4>${productVO.unitsInStock} <fmt:message key="krw"></fmt:message></h4>
			<p>
				<a href="#" class="btn btn-info"><fmt:message key="productOrder"></fmt:message>&raquo;</a>
				<a href="../ch06/products.jsp" class="btn btn-secondary"><fmt:message key="productList"></fmt:message>&raquo;</a>
			</p>
		</div>
	</div>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->
<jsp:include page="../ch06/footer.jsp"/>
</fmt:bundle>
</body>
</html>