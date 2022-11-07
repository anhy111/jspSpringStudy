<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">

    <!-- Exception Error Image -->
    <div class="text-center">
		<h4>${exception.getMessage()}</h4>
    	<img src="/resources/images/exception.jpg" />
    	<ul>
	    	<c:forEach var="stack" items="${exception.getStackTrace()}">
	    		<li>${stack.toString()}</li>
	    	</c:forEach>
    	</ul>
    </div>
	
</div>