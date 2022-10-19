<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bookmarket.dto.Book"%>
<%@page import="java.util.List"%>
<%@page import="bookmarket.dao.BookRepository"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<%	// 스크립틀릿 태그
	// 기본적으로 3개의 상품이 생성되어 있는 객체 생성
	BookRepository bookDAO = BookRepository.getInstance();
	List<Book> listOfBooks = bookDAO.getAllBooks();
%>
<c:set var="listOfBooks" value="<%=listOfBooks%>" scope="page" />
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>도서 목록</title>
</head>
<body>
<%@ include file="menu.jsp" %>
<%!	// 선언문	태그
	// 전역 변수
	String greeting = "도서 목록";
%>
<!-- 표현문 -->
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3"><%=greeting %></h1>
	</div>
</div>
<!--=====================상품 목록=====================-->
<div class="container">
	<div class="row mb-4 mr-5" style="justify-content: right">
		<a href="addBook.jsp" class="btn btn-primary">
			상품추가
		</a>		
	</div>
	<c:forEach var="book" items="${listOfBooks}">
		 <div class="row">
		 	<div class="col-3">
		 		<img src="/resources/images/${book.fileName}" width="100%">
		 	</div>
		 	<div class="col-9">
				<h5>[${book.category}]
					${book.name}</h5>
				<p class="col-10">${book.description}</p>
				<p class="col-2">
					<a href="book.jsp?id=${book.bookId}"
							class="btn btn-secondary" role="button">상세정보&raquo;</a>
				</p>
				<p>${book.author} |
				${book.publisher} |
				${book.unitPrice}원</p>
			</div>
		</div>
		<hr>
	</c:forEach>
</div>
<!--====================상품 목록 끝====================-->
<%@ include file="footer.jsp" %>
</body>
</html>