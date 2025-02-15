<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  --%>

<%-- <sec:authorize access="isAuthenticated( )">
   <sec:authentication property="principal" var="principal"/>
</sec:authorize> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<c:choose>
	<c:when test="${not empty dto}">
		<form action ="/bicycle/return" method="post">
			<input type="hidden" name = "rentalKey" value="${dto.rentalKey}">
			<input type="text" name = "bicycleNumber" value ="${dto.bicycleNumber}">
			<input type="text" name = "stationNumber" value ="${dto.stationNumber}">
			<input type="text" name = "returnStationNumber" value ="${dto.returnStationNumber}">
			<input type="submit" value="저장">
		</form>
	</c:when>
	<c:otherwise>
		<div>대여한 자전거가 없습니다.</div>
	</c:otherwise>
</c:choose>
</body>
</html>