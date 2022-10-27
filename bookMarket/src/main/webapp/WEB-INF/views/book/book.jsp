<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>도서 상세</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">도서 정보</h1>
			</div>
		</div>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<img alt="${bookVO.name}" title="${bookVO.name}" 
					src="/resources/images/${bookVO.filename}"
					style="height:80%; width:80%;">
			</div>
			<div class="col-md-6">
				<h3>${bookVO.category}</h3>
				<p>${bookVO.description}</p>
				<p>
				   <b>도서 코드 : </b>
				   <span class="badge badge-danger">${bookVO.bookId}</span>
				</p>			
				<p><b>출판사</b> : ${bookVO.publisher}</p>
				<p><b>저자</b> : ${bookVO.author}</p>
				<p><b>재고 수</b> : ${bookVO.unitInStock}</p>
				<p><b>총 페이지수</b> : ${bookVO.totalPages}</p>
				<p><b>출판일</b> : ${bookVO.releaseDate}</p>
				<h4>${bookVO.unitPrice}원</h4>
				<p><a href="#" class="btn btn-info">도서 주문&raquo;</a>
				   <a href="/books" class="btn btn-secondary">도서 목록&raquo;</a>	
				</p>
			</div>
		</div>	
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>