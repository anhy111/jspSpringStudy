<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Ajax 파일 업로드</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#inputFile").on("change",function(event){
			let files = event.target.files;
			
			let file = files[0];
			
			let formData = new FormData();
			formData.append("file",file);
			
			$.ajax({
				url:"/board/uploadAjax",
				processData:false,
				contentType:false,
				data:formData,
				type:"post",
				dataType:"text",
				success:function(data){
					console.log("data : " + data);
				}
			});
		});
	});
</script>
</head>
<body>
	<form action="" method="post" enctype="multipart/form-data">
		<p><input type="file" id="inputFile" name="picture" /></p>
		<p><input type="submit" value="업로드" /></p>
	</form>
	<hr>
</body>
</html>