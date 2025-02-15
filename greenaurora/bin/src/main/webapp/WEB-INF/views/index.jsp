<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
          <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Green Aurora</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="language-selector">
                <a href="?lang=en" class="lang-btn">ENGLISH</a>
                <a href="?lang=ch" class="lang-btn">中文</a>
                <a href="?lang=ko" class="lang-btn">한국어</a>
            </div>
            <div class="brand">
                <div class="title-container">
                    <h1>
                        Green
                        <img src="images/bicycle-icon.png" class="bike-icon" alt="bicycle">
                        <div class="divider-container">
                            <div class="divider-long"></div>
                            <div class="short-lines">
                                <div class="divider-short"></div>
                                <div class="divider-short"></div>
                            </div>
                        </div>
                        <br>
                        <span>Aurora</span>
                    </h1>
                    <p class="slogan">Experience the magic of Seoul</p>
                </div>
            </div>
            
            
            
        </div>
        <div class="right-panel index-panel">
            <h2>SIGN UP</h2>
            <c:if test="${param.error != null}">
                <div class="error-message" style="color: red;">
                    <spring:message code="login.error.invalid"/>
                </div>
            </c:if>
            <div id="debug-info" style="color: blue;"></div>
            <form class="login-form" action="/auth/login" method="post" onsubmit="console.log('Form submitting to:', this.action);">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="text" name="memberId" placeholder="<spring:message code='common.login'/>" required>
                <input type="password" name="memberPass" placeholder="<spring:message code='signup.password'/>" required>
                <div class="signup-btn">
                    <a href="/signup" class="signup-main"><spring:message code="signup.main"/></a>
                    <a href="/find" class="signup-sub"><spring:message code="signup.sub"/></a>
                </div>
                <button type="submit" class="login-btn">Login</button>
            </form>
            <div class="sns-login">
                <p>SNS</p>
                <div class="sns-buttons">
                    <button class="sns-btn naver" onclick="window.location.href='/oauth2/authorization/naver'"></button>
                    <button class="sns-btn kakao" onclick="window.location.href='/oauth2/authorization/kakao'"></button>
                    <button class="sns-btn google" onclick="window.location.href='/oauth2/authorization/google'"></button>
                    <!-- <button class="sns-btn wechat" onclick="window.location.href='/oauth2/authorization/wechat'"></button> -->
                </div>
            </div>
        </div>
    </div>
    <script src="js/index.js"></script>
</body>
</html>
