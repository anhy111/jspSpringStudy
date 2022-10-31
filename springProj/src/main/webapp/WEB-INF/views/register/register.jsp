<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>요청 처리</title>
</head>
<body>
<div class="card-body p-0">
    <!-- Nested Row within Card Body -->
    <div class="row">
        <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
        <div class="col-lg-7">
            <div class="p-5">
                <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                </div>
                <form class="user" action="/register/register03" method="post">
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user" id="exampleFirstName"
                            name="userId" placeholder="userId">
                    </div>
                    <div class="form-group row">
                        <input type="password" class="form-control form-control-user"
                            id="exampleInputPassword" name="password" placeholder="Password">
                    </div>
                    <div class="form-group row">
                        <input type="text" class="form-control form-control-user"
                            id="exampleInputPassword" name="coin" placeholder="coin">
                    </div>
                    <button type="submit" class="btn btn-primary btn-user btn-block">
                        Register Account
                    </button>
                    <hr>
                    <a href="/register/register03/a001/100" class="btn btn-google btn-user btn-block">
                        <i class="fab fa-google fa-fw"></i>Path Variable
                    </a>
                    <a href="index.html" class="btn btn-facebook btn-user btn-block">
                        <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                    </a>
                </form>
                <hr>
                <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                </div>
                <div class="text-center">
                    <a class="small" href="login.html">Already have an account? Login!</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>