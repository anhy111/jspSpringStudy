<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<!-- 
	스프링 시큐리티 표현식
		- 인증 및 권한 정보에 따라 화면을 동적으로 구성할 수 있고, 로그인 한 사용자 정보를 보여줄 수 있음
		- hasRole([role]) : 해당 권한이 있으면 true 
		- hasAnyRole([role,role2]) : 여러 roles 중에서 하나라도 해당하는 role이 있으면 true( or적용)
		- principal : 인증된 사용자의 사용자 정보(UserDetails 인터페이스를 구현한 클래스의 객체)
										customUser의 memberVO 멤버변수
		- authentication : 인증된 사용자의 인증 정보
		- permitAll : 모든 사용자에게 허용
		- denyAll : 모든 사용자를 거부
		- isAnonumous() : 익명의 사용자의 경우(로그인 하지 않은 경우도 해당)
		- isAuthenticatied() : 인증된 사용자면 true
		- isFullyAuthenticated() : Remember-me(로그인 유지)로 인증된 것이 아닌
								일반적인 방법으로 인증된 사용자인 경우 true
		
 -->
<nav class="navbar navbar-expand navbar-dark bg-dark">
	<!-- 내용이 들어간다. -->
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="products">Home</a>
			<c:if test="<sec:authentication property='principal'/> eq 'anonymousUser'">
				<h1>어나니머스</h1>
			</c:if>
		</div>
		<div style="float:right;">
			<!-- 인증된 사용자인 경우.. 로그인 시에만 버튼 노출 -->
			<sec:authorize access="isAuthenticated()">
				<form action="/logout" method="post">
		        	<button type="submit" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">
		           		로그아웃
		        	</button>
					<sec:csrfInput/>
				</form>
	        	<button type="button" class="btn btn-primary" data-bs-toggle="modal" 
	        		data-bs-target="#exampleModal" data-bs-whatever="@mdo">나의 정보 보기</button>
        	</sec:authorize>
      	</div>
	</div>
</nav>

<!-- 버튼 클릭 시 Modal 창이 띄워짐
	- button의 data-bs-toggle 속성을 "modal"로 설정해야 함
	- data-bs-target 속성은 출력할 modal div객체의 id를 넣어줌
	- class="modal"이 div가 모달의 전체를 포함한 가장 큰 껍데기

-->

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
     <!-- modal-content 안에 모달을 구성할 내용이 들어감 -->
    <div class="modal-content">
      <!-- 1. Header -->
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">나의 정보</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <!-- 2. body -->

      <div class="modal-body">
        <form>
          <sec:authorize access="isAuthenticated()">
          <div class="bd-example">
             <div class="card" style="width: 100%;">
           <svg class="bd-placeholder-img card-img-top" width="100%" height="180" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Image cap" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#868e96"></rect><text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image cap</text></svg>
         
           <div class="card-body">
             <h5 class="card-title"><sec:authentication property="principal.memberVO.memName"/></h5>
           </div>
           <ul class="list-group list-group-flush">
             <li class="list-group-item">
                 <label for="exampleFormControlInput1" class="form-label">아이디</label>
                 <input type="text" class="form-control" id="memId" value="<sec:authentication property='principal.memberVO.memId'/>">
             </li>
             <li class="list-group-item">
                  <label for="exampleFormControlInput1" class="form-label">생일</label>
                 <input type="text" class="form-control" id="memBir" value="<sec:authentication property='principal.memberVO.memBir'/>">
             </li>
             <li class="list-group-item">
                  <label for="exampleFormControlInput1" class="form-label">주소</label>
                 <input type="text" class="form-control" id="memAddr" value="<sec:authentication property='principal.memberVO.memName'/>">
             </li>
             <li class="list-group-item">
                  <label for="exampleFormControlInput1" class="form-label">휴대폰번호</label>
                 <input type="text" class="form-control" id="memHp" value="<sec:authentication property='principal.memberVO.memHp'/>">
             </li>
             <li class="list-group-item">
                  <label for="exampleFormControlInput1" class="form-label">메일주소</label>
                 <input type="text" class="form-control" id="memMail" value="<sec:authentication property='principal.memberVO.memMail'/>">
             </li>
            </ul>
            </div>
          </div>
          </sec:authorize>
        </form>
      </div>
      <!-- 3. footer(생략 가능) 
         data-bs-dismiss="modal" => 닫기 기능이 적용됨
      -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>