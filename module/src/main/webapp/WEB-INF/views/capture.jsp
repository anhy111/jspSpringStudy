<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<title>webRTC Color filter demo</title>
		<style type="text/css">
			body {
				font-family: Arial, sans-sefif;
				text-align: center;
				font-size: 16px;
			}

			.navbar {
				background-color: #889999;
				width: 640px;
				margin: 0 auto;
				height: 35px;
				line-height: 35px;
			}

			h1 {
				font-size: 23px;
				color: #fff;
				text-align: center;
			}

			/*캔버스를 감춤 */
			#canvas {
				display: none;
			}

			label {
				margin-right: 5px;
			}

			label:hover {
				cursor: pointer;
			}

			form {
				width: 640px;
				margin-bottom: 20px;
			}

			.top-container {
				width: 640px;
				margin: 0 auto;
				text-align: center;
				padding: 0;
				background-color: #fff;
				border-radius: 6px;
			}

			.bottom-container {
				margin-top: 20px;
				width: 640px;
				margin: 0 auto;
				text-align: center;
				padding: 0;
			}

			#photos {
				width: 640px;
				margin: 0 auto;
			}

			.btn {
				width: 150px;
				height: 40px;
				border-radius: 8px;
				border: 1px solid #778899;
				background-color: #337799;
				color: white;
				margin-bottom: 20px;
			}

			.btn:hover {
				background-color: #990000;
			}
		</style>
	</head>

	<body>
		<!-- 제목 -->
		WebRTC Color Filters Demo
		<div class="top-container">
			<video id="video">Stream not available
			</video>
			<!-- select filter / CSS filters -->
			<form id="frm" action="/capture" method="post" enctype="multipart/form-data">

			</form>
			<button id="photo-button" class="btnbtn-dark">Take photo</button>
			<button id="clear-button" class="btnbtn-dark">Clear</button>
			<canvas id="canvas"></canvas>
			<div id="photos"></div>
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
			const photoFilter = document.querySelector("#photo-filter");
			const form = document.querySelector("#frm");

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
					//캔버스에 그리기
					context.drawImage(video, 0, 0, width, height);
					//캔버스로붙 실제 이미지를 가져오기
					const imgUrl = canvas.toDataURL('image/png');
					//엘리먼트를 만들고 가져온 이미지를 출력하기
					const img = document.createElement('img');
					img.setAttribute('src', imgUrl);
					img.setAttribute('name',"img");
					img.style.filter = filter;
					//photos Div 안에 추가하기
					form.appendChild(img);
// 					form.submit();
				}
			}
		</script>
	</body>

	</html>