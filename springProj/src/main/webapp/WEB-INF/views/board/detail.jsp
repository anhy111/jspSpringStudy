<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>상세 정보</title>
<style type="text/css">
	.imgs_wrap{
		width: 300px;
		margin-top: 50px;
	}
	
	.imgs_wrap img{
		max-width: 100%;
	}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

</head>
<body>
<div class="card-body p-0">
    <!-- Nested Row within Card Body -->
    <div class="row">
        <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
        <div class="col-lg-7">
            <div class="p-5">
                <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Create an Member!</h1>
                </div>
                <form id="frm" class="user" action="/board/insert" method="post" enctype="multipart/form-data">
                    <div class="form-group row">
                    	<label class="form-label">memId</label>
                        <input type="text" class="form-control form-control-user" id="memId"
                            name="memId" placeholder="userId" value="${memVO.memId}" readonly>
                    </div>
                    <div class="form-group row">
                    	<label class="form-label">memPass</label>
                        <input type="password" class="form-control form-control-user"
                            id="memPass" name="memPass" placeholder="password" value="${memVO.memPass}" readonly>
                    </div>
                    <div class="form-group row">
	                    <label class="form-label">memName</label>
                        <input type="text" class="form-control form-control-user"
                            id="memName" name="memName" placeholder="name" value="${memVO.memName}" readonly>
                    </div>
                    <div class="form-group row">
    	                <label class="form-label">memJob</label>
                        <input type="text" class="form-control form-control-user"
                            id="memJob" name="memJob" placeholder="job" value="${memVO.memJob}" readonly>
                    </div>
                    <div class="form-group row">
	                    <label class="form-label">memLike</label>
                        <input type="text" class="form-control form-control-user"
                            id="memLike" name="memLike" placeholder="like" value="${memVO.memLike}" readonly>
                    </div>
                    <div class="form-group row">
                    	<label class="form-label">memHp</label>
                        <input type="text" class="form-control form-control-user"
                            id="memHp" name="memHp" placeholder="Hp" value="${memVO.memHp}" readonly>
                    </div>
					<div class="mb-3">
						<label class="form-label">증명사진</label>
						<div class="imgs_wrap">
							<c:forEach var="attachVO" items="${attachVOList}">
							 	<img src="/resources/upload${attachVO.attachName}"><br><br>
						 	</c:forEach>
					 	</div>
					</div>
					<div class="input-group row imgs_wrap"></div>
                    <br>
                    <button id="btn" type="submit" class="btn btn-primary btn-user btn-block" disabled>
                        	등록
                    </button>
                    <a href="/board/list" class="btn btn-secondary btn-user btn-block">
                        	목록
                    </a>
                </form>
                <hr>
                <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>