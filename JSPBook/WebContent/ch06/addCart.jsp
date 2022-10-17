<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ch04.vo.ProductVO"%>
<%@page import="ch04.dao.ProductRepository"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	ProductVO goods = dao.getProductById(id);
	if(goods == null ){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<ProductVO> list = (ArrayList<ProductVO>)session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<ProductVO>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	ProductVO goodsQnt = new ProductVO();
	
	for(int i=0; i<list.size(); i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cnt++;
			int orderQuantity = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	
	if(cnt == 0){
		goods.setQuantity(1);
		list.add(goods);
	}
	
	response.sendRedirect("product.jsp?id=" + id);
%>