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
        <link href="/css/main2.css" rel="stylesheet" />
        <link href="/css/main.css" rel="stylesheet" />
        <title>공지사항</title>
    </head>
    <body>
    <!-- 전체 화면 -->
    <div class="main_public">
        <!-- 공통 부분 start -->
        <jsp:include page="/WEB-INF/views/head_board.jsp" />
		<!-- 공통 부분 end -->

		<!-- 컨텐츠 작업 start -->
        <section class="detail">
	        <div class="detail_top">
	            <div class="detail_category">
	                <h2>공지사항</h2>
	            </div>
				<div class="detail_title">
			        ${notice.title}
			    </div>
				<div class="detail_date">
		            ${notice.createDt}
		        </div>
		    </div>           
		    
            <div class="detail_bottom">
            	<div class="detail_contents">
            		<div class="detail_content_img"><img src="${notice.filePath}" alt="공지사항 첨부파일"></div>
            		<div class="detail_content">${notice.contents}</div>
            	</div>
	            <div class="detail_button">
			        <c:if test="${principal.name == notice.memberId}">
			            <a class="button_a button_dark" id="delete" href="/notice/ndelete/${notice.boardKey}">
			            	삭제
			            </a>
			            <a class="button_a button_dark" href="/notice/nupdate/${notice.boardKey}">
			            	수정
			            </a>
			        </c:if>
	                <a class="button" href="/notice/nlist">
	                    목록
	                </a>
	            </div>
	        </div>
        </section>
		<!-- 컨텐츠 작업 end -->
		
	</div>
    </body>
</html>