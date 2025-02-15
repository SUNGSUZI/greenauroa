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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
    <link href="/css/mypage_common.css" rel="stylesheet" />
    <link href="/css/mypage.css" rel="stylesheet" />

    <title>Green Aurora</title>
</head>

<body>
	<button id="showPopup">버튼</button>
    <div id="popupContainer" class="popup-container">
        <div class="popup">
            <h2>
                추가 요금 결제
                <label for="layerPopup" id="closePopup"></label>
            </h2>
            <div class="popup_content">
                <form action="#">
                    <div class="pay-method">
                        <div class="pay-method-text">결제수단</div>
                        <div class="pay-method-radio-btn">
                            <input type="radio" class="btn-check" name="options" id="option1" autocomplete="off" checked>
                            <label class="btn btn-secondary" for="option1">신용/체크카드</label>
                            <input type="radio" class="btn-check" name="options" id="option2" autocomplete="off">
                            <label class="btn btn-secondary" for="option2">휴대전화</label>
                            <input type="radio" class="btn-check" name="options" id="option3" autocomplete="off">
                            <label class="btn btn-secondary" for="option3">페이코</label>
                            <input type="radio" class="btn-check" name="options" id="option4" autocomplete="off">
                            <label class="btn btn-secondary" for="option4">카카오페이</label>
                            <input type="radio" class="btn-check" name="options" id="option5" autocomplete="off">
                            <label class="btn btn-secondary" for="option5">제로페이</label>
                        </div>
                    </div>

                    <div class="use-point">
                        <div class="use-point-text">포인트</div>
                        <div class="use-point-input">
                            <input type="text">
                            <div>사용가능한 포인트 : <span>200P</span></div>
                        </div>
                    </div>

                    <div class="pay-amount">
                        <div class="pay-amount-text">결제 금액</div>
                        <hr>
                        <div>
                            <div class="pay-add-amount">
                                <div class="pay-add-amount-text">초과금액</div>
                                <div class="pay-add-amount-val">10,000원</div>
                            </div>
                            <div class="pay-point">
                                <div class="pay-point-text">포인트</div>
                                <div class="pay-point-val" style="color: #DD5E60;">-200원</div>
                            </div>
                        </div>
                        <hr>
                        <div class="pay-total">
                            <div class="pay-total-text">총금액</div>
                            <div class="pay-total-val">9,800원</div>
                        </div>
                    </div>

                    <div class="agreement">
                        <div class="checkbox1">
                            <input type="checkbox" name="agreement1" value="agreement1">
                            <div>추가요금자동결제,환불규정, 이용약관에 동의하며 결제를 진행합니다.(이용권 사용안내)</div>
                        </div>
                        <div class="checkbox2">
                            <input type="checkbox" name="agreement2" value="agreement2">
                            <div>만 13세 미만의 미성년자가 서비스를 이용하는 경우, 사고 발생 시 보험 적용을 받을 수 없는 등의 불이익을 받으실 수 있습니다. (만 15세 미만의 경우 상법 제732조에 의거하여 사망 보험 적용 불가)</div>
                        </div>
                    </div>

                    <button type="submit" class="add-submit-btn btn--green-round">결제하기</button>
                </form>
            </div>
        </div>
    </div>
    <script>
        // 레이어 팝업 열기
        document.getElementById('showPopup').addEventListener('click', function () {
            document.getElementById('popupContainer').style.display = 'block';
        });
    
        // 레이어 팝업 닫기
        document.getElementById('closePopup').addEventListener('click', function () {
            document.getElementById('popupContainer').style.display = 'none';
        });
    </script>  
</body>
</html>