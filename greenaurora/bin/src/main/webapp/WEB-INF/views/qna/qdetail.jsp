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
        <title>문의하기</title>
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
	                <h2>문의사항</h2>
	            </div>
				<div class="detail_title">
			        ${qna.title}
			    </div>
				<div class="detail_date">
		            ${qna.createDt}
		        </div>
		    </div>           
		    
            <div class="detail_bottom">
            	<div class="detail_contents">
            		<div class="detail_content_img"><img src="${qna.filePath}" alt="문의사항 첨부파일"></div>
            		<div class="detail_content">${qna.contents}</div>
            	</div>
	            <div class="detail_button">
			        <c:if test="${principal.name == qna.memberId}">
		                <a class="button_a button_dark" id="delete" href="/qna/qdelete/${qna.boardKey}">
		                    삭제
		                </a>
		                <a class="button_a button_dark" href="/qna/qupdate/${qna.boardKey}">
		                    수정
		                </a>
			        </c:if>
	                <a class="button" href="/qna/qlist">
	                    목록
	                </a>
	            </div>
	        </div>
        </section>
		<!-- 컨텐츠 작업 end -->        
    </div>
    
    </body>
</html>
