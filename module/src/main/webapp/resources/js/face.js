Promise.all([
		faceapi.nets.tinyFaceDetector.loadFromUri('/resources/models'),
		faceapi.nets.faceLandmark68Net.loadFromUri('/resources/models'),
		faceapi.nets.faceRecognitionNet.loadFromUri('/resources/models'),
		faceapi.nets.ssdMobilenetv1.loadFromUri('/resources/models')
]).then(startVideo);


const loadImage = async (arr) => {
    // 업로드 된 이미지 이름을 배열에 담아 라벨링 합니다.
	const labels = JSON.parse(arr);
	return Promise.all(
		labels.map(async (label) => {
			const images = await faceapi.fetchImage('/resources/upload/'+label+'.png');
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