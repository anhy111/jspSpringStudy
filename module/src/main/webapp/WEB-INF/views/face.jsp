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
		display: flex;
		justify-content: center;
		align-items: center;
	}
	canvas{
		position: absolute;
	}


</style>
<script src="/resources/js/face-api.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<video id="video" width="720" height="560" autoplay="autoplay"></video>

<script type="text/javascript">
	const video = document.querySelector("#video");
	Promise.all([
		faceapi.nets.tinyFaceDetector.loadFromUri('/resources/models'),
		faceapi.nets.faceLandmark68Net.loadFromUri('/resources/models'),
		faceapi.nets.faceRecognitionNet.loadFromUri('/resources/models'),
		faceapi.nets.faceExpressionNet.loadFromUri('/resources/models')
	]).then(startVideo)

	function startVideo() {
		navigator.mediaDevices
			.getUserMedia({ video: true })
			.then( (stream) => { video.srcObject = stream })
			.catch( (err) => { console.log(err) });
	}

	video.addEventListener('play', () =>{
		const canvas = faceapi.createCanvasFromMedia(video); 
		var context = canvas.getContext('2d');
		document.body.append(canvas);
		const displaySize = { width: video.width, height:video.height};
		faceapi.matchDimensions(canvas, displaySize);
		
		// 로컬 대조 이미지 가져오기
		const labeledFaceDescriptors = await loadImage();
		
		
		
		setInterval(async () => {
			const detections = await faceapi.detectAllFaces(video,
			new faceapi.TinyFaceDetectorOptions()).withFaceLandmarks()
			.withFaceExpressions();
			const resizedDetections = faceapi.resizeResults(detections,
			displaySize)
			context.clearRect(0, 0, canvas.width, canvas.height);
			faceapi.draw.drawDetections(canvas, resizedDetections);
			faceapi.draw.drawFaceLandmarks(canvas, resizedDetections);
			faceapi.draw.drawFaceExpressions(canvas, resizedDetections);
		}, 100)
	});
	
	const loadImage = async () => {
	   // 업로드 된 이미지 이름을 배열에 담아 라벨링 합니다.
		const labels = ["hayong"];
	
		return Promise.all(
			labels.map(async (label) => {
				const images = await faceapi.fetchImage(require('/resources/upload/${captureVO.filename}.png'));
				const descriptions = [];
				const detections = await faceapi
				  .detectSingleFace(images)
				  .withFaceLandmarks()
				  .withFaceDescriptor();
				descriptions.push(detections.descriptor);
				
				return new faceapi.LabeledFaceDescriptors(label, descriptions);
			})
		);
	};

</script>
</body>
</html>