<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
<title>Ajax를 이용한 파일업로드</title>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	//확장자가 exe, sh, zip, alz이니?
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; //5MB
	
	//파일의 확장자, 크기 체킹
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈가 초과되었습니다");
			//함수 종료
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	//e : event
	$("#uploadBtn").on("click",function(e){
		//가상의 form 태그 생성 <form></form>
		let formData = new FormData();
		// 꺽임쇠input type="file" name="uploadFile" multiple닫기꺽임쇠 
		let inputFile = $("input[name='uploadFile']");
		//inputFile[0] : input type="file"
		//.files : 그 안에 들어온 파일객체들
		let files = inputFile[0].files;
		
		console.log(files);
		
		//formdata에다 filedata를 추가해보자
		for(let i = 0;i<files.length;i++){
			//파일확장자 체킹(확장자가 exe, sh, zip, alz이니?=>통과시 true가 return됨)
			if(!checkExtension(files[i].name, files[i].size)){
				//반복문 종료 및 함수 종료
				return false;
			}
			
			//<form>
			//	<input type="file" name="uploadFile" />
			//</form>
			formData.append("uploadFile",files[i]);
		}
		
		let strCsrf = $("input[name='_csrf']").val();
		
		console.log("strCsrf : " + strCsrf);
		
		formData.append("_csrf",strCsrf);
		
		//아작났어유ㅠㅠ 피씨다타써
		$.ajax({
			url:"/upload/uploadAjaxAction",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(result){
				console.log("result : " + result);
				console.log("uploaded");
			}
		});
	});
});
</script>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple />
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<sec:csrfInput/>
</body>
</html>