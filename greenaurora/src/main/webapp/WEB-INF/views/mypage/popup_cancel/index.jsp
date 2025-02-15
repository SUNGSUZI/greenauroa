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
    <div id="popupContainer1" class="popup-container">
        <div class="popup">
            <h2>
                예약취소
                <label for="layerPopup" id="closePopup"></label>
            </h2>
            <div class="popup_content">
                <form action="#">
                    <div class="cancel-reason">
                        <label for="cancel-reason-text">취소 사유</label>
                        <select class="form-select" aria-label="Default select example">
                            <option selected>시간 문제</option>
                            <option value="1">자전거 문제</option>
                            <option value="2">기타</option>
                          </select>
                    </div>
                    <div class="cancel-reason-input">
                        <label for="cancel-reason-input-text">직접 작성</label>
                        <input type="text">
                    </div>
                    <button type="submit" class="cancel-reason-btn btn--green-round">취소하기</button>
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