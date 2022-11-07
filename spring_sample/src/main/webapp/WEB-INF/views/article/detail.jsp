<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<div class="card o-hidden border-0 shadow-lg my-5">
  <div class="card-body p-0">
      <!-- Nested Row within Card Body -->
        <div class="row">
            <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
            <div class="col-lg-7">
                <div class="p-5">
                <!-- DB에 변화가 있다면? post , DB에 변화가 없다면? get -->
                    <form name="frm" id="frm" method="post" class="user">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                            	<input type="hidden" name="articleNo" value="${data.articleNo}" />
                            	<input type="hidden" name="writerId" value="${data.writerId}" />
                                <input type="text" class="form-control form-control-user" 
                                	name="writerName" id="writerName" placeholder="작성자"
                                	value="${data.writerName}" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control form-control-user" 
                            		name="title" id="title" placeholder="제목" 
                            		value="${data.title}" required disabled="disabled" />
                        </div>
                        <div class="form-group">
                            <textarea class="form-control form-control-user" 
                            name="artContent" id="artContent" rows="7" cols="5">${data.artContent}</textarea>
                        </div>
                        <!-- 일반모드 시작 -->
                        <span id="spn1">
                        	<p>
		                        <button type="button" id="edit"  
		                        	class="btn btn-primary btn-user btn-block" 
		                        	style="width:50%;float:left;">수정</button>
                                <button type="button" id="delete"  
                                	class="btn btn-primary btn-user btn-block" 
                                	style="width:50%;">삭제</button>
	                        </p>
	                        <p>
		                        <a href="/article/list" class="btn btn-success btn-user btn-block">
		                            	목록
		                        </a>
	                        </p>
                        </span>
                        <!-- 일반모드 끝 -->
                        <!-- 수정모드 시작 -->
                        <span id="spn2" style="display:none;">
	                        <button type="submit" class="btn btn-primary btn-user btn-block">
	                            	확인
	                        </button>
	                        <a href="/article/detail?articleNo=${param.articleNo}" class="btn btn-success btn-user btn-block">
	                            	취소
	                        </a>
                        </span>
                        <!-- 수정모드 끝 -->
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
CKEDITOR.replace("artContent");

$(function(){
	$(".form-control-user").attr("disabled","disabled");
	//수정버튼 클릭 -> 수정모드로 전환
	$("#edit").on("click",function(){
		$("#spn1").css("display","none");
		$("#spn2").css("display","block");
		//입력란 활성화
		$(".form-control-user").removeAttr("disabled");
		CKEDITOR.instances['artContent'].setReadOnly(false);
		
		//폼의 action을 /article/updatePost
		//태그 style <.... style='' -> 객체.css("","")
		//태그 속성 <... action=''	   -> 객체.attr("","") / 객체.prop("","")
		$("#frm").attr("action","/article/updatePost");
	});
	
	//삭제버튼 클릭
	$("#delete").on("click",function(){
		$("#frm").attr("action","/article/deletePost");
		
		// true(1) / false(0)
		let result = confirm("삭제하시겠습니까?");
		
		console.log("result : " + result);
		
		if(result>0){
			$("#frm").submit();
		}else{
			alert("삭제가 취소되었습니다.");
		}
	});
});
</script>













