<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var fileList;
	var fileCnt = 2;
	var arr = [];
	$(function(){
		fileList = document.querySelector("#fileList");
		$("#addBtn").on("click",fileAdd);
		$("#rmvBtn").on("click",fileRmv);
		let fileArr = document.querySelectorAll("#fileList div");
		arr.push(fileArr[0]);
		arr.push(fileArr[1]);
		
		
	});
	
	function fn_chk(){
		let userPw = document.getElementById("userPw").value;
		let userPwCheck = document.getElementById("userPwCheck").value;
		let spanPwCheck = document.getElementById("spanPwCheck");
		
		console.log("userPw : " + userPw + ", userPwCHeck : " + userPwCheck);
		
		if(userPw != userPwCheck){
			spanPwCheck.innerHTML = "비밀번호가 다릅니다.";
			return false;
		}
	}
	
	function fileAdd() {

		let br = document.createElement("br");
        let input = document.createElement("input");
		input.id = '\"attachVOList'+fileCnt+'.filename\"';
		input.name = '"attachVOList['+fileCnt+'].filename"';
		input.placeholder = "첨부파일명";
		input.className = "form-control form-control-user";
		input.type ="text";

		let font = document.createElement("font");
		let span = document.createElement("span");
		span.id = '"attachVOList'+fileCnt+'.filename.errors"';
		font.appendChild(span);
		let div = document.createElement("div");
		
		div.appendChild(br);
		div.appendChild(input);
		div.appendChild(font);
		fileList.appendChild(div);
		fileCnt++;
	}
	
	function fileRmv(){
		if(fileCnt <= 2){
			return;
		}
		fileCnt--;
		fileList.removeChild(fileList.lastChild);			
	}
	
	
</script>
<div class="container">

	<div class="card o-hidden border-0 shadow-lg my-5">
	    <div class="card-body p-0">
	        <!-- Nested Row within Card Body -->
	        <div class="row">
	            <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
	            <div class="col-lg-7">
	                <div class="p-5">
	                    <div class="text-center">
	                        <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
	                    </div>
	                    <form:form modelAttribute="memVO" class="user" method="post"
	                    	action="/previews/writePost" onsubmit="return fn_chk()">
	                        <div class="form-group row">
	                            <div class="col-sm-6 mb-3 mb-sm-0">
	                                <form:input class="form-control form-control-user" path="userId" placeholder="userId" />
	                                <font color="red">
	                                	<form:errors path="userId" />	
	                                </font>
	                            </div>
	                            <div class="col-sm-6">
	                                <form:input class="form-control form-control-user" path="userName" placeholder="userName" />
	                                <font color="red">
	                                	<form:errors path="userName" />	
	                                </font>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <form:input class="form-control form-control-user" path="userEmail" placeholder="Email Address" />
	                            <font color="red">
	                                	<form:errors path="userEmail" />	
	                            </font>
	                        </div>
	                        <div class="form-group">
	                            <form:input class="form-control form-control-user" path="updDate" placeholder="변경일자" />
	                            <font color="red">
	                                	<form:errors path="updDate" />	
	                            </font>
	                        </div>
	                        
	                        <button id="addBtn" type="button" class="btn btn-success btn-circle btn-sm">
                                <i class="fas fa-check"></i>
                            </button>
                            <button id="rmvBtn" type="button" class="btn btn-danger btn-circle btn-sm">
                                <i class="fas fa-trash"></i>
                            </button>
	                        <div class="form-group" id="fileList">
	                        	<!-- attachVOList : List<AttachVO>
	                        		attachVOList[0] : attachVO
	                        	 -->
	                        	<div id="attach0">
		                        	<br>
		                            <form:input class="form-control form-control-user" path="attachVOList[0].filename" placeholder="첨부파일명" />
		                            <font color="red">
		                                	<form:errors path="attachVOList[0].filename" />	
		                            </font>
	                            </div>
	                            <div id="attach1">
		                            <br>
		                            <form:input class="form-control form-control-user" path="attachVOList[1].filename" placeholder="첨부파일명" />
		                            <font color="red">
		                                	<form:errors path="attachVOList[1].filename" />	
		                            </font>
	                            </div>
	                        </div>
	                        <div class="form-group row">
	                            <div class="col-sm-6 mb-3 mb-sm-0">
	                                <form:password class="form-control form-control-user" path="userPw" placeholder="Password" />
	                                 <font color="red">
	                                	<form:errors path="userPw" />	
	                           		 </font>
	                            </div>
	                            <div class="col-sm-6">
	                                <input type="password" class="form-control form-control-user" id="userPwCheck" placeholder="Repeat Password">
	                                 <font color="red">
	                                	<span id="spanPwCheck"></span>
	                           		 </font>
	                            </div>
	                        </div>
	                        <input type="submit" value="Register Account" class="btn btn-primary btn-user btn-block">
	                    </form:form>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

</div>