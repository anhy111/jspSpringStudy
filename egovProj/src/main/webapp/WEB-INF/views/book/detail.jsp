<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Detail</title>
<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	var $bookVO;
	var $inputs;
	var $price;
	var $date;
	var $updateBtn1;
	var $updateBtn2;
	var defaultData = [];
	$(function() {
		$bookVO = $("#bookVO");
		$inputs = $(".form-group input");
		$price = $("#price");
		$date = $("#date");
		$updateBtn1 = $("#updateBtn1");
		$updateBtn2 = $("#updateBtn2");
		
		
		$inputs.attr("readonly", "true");
		$updateBtn2.css("display","none");
		$("#edit").on("click",function(){
			
			$inputs.val( (p_inx, p_val) => {
				defaultData.push(p_val);
				return p_val;
			}).attr("readonly", function(){
						if(this.id == "bookId"){
							return true;
						}
						return false;
			}).attr("required",true);
			
			$bookVO.attr("method","post")
					.attr("action","/book/update");
						
			$date.css("display","none");
			
			$updateBtn1.css("display","none");
			$updateBtn2.css("display","block");
			
			CKEDITOR.instances['content'].setReadOnly(false);
		});
		
		$("#cancel").on("click",function(){
			
			$inputs.val( (p_inx) => { return defaultData[p_inx] })
				   	.attr("readonly", "true");
			
			
			$date.css("display","block");
			

			$updateBtn1.css("display","block");
			$updateBtn2.css("display","none");
			
			CKEDITOR.instances['content'].setReadOnly(true);
			
		});
		
		$price.on("keyup",function(){
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		})
		
		$("#delete").on("click",function(){
			$(this).val( $(this).val().replace(",","") );
			$bookVO.attr("method","post")
					.attr("action","/book/delete")
					.submit();
		});
		
		CKEDITOR.replace( "content" );
	});
</script>
</head>
<body>
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<form:form modelAttribute="bookVO">
						<div class="card card-primary">
							<div class="card-header">
								<h3 class="card-title">?????? ??????</h3>
							</div>
							<div class="card-body p-0">
								<div class="bs-stepper linear">
									<div class="bs-stepper-content">

										<div id="logins-part" class="content active dstepper-block"
											role="tabpanel" aria-labelledby="logins-part-trigger">
											<div class="form-group">
												<label for="exampleInputEmail1">BookId</label>
												<form:input type="text" class="form-control" path="bookId" />
											</div>
											<div class="form-group">
												<label for="exampleInputEmail1">Title</label>
												<form:input type="text" class="form-control" path="title" />
											</div>
											<div class="form-group">
												<label for="exampleInputEmail1">Category</label>
												<form:input type="text" class="form-control" path="category" />
											</div>
											<div class="form-group">
												<label for="exampleInputEmail1">Price</label> <input
													id="price" name="price" type="text" class="form-control"
													value='<fmt:formatNumber value="${bookVO.price}" pattern="#,###" />' />
											</div>
											<div class="form-group">
												<label for="inputDescription">Content</label>
												<textarea name="content"
													id="content" class="form-control rounded-0"
													readonly>${bookVO.content}</textarea>
											</div>
											<div class="form-group" id="date">
												<label>InsertDate</label>
												<div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> <i
															class="far fa-calendar-alt"></i>
														</span>
													</div>
													<form:input type="date" class="form-control float-right"
														path="insertDate" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-footer text-right">
								<div id="updateBtn1">
									<button id="edit" type="button" class="btn btn-warning">??????</button>
									<a href="/book/list" class="btn btn-primary">??????</a>
									<button id="delete" type="button" class="btn btn-danger">??????</button>
								</div>
								<div id="updateBtn2">
									<button id="update" type="submit" class="btn btn-success">??????</button>
									<button id="cancel" type="button" class="btn btn-secondary">??????</button>
								</div>
							</div>
						</div>
						<sec:csrfInput/>
					</form:form>

				</div>

			</div>
		</div>
	</section>
</body>
</html>