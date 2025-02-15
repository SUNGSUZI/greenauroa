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
    <title>Sign Up - Green Aurora</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/signup.css">
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
            <div class="signup-container">
                <h2 class="join-title">JOIN</h2>
                <div class="progress-bar">
                    <div class="progress-dot active"></div>
                    <div class="progress-line"></div>
                    <div class="progress-dot"></div>
                    <div class="progress-line"></div>
                    <div class="progress-dot"></div>
                </div>


                <div class="signup-header">
                    <h2>회원가입 안내</h2>
                    <p class="signup-description">
                        Green Aurora 서비스 이용을 위해 회원가입을 해주세요.<br>
                        가입 후 다양한 서비스를 이용하실 수 있습니다.
                    </p>
                </div>

                <div class="signup-notice">

                    <ul class="notice-list">
                        <li>Green Aurora 서울자전거 만 18세이상 이신분만 회원가입이 가능합니다.</li>
                        <li>만 13세는 보호자(부모, 법정대리인) 본인인증을 통하여 회원가입이 가능하므로, 반드시 보호자 휴대폰에서 진행하여 주시기 바랍니다.</li>
                        <li>위의 사항에 동의할 결우우만 아래의 가입하기 버튼을 눌러 진행하여 주기 바랍니다.</li>
                    </ul>
                </div>

                <div class="terms-section">

                    <div class="terms-list">
                        <div class="terms-item">
                            <input type="checkbox" id="service">
                            <label for="service">(필수) 서비스 이용약관 동의 (상세내용 보기)</label>
                        </div>
                        <div class="terms-item">
                            <input type="checkbox" id="privacy">
                            <label for="privacy">(필수) 개인정보 수집 · 이용 동의 (상세내용 보기)</label>
                        </div>
                        <div class="terms-item">
                            <input type="checkbox" id="marketing">
                            <label for="marketing">(필수) 위치기반서비스 이용약관에 동의 (상세내용 보기)</label>
                        </div>
                        <div class="terms-item">
                            <input type="checkbox" id="location">
                            <label for="location">(선택) 수집한 개인정보의 제3자 정보제공 동의 (상세내용 보기)</label>
                        </div>
                    </div>
                    <div class="terms-agree">
                        <input type="checkbox" id="allAgree">
                        <label for="allAgree">위 약관을 모두 읽었으며 이에 동의합니다.</label>
                    </div>
                </div>

                <a href="/signup2" class="next-btn">다음</a>


                <div class="return-login">
                    <a href="/index" class="return-link">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        </div>
    </div>



    <script src="js/signup.js"></script>
</body>

</html>