<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	canvas {
		position: absolute;
	}
</style>
<script src="/resources/js/face-api.min.js"></script>
 
</head>
<body>
	<video id="video" width="720" height="560" autoplay="autoplay"></video>
<script type="text/javascript">
	const video = document.querySelector("#video");
	Webcam.attach( '#camera' );
	Promise.all([
		faceapi.nets.tinyFaceDetector.loadFromUri('/resources/models'),
		faceapi.nets.faceLandmark68Net.loadFromUri('/resources/models'),
		faceapi.nets.faceRecognitionNet.loadFromUri('/resources/models'),
		faceapi.nets.faceExpressionNet.loadFromUri('/resources/models')
	]).then(startVideo)

	function startVideo() {
		navigator.mediaDevices
			.getUserMedia({ video: true })
			.then( (stream) => { video.srcObject = stream; })
			.catch( (err) => { console.log(err); });
	}

	video.addEventListener('play', () =>{
		const canvas = faceapi.createCanvasFromMedia(video);
		var context = canvas.getContext('2d');
		document.body.append(canvas);
		const displaySize = { width: video.width, height:video.height}
		faceapi.matchDimensions(canvas, displaySize)
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
		const labels = ["you", "kimson"];

		return Promise.all(
		labels.map(async (label) => {
			const images = await faceapi.fetchImage(require(`./imgs/${label}.jpg`));
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
	const constraints = {
		video: {
			width: 640,
			height: 480,
		},
		audio: false,
	};
	function App() {
		// refs, states ...

		// 라벨링 할 인물 이미지 로컬에서 가져오기
		const loadImage = async () => {
			// 업로드 된 이미지 이름을 배열에 담아 라벨링 합니다.
			const labels = ["you", "kimson"];

			return Promise.all(
				labels.map(async (label) => {
					const images = await faceapi.fetchImage(require(`./imgs/${label}.jpg`));
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

		const onPlay = async () => {
			// 이미지 정보를 기반으로 canvas 요소 생성
			const canvas = faceapi.createCanvasFromMedia(videoRef.current);
			wrapRef.current.append(canvas);

			// 영상 사이즈를 canvas에 맞추기 위한 설정
			const displaySize = {
			width: videoRef.current.width,
			height: videoRef.current.height,
			};

			// canvas 사이즈를 맞춤
			faceapi.matchDimensions(canvas, displaySize);

			// 로컬 대조 이미지 가져오기
			const labeledFaceDescriptors = await loadImage();

			// 안면 인식 부분
			const faceDetecting = async () => {
				const detections = await faceapi
					.detectAllFaces(videoRef.current, new faceapi.TinyFaceDetectorOptions())
					.withFaceLandmarks()
					.withFaceExpressions()
					.withAgeAndGender()
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
					// 기본 안면 인식 테두리, 겹치므로 제외
					// faceapi.draw.drawDetections(canvas, resizedDetections);
					// 감정 읽기
					faceapi.draw.drawFaceExpressions(canvas, resizedDetections);
				});
			};

			const loop = () => {
				faceDetecting();
				setTimeout(loop, 1);
			};
			setTimeout(loop, 1);
		};

		const startDetecting = async () => {
			const loadModels = async () => {
				// promise ...
			};

			loadModels();
		};

		const startVideo = () => {
			// getMedia...
		};
		
	}
</script>
</body>
</html>