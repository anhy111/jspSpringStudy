<%@page import="kr.or.ddit.vo.ShippingVO"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<title>주문 완료</title>
</head>
<body>
	<%//스크립틀릿
		ShippingVO shippingVO = (ShippingVO)session.getAttribute("Shipping");
	
		String Shipping_name = shippingVO.getName();
		String Shipping_zipCode = shippingVO.getZipCode();
		String Shipping_country = shippingVO.getCountry();
		String Shipping_addressName = shippingVO.getAddressName();
		String Shipping_shippingDate = shippingVO.getShippingDate();
		String Shipping_cartId = session.getId();
	%>
	<!-- include 액션 태그 -->
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	
	<!-- ---------- 주문 완료 내용 시작 ----------------------- -->
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p>주문은 <%=Shipping_shippingDate%>에 배송될 예정입니다.</p>
		<p>주문번호 : <%=Shipping_cartId%></p>
	</div>
	<div class="container">
		<p><a href="/products" class="btn btn-secondary">&laquo;상품 목록</a></p>
	</div>
	<!-- ---------- 주문 완료 내용 끝 ----------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>
<%//스크립틀릿
	session.invalidate();
%>










