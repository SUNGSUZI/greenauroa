<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
          <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        <%--    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  --%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Complete - Green Aurora</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/signup3.css">
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="language-selector">
                <a href="#" class="lang-btn">ENGLISH</a>
                <a href="#" class="lang-btn">中文</a>
                <a href="#" class="lang-btn">한국어</a>
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

        <div class="right-panel signup-panel">
            <div class="signup-container">
                <h2 class="join-title">JOIN</h2>

                <div class="progress-container">
                    <div class="progress-bar">
                        <div class="progress-dot completed"></div>
                        <div class="progress-line completed"></div>
                        <div class="progress-dot completed"></div>
                        <div class="progress-line completed"></div>
                        <div class="progress-dot active"></div>
                    </div>
                </div>

                <div class="completion-message">
                    <h3>회원가입이 완료되었습니다!</h3>
                    <p>Green Aurora의 회원이 되신 것을 환영합니다.</p>
                    <p>로그인 후 다양한 서비스를 이용하실 수 있습니다.</p>
                </div>

                <div class="button-group">
                    <a href="/index" class="login-btn">로그인 하러가기</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
