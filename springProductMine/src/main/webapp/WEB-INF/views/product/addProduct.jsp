<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 등록</title>
<style type="text/css">
	.imgs_wrap{
		width: 300px;
		margin-top: 50px;
	}
	
	.imgs_wrap img{
		max-width: 100%;
	}
</style>
<script type="text/javascript" src="/resources/js/validation.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 이미지 미리보기
		let sel_file = [];
		
		$("#productImage").on("change",handleImgFileSelect);
		
		function handleImgFileSelect(e) {
			let files = e.target.files;
			
			// 이미지가 여러개가 있을 수 있으므로 이미지를 분리하여 배열로 만듦
			let fileArr = Array.prototype.slice.call(files);
			
			fileArr.forEach(function(f){
				// 유효성 검사
				if(!f.type.match("image.*")){
					alert("이미지 확장자만 가능합니다.");
					return;
				}
				
				sel_file.push(f);
				
				let reader = new FileReader();
				reader.onload = function(e){
					// e.target : 이미지 객체
					// e.target.result : reader가 이미지를 다 읽은 결과
					console.log(e.target);
					let img_html = "<img src=\"" + e.target.result + "\" />";
					
					$(".imgs_wrap").append(img_html);
				}
				// f: 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화
				reader.readAsDataURL(f);
			}); // end forEach
			
		}// end handleImgFileSelect()
		
		let header = "${_csrf.headerName}";
		let token = "${_csrf.token}";
		
		$.ajax({
			url: "/getProductId",
			beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
			},
			type:"post",
			success:function(result){
				$("#productId").val(result.productId);
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><spring:message code="title"/></h1>
		</div>
	</div>
<!-- ========================= 상품 등록 시작 =================================== -->
	<div class="container">
		<div class="text-right">
			<a href="?language=ko">Korea</a> | <a href="?language=en">English</a>
		</div> 
		<form name="newProduct" action="/addProduct" class="form-horizontal" method="post"
				enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="productId"/></label>
				<div class="col-sm-3">
					<input type="text" id="productId" name="productId" class="form-control" readonly>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="pname"/></label>
				<div class="col-sm-3">
					<input type="text" id="pname" name="pname" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="unitPrice"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="description"/></label>
				<div class="col-sm-3">
					<textarea id="description" name="description" rows="2" cols="50" class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="manufacturer"/></label>
				<div class="col-sm-3">
					<input type="text" id="manufacturer" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="category"/></label>
				<div class="col-sm-3">
					<input type="text" id="category" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="unitInStock"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitInStock" name="unitInStock" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="condition"/></label>
				<div class="col-sm-5">
					<input type="radio" id="condition1" name="condition" value="New"/><spring:message code="condition_New"/>
					<input type="radio" id="condition2" name="condition" value="Old"/><spring:message code="condition_Old"/>
					<input type="radio" id="condition3" name="condition" value="Refurbished"/><spring:message code="condition_Refurbished"/>					
				</div>
			</div>
			<!-- ch07에서 추가됨 -->
			<div class="form-group row">
				<label class="col-sm-2"><spring:message code="productImage"/></label>
				<div class="col-sm-5">
					<input type="file" id="productImage" name="productImage" class="form-control"
							multiple />
				</div>
			</div>
			<div class="form-group row">
				<div class="imgs_wrap">
				
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="<spring:message code='button'/>" onclick="checkAddProduct()"/>
					<a href="products" class="btn btn-warn"><spring:message code="productList"/></a>
				</div>
			</div>
		</form>
		<!-- 사용자 정보 -->
		<p>principal : <sec:authentication property="principal"/></p>
		<p>memberVO : <sec:authentication property="principal.memberVO"/></p>
		<p>사용자 이름 : <sec:authentication property="principal.memberVO.memName"/></p>
		<p>사용자 아이디 : <sec:authentication property="principal.memberVO.memId"/></p>
		<p>사용자 권한 리스트 : <sec:authentication property="principal.memberVO.memberAuthVOList"/></p>
	</div>
	<!-- ========================= 상품 등록 끝 ================================= -->
	<jsp:include page="footer.jsp"/>
</body>
</html>