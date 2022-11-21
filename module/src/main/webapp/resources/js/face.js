let timeoutID;
let unknownCount = 0;
let detectCount = 0;
const video = document.querySelector("#video");
	
Promise.all([
		faceapi.nets.tinyFaceDetector.loadFromUri('/resources/models'),
		faceapi.nets.faceLandmark68Net.loadFromUri('/resources/models'),
		faceapi.nets.faceRecognitionNet.loadFromUri('/resources/models'),
		faceapi.nets.ssdMobilenetv1.loadFromUri('/resources/models')
]).then(startVideo);

function startVideo() {
	navigator.mediaDevices
		.getUserMedia({ video: true })
		.then( (stream) => { video.srcObject = stream })
		.catch( (err) => { console.log(err) });
}

// 로컬에서 이미지 가져오기
const loadImage = async (arr) => {
    // 업로드 된 이미지 이름을 배열에 담아 라벨링 합니다.
	const labels = JSON.parse(arr);
	if(labels.length == 0){
		alert("등록되지 않은 이름입니다.\n회원가입으로 이동합니다.");
		location.href = "/signup";
	}
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


const faceDetecting = async (video, labeledFaceDescriptors, timeoutID) => {
	
	const canvas = faceapi.createCanvasFromMedia(video); 
	var context = canvas.getContext('2d');
	document.body.append(canvas);
	const displaySize = { width: video.width, height:video.height};
	faceapi.matchDimensions(canvas, displaySize);
	
	const detections = await faceapi
		.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions())
		.withFaceLandmarks()
		.withFaceDescriptors();

	const resizedDetections = faceapi.resizeResults(detections, displaySize);

	// canvas 초기화
	canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);

	const faceMatcher = new faceapi.FaceMatcher(labeledFaceDescriptors, 0.6);

	if(resizedDetections.length != 1 ){
		console.log("얼굴이 없거나 둘 이상입니다.");
		return;
	}	

	
	resizedDetections.forEach((detection, i) => {
		
		const matched = resizedDetections[i];
		const box = matched.detection.box;
		const label = faceMatcher.findBestMatch(matched.descriptor).toString();
		const drawBox = new faceapi.draw.DrawBox(box, {
			label: label
		});
		console.log(label);
		let chkLabel = label.split(" ")[0];
		drawBox.draw(canvas);
		faceapi.draw.drawFaceLandmarks(canvas, resizedDetections);
		
		if(chkLabel == "unknown"){
			++unknownCount;
		}

		if(detectCount >= 100){
			clearTimeout(timeoutID);
			canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);
			status.innerHTML = "인식:"+detectCount+", unknown:"+unknownCount+"<br>";
			
			// 정확도 계산을 위한 실패 횟수를 인식 횟수로 변환
			let knownCount = detectCount - unknownCount;
			status.innerHTML += "정확도 : " + knownCount / detectCount * 100 + "%";
			return;
		}
		
		++detectCount;
	});
	
	return {
		"detectCount" : detectCount,
		"unknownCount" : unknownCount
	}
}



