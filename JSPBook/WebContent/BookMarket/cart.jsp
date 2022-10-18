<%@page import="bookmarket.dto.Book"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<%
		String cartId = session.getId();
	%>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%=cartId%>"
						class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="#" class="btn btn-success">
						주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>	
				<%
					int sum = 0;
					ArrayList<Book> cartList = (ArrayList<Book>)
							session.getAttribute("cartlist");
					if(cartList == null || cartList.size() == 0){
				%>
					<tr>	
						<td colspan="5" align="center">장바구니에 상품이 없습니다.</td>
					</tr>
				<% 
					}else{
					
						for(int i=0; i<cartList.size(); i++){
							Book bookVO = cartList.get(i);
							int total = bookVO.getUnitPrice() * bookVO.getQuantity();
							sum = sum + total;
				%>
					<tr>
						<td><%=bookVO.getBookId()%> - <%=bookVO.getName()%></td>
						<td><%=bookVO.getUnitPrice()%></td>
						<td><%=bookVO.getQuantity()%></td>
						<td><%=total%></td>
						<td><a href="removeCart.jsp?id=<%=bookVO.getBookId()%>"
							class="badge badge-danger">삭제</a></td>
					</tr>
				<%
						}
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
			<a href="./books.jsp" class="btn btn-secondary"> &raquo; 쇼핑 계속하기</a>
		</div>
		<hr />
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>