<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal"/>
</sec:authorize>


<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
        <title>mypage_nav</title>
    </head>
    <body>
    	<!-- nav-inner -->
        <nav>
            <div class="nav-inner">
                <div class="nav-container">
                    <div class="mypage"><a href="/svc/user/mypage/${principal.username}">MY PAGE</a></div>
                    <div class="welcome"><strong class="name">${principal.name}</strong>님 어서오세요.</div>
                    <ul class="nav-menu">
                        <div class="point-line">
                            <img src="/images/Line 31.png" alt="point-line">
                        </div>
                        <li class="menu1">

                            <a href="/svc/user/mypage/${dto.memberId}">내정보</a>
                        </li>
                        <li>
                            <a href="/svc/user/mypage/purchase_history/${dto.memberId}">결제내역</a>
                        </li>
                        <li>
                            <a href="/svc/user/mypage/use_history/${dto.memberId}">따릉이 사용내역</a>
                        </li>
                        <li> 
                            <a href="/qna/qlist/${dto.memberId}">나의문의</a>
                        </li>
                        <li>
                            <a href="/auth/logout" onclick="confirmLogout(event)">로그아웃</a>
                        </li>
                    </ul>
                </div>
                <!-- 실제 로그아웃 처리를 위한 폼 -->
                <form id="logoutForm" action="${pageContext.request.contextPath}/auth/logout" method="get" style="display:none;">
    			</form> 
            </div>
        </nav>
        
        <script type="text/javascript">
   	 	//로그아웃 알럿
    	 function confirmLogout(event) {
               event.preventDefault();
               if (confirm("정말 로그아웃 하시겠습니까?")) {
                   document.getElementById("logoutForm").submit();
                   window.location.href = '/';
               }
           } 
        </script>
    </body>
</html>
