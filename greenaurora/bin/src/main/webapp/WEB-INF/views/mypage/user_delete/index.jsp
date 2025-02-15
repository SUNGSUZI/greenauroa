<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
    <link href="/css/mypage_common.css" rel="stylesheet" />
    <link href="/css/user_delete.css" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <title>Green Aurora</title>
    <script>
        window.onload = function() {
            var message = "${message}";
            if (message) {
                alert(message);
            }

            var error = "${error}";
            if (error) {
                alert(error);
            }
        }
    </script>
</head>

<body>
<!-- 헤더영역 시작 -->
<jsp:include page="/WEB-INF/views/mypage/mypage_head.jsp" />
<!-- 헤더영역 시작 -->
    <section class="content">
        <!-- nav-inner -->
        <jsp:include page="/WEB-INF/views/mypage/mypage_nav.jsp" />

        <!-- top-inner -->
        <section>
            <div class="content-inner">
                <div class="bottom-content">
                    <div class="text">회원탈퇴</div>
                    <div class="delete-box">
                        <div class="delete-text1">회원탈퇴를 진행합니다.</div>
                        <div class="delete-text2">
                            <span>Green Aurora</span>를 이용해 주셔서 감사합니다.<br>
                            회원탈퇴를 하실 경우 아래와 같이 회원정보가 처리됩니다.
                        </div>
                        <div class="delete-text3">
                            탈퇴 신청 즉시 회원탈퇴 처리되며, 해당 아이디의 회원정보 및 마일리지는 삭제처리되며, 복원할 수 없습니다.<br>
                            회원탈퇴 이후 같은 아이디로는 재가입이 불가능 합니다.<br>
                            이용권 기간이 남아있는 경우 즉시 탈퇴가 불가능 하오니 고객센터에 문의 바랍니다.
                        </div>
                        <div class="delete-text4">
                            <label for="deleteReason">탈퇴사유</label>
                            <select class="form-select" aria-label="Default select example">
                                <option selected>탈퇴사유</option>
                                <option value="1">서비스 불만족</option>
                                <option value="2">요금정책 불만</option>
                                <option value="3">기타</option>
                                <option value="3">개인정보</option>
                              </select>
                        </div>
                        <div class="delete-btn">
                            <a href="/svc/user/mypage/user_delete/delete/${dto.memberId}" class="btn--black" id="user_delete_real_password">회원탈퇴</a>
                            <a href="/svc/user/mypage/${dto.memberId}" class="btn">취소</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>


<script>
    $("#user_delete_real_password").click(function(event){
        event.preventDefault();

        // JSP에서 principal 값을 가져와서 JavaScript 변수에 할당
        let memberId = "${dto.memberId}"; 
        let password = prompt("비밀번호를 입력하세요.");

        // 아이디와 비밀번호 유효성 검사
        if (!memberId || memberId.trim() === "") {
            alert("회원 ID가 존재하지 않습니다. 다시 로그인해 주세요.");
            return;
        }

        if (!password) {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        // AJAX 요청
        $.ajax({
            url: "/svc/user/mypage/user_delete/delete",
            type: "POST",
            dataType: "text",
            data: {
                memberId: memberId,  // principal에서 가져온 값 전달
                memberPass: password,
                _csrf: '${_csrf.token}'  // CSRF 토큰도 함께 전송
            },
            success: function(response) {
                alert(response);
                if (response.includes("완료")) {
                    window.location.href = '/';
                }
            },
            error: function(xhr) {
                alert("오류 발생: " + xhr.responseText);
            }
        });
    });
</script>



</body>

</html>