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
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Find ID/Password - Green Aurora</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/find.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>    
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

        <div class="right-panel">
            <div class="form-container">
                <!-- ID find section -->
                <div class="find-section">
                    <h2><strong>아이디 찾기</strong></h2>
                    <form class="find-form" id="findIdForm">
                        <div class="form-group">
                            <label><strong>주민번호 *</strong></label>
                            <div class="resident-number-container">
                                <input type="text" class="form-input resident-number" maxlength="6" placeholder="앞 6자리">
                                <span class="resident-divider">-</span>
                                <input type="password" class="form-input resident-number" maxlength="7"
                                    placeholder="뒤 7자리">
                            </div>
                        </div>
                        <div class="form-group">
                            <label><strong>이름</strong></label>
                            <input type="text" name="memberName" class="form-input" placeholder="이름 입력" required>
                        </div>
                        <p class="info-text" id="idResult"><strong>* ID는 1234 입니다. *</strong></p>
                        <button type="submit" class="submit-btn">아이디 찾기</button>
                    </form>
                </div>

                <!-- Pwd find section -->
                <div class="find-section">
                    <h2><strong>비밀번호 찾기</strong></h2>
                    <form class="find-form" id="findPwdForm">
                        <div class="form-group">
                            <label><strong>아이디</strong></label>
                            <input type="text" class="form-input" placeholder="아이디 입력" required>
                        </div>
                        <div class="form-group">
                            <label><strong>이름</strong></label>
                            <input type="text" name="name" class="form-input" placeholder="이름 입력" required>
                        </div>
                        <p class="info-text" id="pwdResult"><strong>* 비밀번호는 1234 입니다. *</strong></p>
                        <button type="submit" class="reset-btn">비밀 번호 찾기</button>
                    </form>
                </div>


                <div class="back-to-login">
                    <a href="/index">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        </div>
        <script src="js/find.js"></script>
</body>

</html>