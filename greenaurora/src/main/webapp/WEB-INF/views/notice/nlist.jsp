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
       <section class="list">
	         <div class="list_top">
	            <div class="list_category">
	                <h2>공지사항</h2>
	            </div>
				<c:if test="${principal.authorities[0].authority == 'ROLE_ADMIN'}">
				    <div class="list_insert">
				        <a class="button" id="list_button" href="/notice/nform">작성</a>
				    </div>
				</c:if>
            </div>
		    <div class="list_content list_table">
		        <!-- Q&A 목록 테이블 -->
		        <table class="table_top">
		            <thead>
		                <tr>
		                    <th scope="col" class="notice_num">번호</th>
		                    <th scope="col" class="notice_title">제목</th>
		                    <th scope="col" class="notice_writer">작성자</th>
		                    <th scope="col" class="notice_date">작성일</th>
		                </tr>
		            </thead>
		            <tbody>
		                <!-- Notice 게시글 목록 -->
						<c:forEach items="${noticeList}" var="notice" varStatus="status">
						    <tr style="<c:choose>
						                <c:when test="${notice.secret == 'Y' && (principal == null || principal.authorities.isEmpty() || principal.authorities[0].authority != 'ROLE_ADMIN')}">
						                    display: none;
						                </c:when>
						                <c:otherwise>
						                    display: table-row;
						                </c:otherwise>
						              </c:choose>">
						        <th scope="row" class="notice_num">${status.count}</th>
						        <td class="notice_title">
						            <c:choose>
						                <c:when test="${notice.secret == 'Y' && principal.authorities[0].authority == 'ROLE_ADMIN'}">
						                    <a href="/notice/ndetail/${notice.boardKey}">${notice.title} <img class="list_lock" src="/images/icon8-lock.png"></a>
						                </c:when>
						                <c:when test="${notice.secret == 'Y' && (principal == null || principal.authorities.isEmpty() || principal.authorities[0].authority != 'ROLE_ADMIN')}">
						                    <span>${notice.title} <img class="list_lock" src="/images/icon8-lock.png"></span>
						                </c:when>
						                <c:otherwise>
						                    <a href="/notice/ndetail/${notice.boardKey}">${notice.title}</a>
						                </c:otherwise>
						            </c:choose>
						        </td>
						        <td class="notice_writer">${notice.memberId}</td>
						        <td class="notice_date">${notice.createDt}</td>
						    </tr>
						</c:forEach>
		            </tbody>
		        </table>
		    </div>
		    		        
		        <!-- 하단 페이지네이션 -->
		        <div class="list_bottom">
			        <div class="pagination">
			            <button class="page-button" onclick="location.href='/notice/nlist?page=${currentPage - 1 < 0 ? 0 : currentPage - 1}'">
			                    &laquo;
			            </button>
			            <c:forEach begin="1" end="${totalPages}" var="i">
			                <button class="page-button ${currentPage == i - 1 ? 'active' : ''}" 
			                        onclick="location.href='/notice/nlist?page=${i - 1}'">${i}</button>
			            </c:forEach>
			            <button class="page-button" onclick="location.href='/notice/nlist?page=${currentPage + 1 >= totalPages ? totalPages - 1 : currentPage + 1}'">
			            	&raquo;
			            </button>
			        </div>
		        </div>
		</section>
		<!-- 컨텐츠 작업 end -->
		
	</div>
    </body>
</html>