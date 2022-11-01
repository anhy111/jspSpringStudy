<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
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
                <form class="user" action="/board/insert" method="post" enctype="multipart/form-data">
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user" id="memId"
                            name="memId" placeholder="userId">
                    </div>
                    <div class="form-group row">
                        <input type="password" class="form-control form-control-user"
                            id="memPass" name="memPass" placeholder="password">
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memName" name="memName" placeholder="name">
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memJob" name="memJob" placeholder="job">
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="memLike" name="memLike" placeholder="like">
                    </div>
					<div class="input-group mb-3">
					  <input type="file" name="memImage" class="form-control" multiple id="memImage">
					  <label class="input-group-text" for="memImage">Upload</label>
					</div>
                    <br>
                    <button type="submit" class="btn btn-primary btn-user btn-block">
                        Register
                    </button>
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