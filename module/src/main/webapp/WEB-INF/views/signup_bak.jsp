<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<title>webRTC Color filter demo</title>
	<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
	<style type="text/css">
	
		body {
			text-align: center;
		}

		/*캔버스를 감춤 */
		#canvas {
			display: none;
		}
		.top-container {
			width: 640px;
			margin: 0 auto;
			text-align: center;
			padding: 0;
			background-color: #fff;
			border-radius: 6px;
		}

		#photos {
			width: 640px;
			margin: 0 auto;
		}
	</style>
</head>

<body>
	<!-- 제목 -->
	WebRTC Color Filters Demo
	<div class="top-container">
		<video id="video">Stream not available</video>
		<!-- select filter / CSS filters -->
		<input type="text" name="name" id="name" placeholder="이름을 입력하세요" />
		<button id="photo-button" class="btnbtn-dark">캡처</button>
		<button id="clear-button" class="btnbtn-dark">Clear</button>
		<canvas id="canvas"></canvas>
		<div id="photos"></div>
		<a class="btnbtn-dark" href="/login">로그인하기</a>
	</div>
	<!-- 캡처한 사진들을 출력 -->
	<script type="text/javascript">
		let width = 640,
			height = 0,
			filter = "none",
			streaming = false;

		// DOM Elements
		const video = document.querySelector("#video");
		const canvas = document.querySelector("#canvas");
		const photos = document.querySelector("#photos");
		const photoButton = document.querySelector("#photo-button");
		const clearButton = document.querySelector("#clear-button");

		//Get media stream
		navigator.mediaDevices.getUserMedia({ video: true, audio: false })
			.then(function (stream) {
				video.srcObject = stream;
				video.onloadedmetadata = function (e) {
					video.play();
				};
			})
			.catch(function (err) {
				console.log('Error: ' + err.name + "/" + err.message);
			});

		//Play when ready
		video.addEventListener('canplay', function (e) {
			if (!streaming) {
				//Set video/canvas height
				height = video.videoHeight / (video.videoWidth / width);
				video.setAttribute('width', width);
				video.setAttribute('height', height);
				canvas.setAttribute('width', width);
				canvas.setAttribute('height', height);
				video.style.filter = "none";

				streaming = true;
			}
		}, false);


		//Clear button evnet
		clearButton.addEventListener('click', function (e) {
			photos.innerHTML = "";
		});

		//Capture button click
		photoButton.addEventListener('click', function (e) {
			takePicture();

			e.preventDefault();
		}, false);

		function takePicture() {
			const context = canvas.getContext('2d');
			if (width && height) {
				canvas.width = width;
				canvas.height = height;
				
				let name = document.querySelector("#name").value;
				
				if(!name){
					alert("이름을 입력하세요");
					return;
				}
				
				//캔버스에 그리기
				context.drawImage(video, 0, 0, width, height);
				//캔버스로 붙일 실제 이미지를 가져오기
				const imgUrl = canvas.toDataURL('image/png');
				//엘리먼트를 만들고 가져온 이미지를 출력하기
				const img = document.createElement('img');
				img.setAttribute('src', imgUrl);
				img.setAttribute('name',"img");
				img.style.filter = filter;
				//photos Div 안에 추가하기
				photos.appendChild(img);
				
				var myImg = canvas.toDataURL("image/png");
				myImg = myImg.replace("data:image/png;base64,", "");
				
				$.ajax({
					type : "POST",
					data : {
						"img" : myImg,
						"name" : name
					},
					dataType : "text",
					url : "/signup",
					success : function(data) {
						console.log(data);
					},
					error : function(a, b, c) {
						alert("error");
					}
				});
			}
		}
	</script>
</body>

</html>