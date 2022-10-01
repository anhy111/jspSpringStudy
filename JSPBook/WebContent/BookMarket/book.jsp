<%@page import="bookmarket.dto.Book"%>
<%@page import="bookmarket.dao.BookRepository"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%	
	String id = request.getParameter("id");
	BookRepository bookRepository = BookRepository.getInstance();
	Book bookVO = bookRepository.getBookById(id);
%>
<c:set var="bookVO" value="<%=bookVO%>" scope="page" />
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
<jsp:include page="../ch06/menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">상품목록</h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
<div class="container">
	<div class="row">
		<div class="col">
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
			<p>
				<a href="#" class="btn btn-info">도서주문&raquo;</a>
				<a href="books.jsp" class="btn btn-secondary">도서목록&raquo;</a>
			</p>
		</div>
	</div>
	<hr>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->
<jsp:include page="../ch06/footer.jsp"/>
</body>
</html>