<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>
<div class="container-fluid">

    <!-- Exception Error Text -->
    <div class="text-center">
        <div class="error mx-auto" data-text="Exception">
        	<%=exception.getClass().getName()%>
        </div>
        <p class="lead text-gray-800 mb-5">
        	<%=exception.getMessage()%>
        </p>
        <p class="text-gray-500 mb-0">요청 사항을 수행할 수 없습니다.</p>
        <a href="/product/products">← 메인으로 이동</a>
    </div>

</div>