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
		<section class="list">
			<div class="list_top">
			    <div class="list_name">
			        <h2>문의하기</h2>
			    </div>
		        <div class="list_insert">
				    <a class="button" id="list_button" href="/qna/qform">작성</a>
		        </div>
		    </div>    
		    <div class="list_content list_table">
		        <!-- Q&A 목록 테이블 -->
		        <table class="table_top">
		            <thead>
		                <tr>
		                    <th scope="col" class="qna_num">번호</th>
		                    <th scope="col" class="qna_title">문의사항</th>
		                    <th scope="col" class="qna_content">제목</th>
		                    <th scope="col" class="qna_date">작성일</th>
		                </tr>
		            </thead>
		            <tbody>
		                <!-- Qna 게시글 목록 -->
		                <c:forEach items="${qnaList}" var="qna" varStatus="status">
		                    <tr>
		                        <th scope="row" class="qna_num">${status.count}</th>
		                        <td class="qna_title">${qna.sub}</td>
		                        <td class="qna_content">
		                            <c:choose>
		                                <c:when test="${qna.secret == 'Y' && qna.memberId == principal.name}">
		                                    <a href="/qna/qdetail/${qna.boardKey}">${qna.title}</a>
		                                </c:when>
		                                <c:when test="${qna.secret == 'Y' && qna.memberId != principal.name}">
		                                    <span>비공개 게시글입니다.</span>
		                                </c:when>
		                                <c:otherwise>
		                                    <a href="/qna/qdetail/${qna.boardKey}">${qna.title}</a>
		                                </c:otherwise>
		                            </c:choose>
		                        </td>
		                        <td class="qna_date">${qna.createDt}</td>
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		        
		        <!-- 하단 페이지네이션 -->
		        <div class="pagination">
		            <button class="page-button" onclick="location.href='/qna/qlist?page=${currentPage - 1 < 0 ? 0 : currentPage - 1}'">
		                    &laquo;
		            </button>
		            <c:forEach begin="1" end="${totalPages}" var="i">
		                <button class="page-button ${currentPage == i - 1 ? 'active' : ''}" 
		                        onclick="location.href='/qna/qlist?page=${i - 1}'">${i}</button>
		            </c:forEach>
		            <button class="page-button" onclick="location.href='/qna/qlist?page=${currentPage + 1 >= totalPages ? totalPages - 1 : currentPage + 1}'">
		            	&raquo;
		            </button>
		        </div>
		    </div>
		</section>
		<!-- 컨텐츠 작업 end -->	
	</div>
    </body>
</html>
