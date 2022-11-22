<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Write</title>
<script src="/resources/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	var $bookVO;
	var $inputs;
	var $price;
	var $date;
	$(function() {
		$bookVO = $("#bookVO");
		$inputs = $(".form-group input");
		$price = $("#price");
		$date = $("#date");
		
		$inputs.attr("required",true);
		$("input[name='bookId']").attr("readonly",true);
		
		$price.on("keyup",function(){
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
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
					<form action="/book/insert" method="post">
						<div class="card card-primary">
							<div class="card-header">
								<h3 class="card-title">도서 입력</h3>
							</div>
							<div class="card-body p-0">
								<div class="bs-stepper linear">
									<div class="bs-stepper-content">
										<div id="logins-part" class="content active dstepper-block"
											role="tabpanel" aria-labelledby="logins-part-trigger">
											<div class="form-group">
												<label for="exampleInputEmail1">Title</label>
												<input type="text" class="form-control" name="title" />
											</div>
											<div class="form-group">
												<label for="exampleInputEmail1">Category</label>
												<input type="text" class="form-control" name="category" />
											</div>
											<div class="form-group">
												<label for="exampleInputEmail1">Price</label> 
												<input id="price" name="price" type="text" class="form-control" />
											</div>
											<div class="form-group">
												<label>Content</label>
												<textarea id="content" name="content" class="form-control" 
													rows="4" style="height: 124px;"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-footer text-right">
								<button type="submit" class="btn btn-success">등록</button> <a
									href="/book/list" class="btn btn-primary">목록</a>
							</div>
						</div>
						<sec:csrfInput/>
					</form>

				</div>

			</div>
		</div>
	</section>
</body>
</html>