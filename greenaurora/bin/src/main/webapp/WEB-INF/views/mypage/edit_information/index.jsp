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
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
<link href="/css/mypage_common.css" rel="stylesheet" />
<link href="/css/edit_information.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>Green Aurora</title>
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
					<div class="text">회원정보 수정</div>
					<div class="password-box">
						<form action="/svc/user/mypage/edit_information/${dto.memberId}"
							method="post">
							<div class="mb-3 row">
								<label for="inputPassword" class="col-sm-2 col-form-label">아이디</label>
								<div class="col-sm-10">
									<input name="memberId" class="form-control" readonly="readonly"
										value="${dto.memberId}">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
								<div class="col-sm-10">
									<a href="/svc/user/mypage/change_password/${dto.memberId}"
										class="btn">비밀번호 변경</a>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="inputPassword" class="col-sm-2 col-form-label">이메일</label>
								<div class="col-sm-10">
									<input name="memberEmail" class="form-control"
										value="${dto.memberEmail}" type="email">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="inputPassword" class="col-sm-2 col-form-label">휴대폰번호</label>
								<div class="col-sm-10">
									<input name="memberPhone" class="form-control"
										value="${dto.memberPhone}">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="inputPassword" class="col-sm-2 col-form-label">주소</label>
								<div class="col-sm-10">
									<input name="memberAddress" class="form-control"
										value="${dto.memberAddress}">
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
	</section>
</body>
</html>