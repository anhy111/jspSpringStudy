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
		faceapi.nets.ssdMobilenetv1.loadFromUri('/resources/models')
	]).then(startVideo)

	function startVideo() {
		navigator.mediaDevices
			.getUserMedia({ video: true })
			.then( (stream) => { video.srcObject = stream })
			.catch( (err) => { console.log(err) });
	}

	// 로컬에서 이미지 가져오기
	const loadImage = async () => {
	    // 업로드 된 이미지 이름을 배열에 담아 라벨링 합니다.
    	arr = '${captureVOList}';
		const labels = JSON.parse(arr);
		console.log(labels);
		return Promise.all(
			labels.map(async (label) => {
				const images = await faceapi.fetchImage('/resources/upload/'+label+'.png');
				const descriptions = [];
				const detections = await faceapi
				.detectSingleFace(images)
				.withFaceLandmarks()
				.withFaceDescriptor();
				if(detections == undefined){
					console.log(label);
				}
				descriptions.push(detections.descriptor);
				
				return new faceapi.LabeledFaceDescriptors(label, descriptions);
			})
		);
	};

	video.addEventListener('play', async () =>{
		const canvas = faceapi.createCanvasFromMedia(video); 
		var context = canvas.getContext('2d');
		document.body.append(canvas);
		const displaySize = { width: video.width, height:video.height};
		faceapi.matchDimensions(canvas, displaySize);

		// 로컬 대조 이미지 가져오기
		const labeledFaceDescriptors = await loadImage();

		const faceDetecting = async () => {
			const detections = await faceapi
				.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions())
				.withFaceLandmarks()
				.withFaceDescriptors();

			const resizedDetections = faceapi.resizeResults(detections, displaySize);

			// canvas 초기화
			canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);

			const faceMatcher = new faceapi.FaceMatcher(labeledFaceDescriptors, 0.6);

			resizedDetections.forEach((detection, i) => {
				const matched = resizedDetections[i];
				const box = matched.detection.box;
				const label = faceMatcher.findBestMatch(matched.descriptor).toString();
				const drawBox = new faceapi.draw.DrawBox(box, {
				label: label,
				});
				drawBox.draw(canvas);
			});
		}
		const loop = () => {
			faceDetecting();
			setTimeout(loop, 1);
		};
		setTimeout(loop, 1);
	});
	
</script>
</body>
</html>