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
        <title>이벤트</title>
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
	            <div class="list_category">
	                <h2>이벤트</h2>
	            </div>
	            <div class="list_insert">
			        <a class="button" id="list_button" href="/event/eform">작성</a>
	            </div>
            </div>
            <div class="list_content list_event">
		        <!-- 이벤트 목록 테이블 -->
			    <c:forEach var="event" items="${eventList}">
			    <c:if test="${event.state != 'D'}">
			        <div class="event">
			        	<div class="event_content">
						    <a href="/event/edetail/${event.eventKey}">
						        <div class="event_thumb">
						            <img src="${event.eventThumb}" alt="이벤트 썸네일">
						        </div>
						        <div class="event_text">
						            <div class="event_title">${event.eventName}</div>
						            <div class="event_date">${event.createDt}</div>
						        </div>
						    </a>
			            </div>
			        </div>
			        </c:if>
			    </c:forEach>
            </div>
			<!-- 하단 페이지네이션 -->
			<div class="list_bottom">
		        <div class="pagination">
		            <button class="page-button" onclick="location.href='/event/elist?page=${currentPage - 1 < 0 ? 0 : currentPage - 1}'">
		                    &laquo;
		            </button>
		            <c:forEach begin="1" end="${totalPages}" var="i">
		                <button class="page-button ${currentPage == i - 1 ? 'active' : ''}" 
		                        onclick="location.href='/event/elist?page=${i - 1}'">${i}</button>
		            </c:forEach>
		            <button class="page-button" onclick="location.href='/event/elist?page=${currentPage + 1 >= totalPages ? totalPages - 1 : currentPage + 1}'">
		            	&raquo;
		            </button>
		        </div>
		    </div>
        </section> 
		<!-- 컨텐츠 작업 end -->
		
	</div>
    </body>
</html>