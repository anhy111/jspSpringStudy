<%@page import="kr.or.ddit.vo.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<%
	//세션의 고유 아이디(장바구니 번호)
	String cartId = session.getId();
	out.print("cartId : " + cartId);
%>
<title>장바구니</title>
</head>
<body>
	<!-- include 액션 태그 -->
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<!-- ------------장바구니 상세 내용 시작 ------------------- -->
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="deleteCart.jsp?cartId=<%=cartId%>" 
						class="btn btn-danger">삭제하기</a>
					</td>
					<td align="right">
						<a href="shippingInfo.jsp?cartId=<%=cartId%>" 
						class="btn btn-success">주문하기</a>
					</td>
				</tr>
			</table>
		</div>
		<!-- 장바구니 출력 시작 -->
		<!-- padding-top : 영역의 위쪽 여백 50px -->
		<div style="padding-top:50px;">
			<table class="table table-hover">
				<tr>
					<th>상품</th><th>가격</th><th>수량</th>
					<th>금액</th><th>비고</th>
				</tr>
				<%//스크립틀릿
					//금액 누적하는 변수
					double sum = 0;
					//addCart.jsp의 session.setAttribute("cartlist", list);
					ArrayList<ProductVO> cartList 
						= (ArrayList<ProductVO>)session.getAttribute("cartlist");	//list : 장바구니{P1234상품,P1236상품}
					
//장바구니가 비었다면..
if(cartList==null){
%>
					<tr style="text-align:center;">
						<td colspan="5" style="text-align:center;">장바구니에 상품이 없습니다.</th>
					</tr>
<%					
}else{
					//상품 리스트 하나씩 꺼냄
					for(ProductVO product : cartList){
						//금액 = 가격 * 수량
						double total = product.getUnitPrice() * product.getQuantity();
						BigDecimal totalBig = new BigDecimal(total);
						//금액이 누적됨
						sum = sum + total;
				%>
				<tr>
					<td><%=product.getProductId()%> - <%=product.getPname()%></td>
					<td><%=product.getUnitPrice()%></td>
					<td><%=product.getQuantity()%></td>
					<td><%=totalBig%></td>
					<td>
						<a href="removeCart.jsp?id=<%=product.getProductId()%>"
						class="badge badge-danger">삭제</a>
					</td>
				</tr>
				<%						
					}
					//double 지수형태 알파벳 숫자를 원래 숫자로 바꿈
					BigDecimal big = new BigDecimal(sum);
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=big%></th>
					<th></th>
				</tr>
<%
}//end if
%>
			</table>
			<a href="products.jsp" class="btn btn-secondary">&laquo;쇼핑 계속하기</a>
		</div>
		<!-- 장바구니 출력 끝 -->
	</div>
	<!-- ------------장바구니 상세 내용 끝 ------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>





