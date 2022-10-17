<%@page import="java.util.ArrayList"%>
<%@page import="ch04.vo.ProductVO"%>
<%@page import="ch04.dao.ProductRepository"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	ProductVO productVO = dao.getProductById(id);
	if(productVO == null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<ProductVO> cartList = (ArrayList<ProductVO>)
									session.getAttribute("cartlist");
	ProductVO goodsQnt = new ProductVO();
	for(int i=0; i<cartList.size(); i++){
		goodsQnt = cartList.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cartList.remove(goodsQnt);
		}
	}
	
	response.sendRedirect("cart.jsp");
%>