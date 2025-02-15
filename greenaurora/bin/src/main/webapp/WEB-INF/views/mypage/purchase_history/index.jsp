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
    <link href="/css/mypage_common.css" rel="stylesheet" />
    <link href="/css/purchase_history.css" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
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
					<div class="text">결제내역</div>
					<div class="box">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">구분</th>
									<th scope="col">결제일시</th>
									<th scope="col">결제금액</th>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach items="${list}" var="purchase" varStatus="status">
									<tr>
										<th scope="row">${status.count}</th>
										<td id="purchaseDivision">
											<c:choose>
												<c:when test="${purchase.purchaseDivision == 'B'}">과금</c:when>
												<c:when test="${purchase.purchaseDivision == '1H'}">일일 1시간권 사용</c:when>
												<c:when test="${purchase.purchaseDivision == '2H'}">일일 2시간권 사용</c:when>
												<c:when test="${purchase.purchaseDivision == '1HP'}">일일 1시간권 구매</c:when>
												<c:when test="${purchase.purchaseDivision == '2HP'}">일일 2시간권 구매</c:when>
												<c:otherwise>알 수 없음</c:otherwise>
											</c:choose>
										</td>
										<td>${purchase.payDate}</td>
										<td>${purchase.amount}원</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- 페이징 영역 -->
						<div class="table_bottom">
							<div class="pagination">
								<!-- Handle case when there are no pages -->
								<c:choose>
									<c:when test="${page.totalPages > 0}">
										<button class="page-button" onclick="location.href='?page=0'">&laquo;</button>
										<c:forEach begin="0" end="${page.totalPages - 1}" var="i">
											<button
												class="page-button ${page.number == i ? 'active' : ''}"
												onclick="location.href='?page=${i}'">${i + 1}</button>
										</c:forEach>
										<button class="page-button"
											onclick="location.href='?page=${page.totalPages - 1}'">&raquo;</button>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</section>
</body>
</html>