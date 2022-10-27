<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<title>배송 정보</title>
<script type="text/javascript">
$(function(){
	$("#btnZipCode").on("click",function(){
		new daum.Postcode({
			oncomplete:function(data){
				//zipCode
				$("input[name='zipCode']").val(data.zonecode);	//우편번호5자리
				//addressName
				$("input[name='addressName']").val(data.address);	//주소
				//addressDetail
				$("input[name='addressDetail']").val(data.buildingName);	//상세 주소
			}
		}).open();
	});
});
</script>
</head>
<body>
	<!-- include 액션 태그 -->
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	
	<!-- --------------------배송 정보 시작-------------------- -->
	<!-- /shippingInfo.jsp?cartId=FC168E8DF4B5079F18B719D89DA0075B -->
	<div class="container">
		<form action="/processShippingInfo" class="form-horizontal"
		method="post">
			<input type="text" name="cartId" 
			value="${cartId}" />
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input type="text" name="name" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">배송일</label>
				<div class="col-sm-3">
					<input type="date" name="shippingDate" 
					class="form-control" />(yyyy-mm-dd)
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input type="text" name="country" 
					class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="zipCode" 
					class="form-control" />
					<button type="button" id="btnZipCode" class="btn btn-info">우편번호검색</button>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-3">
					<input type="text" name="addressName" 
					class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세주소</label>
				<div class="col-sm-3">
					<input type="text" name="addressDetail" 
					class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<a href="/cart?cartId=${cartId}"
					class="btn btn-secondary" role="button">이전</a>
					<input type="submit" class="btn btn-primary" value="등록" />
					<a href="checkOutCancelled.jsp"
					class="btn btn-secondary" role="button">취소</a>
				</div>
			</div>
		</form>
	</div>
	
	<!-- --------------------배송 정보 끝-------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>




