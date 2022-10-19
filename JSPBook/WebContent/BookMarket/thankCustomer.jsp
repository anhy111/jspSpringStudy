<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>주문 완료</title>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<%
		String Shipping_cartId = "";
		String Shipping_name = "";
	    String Shipping_shippingDate = "";
	    String Shipping_country = "";
	    String Shipping_zipCode = "";
	    String Shipping_addressName = "";
	    
	    Cookie[] cookies = request.getCookies();
	    
	    if(cookies != null){
	    	for(int i=0; i<cookies.length; i++){
	    		Cookie thisCookie = cookies[i];
	    		String n = thisCookie.getName();
	    		if(n.equals("Shipping_cartId"))
	    			Shipping_cartId = URLDecoder.decode((thisCookie.getValue()),
	    					"utf-8");
	    		if(n.equals("Shipping_shippingDate"))
	    			Shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()),
	    					"utf-8");
	    	}
	    }
	%>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p> 주문은 <% out.println(Shipping_shippingDate); %>에 배송될 예정입니다!</p>
		<p> 주문번호 : <% out.println(Shipping_cartId); %>
	</div>
	<div class="container">
		<p><a href="books.jsp" class="btn btn-secondary">&laquo; 도서 목록</a></p>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
<%
	session.invalidate();

	for(int i=0; i<cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if(n.equals("Customer_id"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_phoneNumber"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_country"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_addressName"))
			thisCookie.setMaxAge(0);
		
		if(n.equals("Shipping_cartId"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_shippingDate"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_addressName"))
			thisCookie.setMaxAge(0);
		
		response.addCookie(thisCookie);
	}
%>