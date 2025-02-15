<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
          <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
           <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
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
        <title>head_board</title>
    </head>
    <body>    
        <!-- 메뉴 -->
        <div class="right_menu">
            <a href="/main" style="text-decoration: none;"><h2>Green Aurora</h2></a>
            <span class="greet">${principal.name}님 어서오세요.</span>
            <div class="menu_list">
                <ul>
                    <li>
                       <a href="/coupon/buy">
                           <div>
                               <img class="none_hover" src="/images/v39_377.png"> 
                               <img src="/images/icons8-coupon.png"> 
                               <span>이용권구매</span>
                           </div>
                        </a> 
                    </li>
                    <!--  -->
                    <li>
                       <a href="/qna/qlist">
                           <div>
                               <img class="none_hover" src="/images/icons8-문의_green.png"> 
                               <img src="/images/v39_371.png">
                               <span>문의하기</span>
                           </div>
                        </a>
                    </li>
                    <li>
                       <a href="/guide">
                           <div>
                               <img class="none_hover" src="/images/icon-이용안내_green.png"> 
                               <img src="/images/v39_372.png"> 
                               <span>이용안내</span>
                           </div>
                        </a>
                    </li> 
                </ul>
                <ul>
                    <li onclick="location.href='/event/elist'">이벤트 ></li>
                    <li onclick="location.href='/notice/nlist'"> 공지사항 ></li>
                    <li onclick="location.href='/event/elist'"> FAQ ></li>
                    <li onclick="location.href='/svc/user/mypage/${principal.username}'"> 마이페이지 ></li>
                </ul>
            </div>
            
            <div class="logout" id="logoutBtn">
               <a href="/auth/logout" onclick="confirmLogout(event)" style="text-decoration: none; position: relative; display: flex; align-items: center;">
                   <img src="/images/v39_379.png"> 
                   <span style="color:#ffff; bottom: 0px; left: 0px; position: relative;">로그아웃</span>
                </a>
            </div>
            <!-- 실제 로그아웃 처리를 위한 폼 -->
                <form id="logoutForm" action="${pageContext.request.contextPath}/auth/logout" method="get" style="display:none;">
             </form>
            

        </div>

        <!-- 왼쪽 컨텐츠 -->
        <div class="left_menu">
            <!-- 왼쪽 상단(시간, qr, 알림) -->
            <div class="header_funs">
                <div>
                	<div id="reserv-ok">
                		<span>예약 취소까지 : <span id="reservationTime"></span></span>
                	</div>
                	<div id="rental-ok">
                		<span>대여 남은시간 : <span id="remainingTime"></span></span>
                	</div>
                    <!-- 예약을 한 경우 -->
                    <!-- <span>예약 취소까지 : 00:20:00</span> -->
                    <!-- 대여를 한 경우 -->
               		<!-- <span>대여 남은시간 : <span id="remainingTime"></span></span> -->
                </div>
                
                <img onClick ="qrModal()" id="qrScan" class="icon_style1" src="/images/icons8-qr.png">
                <img style="width: 40px; height: 40px; font-size:14px; cursor: pointer;" src="/images/icons8-alarm.png" onClick="notificationModal()">
                <div class="alarm_bg" style="display:none"></div>
            </div>       
		</div>
		
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
	
    <script src="/js/head_board.js"></script>
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

       
       /* 렌탈 시 남은시간 호출 */
      function fetchRemainingTime() {
          $.ajax({
         url : "/rental/remainingtime",
         method : "GET",
         dataType : "json",
         success : function(response) {
            $("#remainingTime").text(response.remainingTime);
         }
         });
      }
      $(document).ready(function() {
      fetchRemainingTime();
      setInterval(fetchRemainingTime, 60000);
      });
       
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
       
       
		//reservation/rental TIME
        $.ajax({
        	url: "/reserv/select",
        	method: "GET",
			dataType: "json",
			success: function(response){
				if (!response.hasReservation && !response.hasRental) {
					// 예약 정보가 있을 경우
		            $("#rental-ok").hide();
		            $("#reserv-ok").hide();
		        } else if(response.hasReservation) {
		        	// 예약 정보가 있을 경우
		            $("#rental-ok").hide();
		            $("#reserv-ok").show();
		        } else if(response.hasRental) {
		        	//대여 이력이 있을 경우
		        	$("#rental-ok").show();
		            $("#reserv-ok").hide();
		        }
			}
        });
       
      //예약 취소까지 시간 계산
		function fetchReservTime() {
		    $.ajax({
			url : "/reserv/reservTime",
			method : "GET",
			dataType : "json",
			success : function(response) {
	            $("#reservationTime").text(response.reservTime);
	         }
	         });
	      }
			$(document).ready(function() {
			fetchReservTime();
			setInterval(fetchReservTime, 1000);
		});
			
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