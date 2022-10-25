<%@page import="kr.or.ddit.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<%
	//세션의 고유 아이디(장바구니 번호)
	String cartId = session.getId();
// 	out.print("cartId : " + cartId);
%>
<title>장바구니</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button[name='btn']").on("click",function(){
			
			let productId = this.value;
			
			$.get("/removeCart/"+productId,function(data){
				console.log("data : ",data);
			});
			location.reload();
		});
		
		$("#delete").on("click",function(){
			$.get("/deleteCart",function(data){
				console.log("data : ",data);
			});
			location.reload();
		})
	});
</script>
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
						<button id="delete"
						class="btn btn-danger">삭제하기</button>
					</td>
					<td align="right">
						<a href="#" 
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
				<%	//스크립틀릿
					//금액 누적하는 변수
					long sum = 0;
					//addCart.jsp의 session.setAttribute("cartlist", list);
					List<ProductVO> cartList
						= (ArrayList<ProductVO>)session.getAttribute("cartlist");	//list : 장바구니{P1234상품,P1236상품}
					
					//장바구니가 비었다면..
					if(cartList==null || cartList.size() == 0){
					%>
					<tr style="text-align:center;">
						<td colspan="5" style="text-align:center;">장바구니에 상품이 없습니다.</th>
					</tr>
					<%					
					}else{
					//상품 리스트 하나씩 꺼냄
					for(ProductVO product : cartList){
						//금액 = 가격 * 수량
						long total = product.getUnitPrice() * product.getQuantity();
						//금액이 누적됨
						sum = sum + total;
				%>
				<tr>
					<td><%=product.getProductId()%> - <%=product.getPname()%></td>
					<td><%=product.getUnitPrice()%></td>
					<td><%=product.getQuantity()%></td>
					<td><%=total%></td>
					<td>
						<button type="button" value="<%=product.getProductId()%>"
						class="badge badge-danger" name="btn">삭제</button>
					</td>
				</tr>
				<%						
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
				<%
				}//end if
				%>
			</table>
			<a href="/products" class="btn btn-secondary">&laquo;쇼핑 계속하기</a>
		</div>
		<!-- 장바구니 출력 끝 -->
	</div>
	<!-- ------------장바구니 상세 내용 끝 ------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>





