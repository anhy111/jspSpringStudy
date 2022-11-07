<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>Ajax 방식으로 파일 요소값을 전달</title>
<script type="text/javascript">
$(function(){
	$("#inputFile").on("change",function(e){
		console.log("change");
		//e : 파일객체의 속성값이 바뀌었을 때 그 이벤트 객체
		//e.target => <input type="file" id="inputFile" />
		let files = e.target.files;
		//첫번째 파일 객체
		let file = files[0];
		console.log("file : " + file);
		//가상의 폼 태그 생성 <form></form>
		let formData = new FormData();
		//폼 태그 안에 파일객체가 들어감
		formData.append("file",file);
		console.log("formData : " + formData);
		
		//비동기 통신
		//아작났어.유.피씨다탔어.에..
		$.ajax({
			url:"/member/uploadAjaxPost",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			success:function(data){
				//"UPLOAD SUCCESS sjs.jpg"
				console.log("data : " + data);
			}
		});
	});
});
</script>
</head>
<body>
<h3>Ajax File Upload</h3>
<div>
	<input type="file" id="inputFile" />
</div>
</body>
</html>




