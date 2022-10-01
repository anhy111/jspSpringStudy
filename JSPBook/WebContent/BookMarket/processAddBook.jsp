<%@page import="bookmarket.dao.BookRepository"%>
<%@page import="bookmarket.dto.Book"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		Book book = new Book();
		book.setBookId(request.getParameter("bookId"));		
		book.setName(request.getParameter("name"))		;
		book.setUnitPrice(Integer.parseInt(request.getParameter("unitPrice")));
		book.setAuthor(request.getParameter("author"))  	;	
		book.setDescription(request.getParameter("description"));  
		book.setPublisher(request.getParameter("publisher"))  ;
		book.setCategory(request.getParameter("category"))  	;
		book.setUnitsInStock(Long.parseLong(request.getParameter("unitsInStock"))) ;	
		book.setTotalPages(Long.parseLong(request.getParameter("totalPages")));
		book.setReleaseDate(request.getParameter("releaseDate"));
		book.setCondition(request.getParameter("condition"));
		
		BookRepository.getInstance().addBook(book);
		response.sendRedirect("books.jsp");
	%>
</body>
</html>