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
    <title>Sign Up Step 2 - Green Aurora</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:wght@600&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup2.css">
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
                        <img src="/images/bicycle-icon.png" class="bike-icon" alt="bicycle">
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
                
                <p class="required-text"><span class="required-mark">*</span> 표시는 필수 입력 항목입니다.</p>

                <div class="progress-container">
                    <div class="progress-bar">
                        <div class="progress-dot completed"></div>
                        <div class="progress-line completed"></div>
                        <div class="progress-dot active"></div>
                        <div class="progress-line"></div>
                        <div class="progress-dot"></div>
                    </div>
                </div>

                <form class="signup-form" action="/svc/user/insert"  method="post" modelAttribute="memberForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <div class="form-group">
                        <label>아이디 *</label>
                        <div class="input-with-button">
                            <input type="text" placeholder="아이디 입력" name="memberId" required>
                            <button type="button" class="check-btn">중복확인</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>비밀번호 *</label>
                        <input type="password" placeholder="비밀번호 입력" name="memberPass" required>
                    </div>

                    <div class="form-group">
                        <label>비밀번호 확인 *</label>
                        <input type="password" placeholder="비밀번호 확인" name="memberPass2" required>
                        <span id="password-error" class="error-message"></span>
                    </div>

                    <div class="form-group">
                        <label>이름 *</label>
                        <input type="text" placeholder="이름 입력" name="memberName" required>
                    </div>

                    <div class="form-group">
                         <label>휴대폰번호 *</label>
                         <div class="phone-input-container">
                         <input type="text" id="phone1" maxlength="3">
                         <span class="divider">-</span>
                         <input type="text" id="phone2" maxlength="4">
                         <span class="divider">-</span>
                         <input type="text" id="phone3" maxlength="4">
                         <input type="hidden" name="memberPhone" id="memberPhone">
                         </div>
                    </div>


                    <div class="form-group">
                         <label>주민번호 *</label>
                         <div class="resident-number-container">
                              <input type="text" id="residentNumber1" maxlength="6">
                              <span class="divider">-</span>
                              <input type="password" id="residentNumber2" maxlength="7">
                              <input type="hidden" name="memberNumber" id="memberNumber">
                         </div>
                     </div>


                    <div class="form-group">
                        <label>이메일 *</label>
                        <input type="email" placeholder="이메일 입력" name="memberEmail" required>
                    </div>

                    <div class="form-group">
                         <label>주소 *</label>
                         <input type="text" name="zipCode" placeholder="우편번호" class="address-input">
                         <textarea name="memberAddress" placeholder="상세주소" class="address-detail"></textarea>
                    </div>


                   <div class="button-group">
                        <button type="button" class="prev-btn" onclick="location.href='/signup'">이전</button>
                        <button type="submit" class="next-btn">다음</button>
                   </div>

                </form>

                <div class="return-login">
                    <a href="/index" class="return-link">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        </div>
    </div>
    
   

    <script src="js/signup2.js">    
   
    </script>
    
   
</body>

</html> 