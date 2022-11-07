<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<div class="card o-hidden border-0 shadow-lg my-5">
  <div class="card-body p-0">
      <!-- Nested Row within Card Body -->
        <div class="row">
            <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
            <div class="col-lg-7">
                <div class="p-5">
                <!-- DB에 변화가 있다면? post , DB에 변화가 없다면? get -->
                    <form:form method="post" modelAttribute="articleVO" 
                    	action="/article/writePost">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                            	<form:hidden path="writerId" />
                                <form:input class="form-control form-control-user" 
                                	path="writerName" placeholder="작성자" />
                                	<font color="red">
                                	<!-- BindingResult brResult에 들어있는 오류 중에
                                	writerName과 관련된 오류메시지를 출력해줌 -->
                                		<form:errors path="writerName" />
                                	</font>
                            </div>
                        </div>
                        <div class="form-group">
                            <form:input class="form-control form-control-user" 
                            		path="title" placeholder="제목" />
                            <font color="red">
                            	<form:errors path="title" />
                            </font>
                        </div>
                        <div class="form-group">
                            <form:textarea path="artContent" />
                        </div>
                        <button type="submit" class="btn btn-primary btn-user btn-block">
                            	입력
                        </button>
                        <a href="/article/list" class="btn btn-success btn-user btn-block">
                            	목록
                        </a>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
CKEDITOR.replace("artContent");
</script>