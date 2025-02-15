<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
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
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
	<link href="/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
<title>mypage_head</title>
</head>
<body>
	<header>
		<div class="inner">
			<!-- logo -->
			<a href="/main" class="logo"> <img src="/images/logo.png"
				alt="logo">
			</a>

			<!-- sub-menu -->
			<div class="sub-menu">
				<ul class="menu">
					<li>
						<div class="qr">
							<a href="#"> <img src="/images/v39_280.png" alt="qr" onClick ="qrModal()" id="qrScan" class="icon_style1">
							</a>
						</div>
					</li>
					<li>
						<div class="alarm">
							<a href="#">
								<div class="alarm_bg" style="display:none"></div>
								<img src="/images/v39_274.png" alt="alarm" onClick="notificationModal()">
							</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</header>
	<div id="notification-modal-backdrop" style="display:none;">
	    <div id="notification-modal">
	        <div class="modal_head">
	            <h3>알림</h3>
	            <img class="close_btn icon_style1" src="/images/icon8-close.png" onClick="closeNotificationModal()">
	        </div>
	        <div class="modal_body">
	            <div class="alert_modal_content"> 
	               <table class="table_top">
		            <thead>
		                <tr>
		                    <th scope="col" class="num">순번</th>
		                    <th scope="col" class="state">상태</th>
		                    <th scope="col" class="title">제목</th>
		                    <th scope="col" class="writer">작성자</th>
		                    <th scope="col" class="create_date">생성일</th>
		                </tr>
		            </thead>
		            <tbody>
		            </tbody>
		        </table>
		        
		        <!-- 하단 페이지네이션 -->
		        <div class="table_bottom">
		            <div class="pagination">
		            </div>
		        </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- qr 모달 -->
	<div id="qrScan-modal-backdrop" style="display:none;">
		 <div id="qrScan-modal">
			 <div class="modal_head">
		         <h3>QR 조회</h3>
		         <img class="close_btn icon_style1" src="/images/icon8-close.png" onClick="closeQRModal()">
		     </div>
		     <div class="modal_body">
		     	<video id="video" width="100%" height="200px" style="border: 1px solid #ccc;"></video>
		     </div>
		 </div>
	</div>
	
	<!-- 알림 상세페이지 -->
	<div id="notification-detail-modal-backdrop" style="display:none;">
	    <div id="notification-detail-modal">
	        <div class="modal_head">
	            <h3>알림 상세</h3>
	            <img class="close_btn icon_style1" src="/images/icon8-close.png" onClick="closeNotificationDetailModal()">
	        </div>
	        <div class="modal_body">
	            <table>
	            	<tr height="50">
	            		<th>제목</th>
	            		<td class="title"></td>
	            	</tr>
	            	<tr height="50">
	            		<th>작성자</th>
	            		<td class="sender"></td>
	            	</tr>
	            	<tr height="50">
	            		<th>생성일</th>
	            		<td class="createDt"></td>
	            	</tr>
	            	<tr>
	            		<th>내용</th>
	            		<td colspan ="3" class="content"></td>
	            	</tr>
	            </table>
	        </div>
	    </div>
	</div>
	
    <script src="/js/mypage.js"></script>
    <script>
       
       var eventSource;
       /* 알람 모달창 fn start */
       function notificationModal(){
          // 모달과 배경 표시
            const modal = document.getElementById("notification-modal");
            const backdrop = document.getElementById("notification-modal-backdrop");
   
            modal.style.display = "block";
            backdrop.style.display = "block";
            setNotifiList(1)
           
       }
       // sse 방식으로 서버에 알람값 요청
       function setNotifiList(page){
          if (eventSource) {
               eventSource.close();  // 이전 EventSource 연결 종료
               console.log("이전 SSE 연결 종료");
           }
          
          eventSource = new EventSource("/notifi/list/"+page);
          
          var modal_body = $(".alert_modal_content tbody");
            var modal_pagination = $(".alert_modal_content .pagination");
            
          var data;
           eventSource.onmessage = (event) => {
               data = JSON.parse(event.data); // 서버에서 보낸 데이터를 JSON으로 파싱
               

               // 데이터 처리 로직 (UI 업데이트)
               modal_body.html(makeListTag(data, page));
               modal_pagination.html(pageSetting(page, data)); 
               
           };

           eventSource.onerror = (error) => {
               console.error("sse 오류발생:", error);
               eventSource.close(); // SSE 연결 종료
               setTimeout(() => setNotifiList(page), 5000); // 5초 후 재연결
           };
           
           
            
       }
       // 알림 리스트 조회
       function closeNotificationModal() {
         // 모달과 배경 숨기기
         const modal = document.getElementById("notification-modal");
         const backdrop = document.getElementById("notification-modal-backdrop");

         modal.style.display = "none";
         backdrop.style.display = "none";
         if (eventSource) {
            eventSource.close(); // 연결 종료
            console.log("sse 강제 종료")
         } 
       }
       
       // 상세페이지
       function detailPage(key){
           $.ajax({
                url:"/notifi/detail",
                method:"post",
                data:{notiKey:key},
                dataType:"json",
                success:function(data){
                   
                   // 데이터 처리 로직 (UI 업데이트)
                    const modal = document.getElementById("notification-detail-modal");
                      const backdrop = document.getElementById("notification-detail-modal-backdrop");
                 
                       modal.style.display = "block";
                      backdrop.style.display = "block";
                       const titleElement = modal.getElementsByClassName("title")[0]
                     const senderElement = modal.getElementsByClassName("sender")[0]
                     const createDtElement = modal.getElementsByClassName("createDt")[0]
                     const contentElement = modal.getElementsByClassName("content")[0]
                     
                     if (titleElement) titleElement.innerText = data.title;
                      if (senderElement) senderElement.innerText = data.sender;
                     if (createDtElement) createDtElement.innerText = data.createDt;
                     if (contentElement) contentElement.innerText = data.content;
                },error:function(){
                   alert("상세보기가 불가합니다.")   
                }
               })
       }
       /* 알람 모달창 fn end */
       
       /* 새로운 알림 조회 */
       function newNotiFind(){
          const eventSource2 = new EventSource("/notifi/new/Cnt");
          eventSource2.onmessage = (event) => {
                  const data = JSON.parse(event.data); // 서버에서 보낸 데이터를 JSON으로 파싱
                  if(data.count&&data.count>0){
                     $(".alarm_bg").css("display","flex");
                     $(".alarm_bg").text(data.count);
                  }else{
                     $(".alarm_bg").css("display","none")
                  }
                  /* ;
                  */
         };
         
         eventSource2.onerror = (error) => {
               console.error("sse 오류발생:", error);
               eventSource.close(); // SSE 연결 종료
               setTimeout(() => setNotifiList(page), 5000); // 5초 후 재연결
           };

       }
       newNotiFind();

       
       
       /* qr Scan */
       // 모달 열기
       function qrModal(){
          // 모달과 배경 표시
            const modal = document.getElementById("qrScan-modal");
            const backdrop = document.getElementById("qrScan-modal-backdrop");
   
            modal.style.display = "block";
            backdrop.style.display = "block";
            QRScan()
           
       }
       
       // 모달 닫기
       function closeQRModal(){
          // 모달과 배경 표시
            const modal = document.getElementById("qrScan-modal");
            const backdrop = document.getElementById("qrScan-modal-backdrop");
   
            modal.style.display = "none";
            backdrop.style.display = "none";
            
            clearInterval(scanner);
       }
       
       // 대여
       function QRScan(){
          const video = document.getElementById('video');
           const resultElement = document.getElementById('result');

           // 비디오 스트림 설정
           navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } })
             .then(function (stream) {
               video.srcObject = stream;
               video.setAttribute("playsinline", true); // iOS 사용시 전체 화면을 사용하지 않음
               video.play();

               // QR 코드 스캔을 위한 캡처와 분석
               let scanner = setInterval(function () {
                 let canvas = document.createElement("canvas");
                 canvas.width = video.videoWidth;
                 canvas.height = video.videoHeight;
                 
                 let context = canvas.getContext("2d");
                 context.drawImage(video, 0, 0, canvas.width, canvas.height);

                 // 이미지 데이터를 가져와 QR 코드 분석
                 const imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                 
                 
                 const qrCode = jsQR(imageData.data, canvas.width, canvas.height);

                 if (qrCode) {
                  console.log("qr url:", qrCode.data)
                  handleQRCodeData(qrCode.data)
                   clearInterval(scanner); // QR 코드가 인식되면 스캔을 멈춤
                 }
               }, 200); // 100ms마다 프레임을 캡처하여 QR 코드 분석
             })
             .catch(function (error) {
               console.error("카메라 접근 실패:", error);
               alert("카메라 권한을 허용해야 합니다.");
             });
          
       
       }
       
       function handleQRCodeData(data) {
          const serverUrl = data;
          $.ajax({
               type: "GET",
               url: serverUrl,
               data: {},
               success: function (response) {
                  alert(response)
               },
             });
          
        }
       //newNotiFind();
       
       
		
			
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