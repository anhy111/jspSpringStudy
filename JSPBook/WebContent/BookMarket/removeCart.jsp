<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bookmarket.dto.Book"%>
<%@page import="bookmarket.dao.BookRepository"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")){
		response.sendRedirect("books.jsp");
		return;
	}
	
	BookRepository dao = BookRepository.getInstance();
	
	Book bookVO = dao.getBookById(id);
	if(bookVO == null){
		response.sendRedirect("exceptionNoBookId.jsp");
	}
	
	ArrayList<Book> cartList = (ArrayList<Book>)
									session.getAttribute("cartlist");
	Book goodsQnt = new Book();
	for(int i=0; i<cartList.size(); i++){
		goodsQnt = cartList.get(i);
		if(goodsQnt.getBookId().equals(id)){
			cartList.remove(goodsQnt);
		}
	}
	
	response.sendRedirect("cart.jsp");
%>