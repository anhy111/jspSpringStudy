<%@page import="bookmarket.dto.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");

	String cartId = session.getId();
	
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
			if(n.equals("Shipping_name"))
				Shipping_name = URLDecoder.decode((thisCookie.getValue()),
				"utf-8");
			if(n.equals("Shipping_shippingDate"))
				Shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()),
				"utf-8");
			if(n.equals("Shipping_country"))
				Shipping_country = URLDecoder.decode((thisCookie.getValue()),
				"utf-8");
			if(n.equals("Shipping_zipCode"))
				Shipping_zipCode = URLDecoder.decode((thisCookie.getValue()),
				"utf-8");
			if(n.equals("Shipping_addressName"))
				Shipping_addressName = URLDecoder.decode((thisCookie.getValue()),
				"utf-8");
			
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문정보</h1>
		</div>
	</div>
	
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong><br>
				 성명 : <% out.println(Shipping_name);%><br>
				 우편번호 : <% out.println(Shipping_zipCode);%><br>
				 주소 : <% out.println(Shipping_addressName);%>
				 	(<%out.println(Shipping_country);%>)<br>
			</div>
			<div class="col-4" align="right">
				<p> <em>배송일: <%out.println(Shipping_shippingDate); %></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">도서</th>
					<th class="text-center">#</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				<%
					int sum = 0;
					ArrayList<Book> cartList = (ArrayList<Book>)session
							.getAttribute("cartlist");
					if(cartList == null && cartList.size() == 0){
				%>
					<tr>	
						<td colspan="5" align="center">장바구니에 상품이 없습니다.</td>
					</tr>
				<%
					} else{
						for(Book book : cartList){
							int total = book.getUnitPrice() * book.getQuantity();
							sum = sum + total;
				%>
					<tr>
						<td class="text-center"><em><%=book.getName()%></em></td>
						<td class="text-center"><%=book.getQuantity()%></td>
						<td class="text-center"><%=book.getUnitPrice() %></td>
						<td class="text-center"><%=total%></td>
					</tr>
				<%
						}
					}
				%>
				<tr>
					<td> </td>
					<td> </td>
					<td class="text-right"><strong>총액:</strong></td>
					<td class="text-center text-danger"><strong><%=sum%></strong></td>
				</tr>
			</table>
			<a href="ShippingInfo.jsp?cartId=<%=Shipping_cartId%>"
				class="btn btn-secondary" role="button">이전</a>
			<a href="thankCustomer.jsp" class="btn btn-success"
				role="button">주문 완료</a>
			<a href="checkOutCancelled.jsp" class="btn btn-secondary"
				role="button">취소</a>
		</div>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>