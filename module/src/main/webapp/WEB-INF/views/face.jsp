<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
		width: 100vw;
		height: 100vh;
		align-items: center;
	}
	
	video{
		position: absolute;
	}
	
	canvas{
		position: absolute;
	}
	
}


</style>
<script src="/resources/js/face-api.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<h2 id="detecth2">인식횟수 : 0</h2>
	<h2 id="unknownh2">unknown횟수 : 0</h2>
	<h2 id="status">모델 로딩 중</h2>
	<video id="video" width="720" height="560" autoplay="autoplay"></video>
	
<script type="text/javascript" src="/resources/js/face.js"></script>
<script type="text/javascript">
	const detecth2 = document.querySelector("#detecth2");
	const unknownh2 = document.querySelector("#unknownh2");
	const status = document.querySelector("#status");
	
	video.addEventListener('play', async () =>{
		// 로컬 대조 이미지 가져오기
		const labeledFaceDescriptors = await loadImage('${captureVOList}');

		const loop = () => {
			let json = faceDetecting(video, labeledFaceDescriptors, timeoutID);
			console.log(json);
			timeoutID = setTimeout(loop, 10);
		};
		loop();
	});



	
</script>
</body>
</html>