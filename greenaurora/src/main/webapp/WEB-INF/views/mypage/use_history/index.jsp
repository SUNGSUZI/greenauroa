<%@page import="kr.co.greenaurora.entity.RentalEntity"%>
<%@page import="org.springframework.data.domain.Page"%>
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
    <link href="/css/use_history.css" rel="stylesheet" />
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
					<div class="text">따릉이 사용내역</div>
					<div class="box">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">자전거</th>
									<th scope="col">대여일시</th>
									<th scope="col">대여소</th>
									<th scope="col">반납일시</th>
									<th scope="col">반납대여소</th>
									<th scope="col">과금</th>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach items="${list}" var="rental" varStatus="status">
									<tr>
										<th scope="row">${status.count}</th>
										<td>${rental.bicycleNumber != null ? rental.bicycleNumber : "-"}</td>
										<td>${rental.rentalDate != null ? rental.rentalDate : "-"}</td>
										<td>${rental.stationNumber != null ? rental.stationNumber : "-"}</td>
										<td>${rental.returnDate != null ? rental.returnDate : "-"}</td>
										<td>${rental.returnStationNumber != null ? rental.returnStationNumber : "-"}</td>
										<td>${rental.rentalCharge != null ? rental.rentalCharge : "-"}</td>
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
		</section>
	</section>
</body>
</html>