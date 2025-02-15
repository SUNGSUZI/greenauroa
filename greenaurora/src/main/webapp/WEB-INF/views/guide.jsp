<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
        <link href="../css/main2.css" rel="stylesheet" />
        <link href="../css/main.css" rel="stylesheet" />
        <title>이용안내</title>
    </head>
    <body>
    <!-- 전체 화면 -->
    <div class="main_public">
        <!-- 공통 부분 start -->
        <jsp:include page="/WEB-INF/views/head_board.jsp" />
		<!-- 공통 부분 end -->

        <!-- 컨텐츠 작업 start -->        
        <section class="list">
        	<div class="list_top">
	            <div class="list_name">
	                <h2>이용안내</h2>
	            </div>
            </div>
            <div class="guide">
                <iframe src="https://www.youtube.com/embed/G301vEQzV2Y?si=WKZe_2UcuqxOuImH" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
            </div>
        </section>
		<!-- 컨텐츠 작업 end -->
		
	</div>
    </body>
</html>