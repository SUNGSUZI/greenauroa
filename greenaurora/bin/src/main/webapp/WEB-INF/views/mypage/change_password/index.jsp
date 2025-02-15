<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
    <link href="/css/mypage_common.css" rel="stylesheet" />
    <link href="/css/change_password.css" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
    <title>Green Aurora</title>
    <script>
        window.onload = function () {
            // JSP에서 전달된 message와 error 값을 가져와서 alert 처리
            let message = "<%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>";
            let error = "<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>";

            if (message.trim() !== "") {
                alert(message);  // 성공 메시지 출력
            }
            if (error.trim() !== "") {
                alert(error);  // 오류 메시지 출력
            }
        };
    </script>
</head>

<body>
<!-- 헤더영역 시작 -->
<jsp:include page="/WEB-INF/views/mypage/mypage_head.jsp" />
<!-- 헤더영역 시작 -->
    <section class="content">
        <!-- nav-inner -->
        <jsp:include page="/WEB-INF/views/mypage/mypage_nav.jsp" />

        <!-- top-inner -->
        <section>
            <div class="content-inner">
                <div class="bottom-content">
                    <div class="text">비밀번호 변경</div>
                    <div class="password-box">
                        <form action="/svc/user/mypage/change_password/${dto.memberId}" method="post">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        	
                            <div class="mb-3 row">
                                <label for="oldPassword" class="col-sm-2 col-form-label">기존 비밀번호</label>
                                <div class="col-sm-10">
                                    <input name="oldPassword" type="password" class="form-control" placeholder="기존 비밀번호 입력" required>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="newPassword" class="col-sm-2 col-form-label">새 비밀번호</label>
                                <div class="col-sm-10">
                                    <input name="newPassword" type="password" class="form-control" placeholder="새 비밀번호 입력" required>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="confirmPassword" class="col-sm-2 col-form-label">새 비밀번호 확인</label>
                                <div class="col-sm-10">
                                    <input name="confirmPassword" type="password" class="form-control" placeholder="새 비밀번호 입력" required>
                                </div>
                            </div>

                            <div class="member-btn">
                                <a href="/svc/user/mypage/${dto.memberId}" class="btn">취소</a>
                                <button type="submit" class="btn--green">수정</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
</body>
</html>