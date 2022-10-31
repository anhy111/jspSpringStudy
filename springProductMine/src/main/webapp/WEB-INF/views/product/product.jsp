<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	function addToCart(){
		if(confirm("상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
	
	$(function(){
// 		$("#addCart").on("click",function(){
// 			let productId = "${data.productId}";
			
// 			// get방식으로 /board/7로 요청
// 			// json데이터로 비동기 응답
// 			$.get("/addCart/"+productId,function(data){
// 				console.log("data : ",data);
// 			});
// 		}); // end btnAccept click
	});
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<!-- --------------------상품상세 시작-------------------- -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="/resources/upload${data.filename}" 
				alt="${data.pname}" title="${data.pname}" 
				style="width:100%;"/>
			</div>		
			<div class="col-md-6">
				<h3>${data.pname}</h3>
				<p>${data.description}</p>
				<p>
					<b>상품 코드 : </b>
					<span class="badge badge-danger">
					${data.productId}
					</span>
				</p>
				<p><b>제조사 : </b>${data.manufacturer}</p>
				<p><b>분류 : </b>${data.category}</p>
				<p><b>재고 수 : </b>${data.unitInStock}</p>
				<h4>${data.unitPrice}</h4>
				<p>
				<form name="addForm" action="/addCart?productId=${data.productId}"
				method="post">
<!-- 					<input type="button" class="btn btn-info" id="addCart" value="상품 주문&raquo;" /> -->
					<input type="submit" class="btn btn-info" id="addCart" value="상품 주문&raquo;" />
					<a href="/cart" class="btn btn-warning">장바구니&raquo;</a><br><br>
					<a href="/update?productId=${data.productId}" class="btn btn-info">상품 수정&raquo;</a>
					<a href="/delete?productId=${data.productId}" class="btn btn-danger">상품 삭제&raquo;</a><br><br>
					<a href="/products" class="btn btn-secondary">상품 목록&raquo;</a>
				</form>
				</p>
			</div>
		</div>
	</div>
	<!-- --------------------상품상세 끝-------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>






