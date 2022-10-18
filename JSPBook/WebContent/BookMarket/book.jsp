<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="exceptionNoBookId.jsp"%>  
<%@page import="bookmarket.dto.Book"%>
<%@page import="bookmarket.dao.BookRepository"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%	
	String id = request.getParameter("id");
	BookRepository bookRepository = BookRepository.getInstance();
	Book bookVO = bookRepository.getBookById(id);
	if(bookVO == null){
		throw new NullPointerException();
	}
%>
<c:set var="bookVO" value="<%=bookVO%>" scope="page" />
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>도서 정보</title>
<script type="text/javascript">
	function addToCart() {
		if(confirm("상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		} else{
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">도서 정보</h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
<div class="container">
	<div class="row">
		<div class="col-4">
			<img src="/resources/images/${bookVO.fileName}" width="100%">
		</div>
		<div class="col -8">
			<h3>[${bookVO.category}]${bookVO.name}</h3>
			<p>${bookVO.description }</p>
			<p>
				<b>도서코드 : </b>
				<span class="badge badge-danger">${bookVO.bookId}</span>
			</p>
			<p>
				<b>출판사 :</b> ${bookVO.publisher }
			</p>
			<p>
				<b>저자 :</b> ${bookVO.author}
			</p>
			<p>
				<b>재고수 :</b> ${bookVO.unitsInStock}
			</p>
			<p>
				<b>총 페이지수 :</b> ${bookVO.totalPages}
			</p>
			<p>
				<b>출판일 :</b> ${bookVO.releaseDate}
			</p>
			
			<h4>${bookVO.unitPrice}원</h4>
			<p><form name="addForm" action="addCart.jsp?id=<%=bookVO.getBookId()%>" method="post">
				<a href="#" class="btn btn-info" onclick="addToCart()">도서주문&raquo;</a>
				<a href="cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
				<a href="books.jsp" class="btn btn-secondary">도서목록&raquo;</a>
			</form>
		</div>
	</div>
	<hr>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->
<jsp:include page="footer.jsp"/>
</body>
</html>