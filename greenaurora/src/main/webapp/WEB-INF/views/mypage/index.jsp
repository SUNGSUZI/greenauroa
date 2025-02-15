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
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
    <link href="/css/mypage_common.css" rel="stylesheet" />
    <link href="/css/mypage.css" rel="stylesheet" />
    <link href="/css/main.css" rel="stylesheet" />  
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lx8zzw2u2g&submodules=geocoder"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
   
    <title>Green Aurora</title>
    
        
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
				<div class="top-content">
					<!-- 포인트 영역 -->
					<div class="point-area">
						<div class="text">포인트</div>
						<div class="top-box">
							<div class="icon-area">
								<div class="icon"></div>
							</div>
							<div class="text-area">
								<div class="point-list">
									<!-- <a href="#">포인트 내역보기</a> -->
								</div>
								<div class="current-point">
									현재 포인트 : <strong class="result-point"></strong><strong>P</strong>
								</div>
							</div>
						</div>
					</div>
					<!-- 예약/대여 영역 -->
					<div class="reserve">
						<div class="text">예약 / 대여</div>
						<div class="top-box" id="reservationArea">

							<!-- 대여/예약 따릉이 없는경우 -->
							<div class="reserv_default">
								<div class="icon-area">
									<div class="time-remain">
										<div style="font-weight: 700; text-align: center">
											<a href="/main">예약/대여<br> 이동하기
											</a>
										</div>
									</div>
								</div>
								<div class="text-area-rental-false">
									<div class="bicycle-text">
										<div class="bicycle-number">예약 / 대여한 따릉이가 없습니다.</div>
									</div>
								</div>
							</div>

							<!-- 대여정보가 있는 경우 -->
							<div class="rental_true">
								<div class="icon-area">
									<div class="time-remain">
										<div>
											남은 시간<br>
											<div id="remainingTime"></div>
										</div>
									</div>
								</div>
								<div class="text-area-rental-true">
									<div class="popup-content">
										<div class="add-charge" style="display: none;">
											<a href="#" id="showPopup">추가요금 결제</a>
										</div>
									</div>
									<div class="bicycle-text">
										<div class="bicycle-number">
											따릉이 번호 : <span>${response.bicycleNumber}</span>
										</div>
										<div class="over-time-show" style="display: none;">
											시간 초과 : <span id="rentalDuration">00:00</span>
										</div>
										<div class="over-time">● 기본 대여시간 초과 시 추가 요금 (5분 당 200원)</div>
									</div>
								</div>
							</div>
							<!-- 예약내역이 있는 경우 -->
							<div class="reserv_ok">
								<div class="icon-area">
									<div class="reservation">
										<div>
											예약 취소까지<br>
											<div id="cancelTime"></div>
										</div>
									</div>
								</div>
								<div class="text-area-reservation">
									<div class="add-charge">
										<a href="#" id="showPopup1">예약 취소</a>
									</div>
									<div class="bicycle-text">
										<div class="bicycle-number">
											따릉이 번호 : <span>${response.bicycleNumber}</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<hr>
			<!-- 회원 정보 영역 -->
			<div class="bottom-content">
				<div class="text">회원 정보</div>
				<div class="member-box">
					<div class="id">아이디 : ${dto.memberId}</div>
					<div class="password">
						비밀번호 : <a href="/svc/user/mypage/change_password/${dto.memberId}"
							class="btn">비밀번호 변경</a>
					</div>
					<div class="email">이메일 : ${dto.memberEmail}</div>
					<div class="phone">휴대폰번호 : ${dto.memberPhone}</div>
					<div class="addresssss">주소 : ${dto.memberAddress}</div>
					<div class="member-btn">
						<a href="/svc/user/mypage/user_delete/${dto.memberId}" class="btn">회원
							탈퇴</a> <a href="/svc/user/mypage/edit_information/${dto.memberId}"
							class="btn--black">회원 정보 수정</a>
					</div>

				</div>
			</div>
		</section>
	</section>
	<!-- 추가요금 결제 선택 시 노출 팝업 -->
	<div id="popupContainer" class="popup-container">
		<div class="popup">
			<h2>
				추가 요금 결제 <label for="layerPopup" id="closePopup"></label>
			</h2>
			<div class="popup_content">
				<form name="payForm">
					<div class="pay-method">
						<div class="pay-method-text">결제수단</div>
						<div class="pay_type form-label2">
                        	<label for="danal">
                                <input type="radio" id="danal" name="pay_type" value="danal"/>
                                <span>다날</span>
                            </label>
                            <label for="payco">
                                <input type="radio" id="payco" name="pay_type" value="payco"/>
                                <span>페이코</span>
                            </label>
                            <label for="kakao">
                                <input type="radio" id="kakao" name="pay_type" value="kakaopay"/>
                                <span>카카오페이</span>
                            </label>
                           <!--  <label for="toss">
                                <input type="radio" id="toss" name="pay_type" value="tosspayments"/>
                                <span>토스페이</span>
                            </label> -->
                        </div>
					</div>

					<div class="use-point">
						<div class="use-point-text">포인트</div>
						<div class="point">
							<input type="text" name="use_point"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="height: 40px">
							<div>
								사용가능한 포인트 : <span>${usePoint}</span>
							</div>
						</div>
					</div>
					

					<div class="pay-amount">
						<div class="pay-amount-text">결제 금액</div>
						<hr>
						<div>
							<div class="pay-add-amount">
								<div class="pay-add-amount-text">초과금액</div>
								<div class="pay-add-amount-val" id="pay-amount">0 원</div>
							</div>
							<div class="pay-point">
								<div class="pay-point-text">포인트</div>
								<div class="pay-point-val" style="color: #DD5E60;">- 0 원</div>
							</div>
						</div>
						<hr>
						<div class="pay-total">
							<div class="pay-total-text">총금액</div>
							<div class="pay-total-val" id="pay-amount-total">0 원</div>
						</div>
					</div>

					<div class="agreement">
						<div class="checkbox1">
							<input type="checkbox" name="agreement1" value="terms1" id="terms1">
							<div>추가요금자동결제,환불규정, 이용약관에 동의하며 결제를 진행합니다.(이용권 사용안내)</div>
						</div>
						<div class="checkbox2">
							<input type="checkbox" name="agreement2" value="terms2" id="terms2">
							<div>만 13세 미만의 미성년자가 서비스를 이용하는 경우, 사고 발생 시 보험 적용을 받을 수 없는
								등의 불이익을 받으실 수 있습니다. (만 15세 미만의 경우 상법 제732조에 의거하여 사망 보험 적용 불가)</div>
						</div>
					</div>
					<button type="button" class="payBtn btn--green-round" style="left: 0; right: 0; margin: auto;">결제하기</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 예약취소 버튼 선택 시 노출 팝업 -->
	<div id="popupContainer1" class="popup-container">
		<div class="popup">
			<h2>
				예약취소 <label for="layerPopup" id="closePopup1"></label>
			</h2>
			<div class="popup_content">
				<form action="#">
					<div class="cancel-reason">
						<label for="cancel-reason-text">취소 사유</label> <select
							class="form-select" aria-label="Default select example">
							<option selected>시간 문제</option>
							<option value="1">자전거 문제</option>
							<option value="2">기타</option>
						</select>
					</div>
					<div class="cancel-reason-input">
						<label for="cancel-reason-input-text">직접 작성</label> <input
							type="text">
					</div>
					<a href="/reserv/delete" class=",-btn btn--green-round">취소하기</a>
				</form>
			</div>
		</div>
	</div>

	<!-- alert 모달창 -->
	<div class="alert_modal_back">
		<div class="alert_modal">
			<div class="modal_head">
				<h3 id="alert-modeal-head">결제완료</h3>
				<img class="close_btn icon_style1" src="/images/icon8-close.png">
			</div>
			<div class="modal_body">
				<div class="alert_modal_content">

					<p class="modal_main_txt">과금 추가 결제가 완료되었습니다.</p>
					<p>결제완료되었습니다.</p>

					<div class="horizontal-line"></div>

					<div>
						<p>마이페이지 > 구매내역에서 과금 결제 내역을 확인 할 수 있습니다.</p>
					</div>
					<div class="btn2" onclick="location.href='/main'">메인페이지 이동</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	
		//point
		$.ajax({
			url : "/point/select",
			method : "POST",
			dataType : "json",
			success : function(result) {
				$(".result-point").text(result.result);
			}
		});
        
        //예약대여
        $.ajax({
        	url: "/reserv/select",
        	method: "GET",
			dataType: "json",
			success: function(response){
				if (response.hasReservation) {
					// 예약 정보가 있을 경우
		            $(".reserv_default").hide();
		            $(".reserv_ok").show();
		            $(".rental_true").hide();
		            // 예약 정보 세부 사항 업데이트
		            $(".bicycle-number span").text(response.reservation.bicycleNumber);
		            $(".reservation .time-remain div").text(response.reservation.timeRemaining);
		            // 추가적으로 필요한 다른 데이터들 예: 예약 취소 시간, 대여 정보 등
		    	  	document.getElementById('showPopup1').addEventListener('click', function () {
		    	    	document.getElementById('popupContainer1').style.display = 'block';
		    		});
		    		
		    		document.getElementById('closePopup1').addEventListener('click', function () {
		    	    	document.getElementById('popupContainer1').style.display = 'none';
		    		});
		          
		        } else if(response.hasRental) {
		        	//대여 이력이 있을 경우
		        	$(".reserv_default").hide();
		            $(".reserv_ok").hide();
		            $(".rental_true").show();
		         
		            $(".bicycle-number span").text(response.bicycleNumber);
		    		//추가 결제 팝업
		    	 	document.getElementById('showPopup').addEventListener('click', function () {
		    	    	document.getElementById('popupContainer').style.display = 'block';
		    		}); 

		    		document.getElementById('closePopup').addEventListener('click', function () {
		    	    	document.getElementById('popupContainer').style.display = 'none';
		    		});
		        } else {
		        	// 예약/대여한 따릉이가 없을 때
		            $(".reserv_default").show();
		            $(".reserv_ok").hide();
		            $(".rental_true").hide();
		        }
			}
        });
        
        
		//렌탈 시 남은시간 호출
		function fetchRemainingTime() {
		    $.ajax({
			url : "/rental/remainingtime",
			method : "GET",
			dataType : "json",
			success : function(response) {
				$("#remainingTime").text(response.remainingTime);
				$("#rentalDuration").text(response.rentalDuration);
				
				let minutes = parseInt(response.rentalDuration.split(":")[1], 10);
				let result = (minutes % 5 === 0) ? (minutes / 5) * 200 : 0;
				$("#pay-amount").text(result+" 원");
				$("#pay-amount-total").text(result+" 원");
				
				
				const rentalCharge = parseInt(response.rentalCharge, 10);
				// 과금이 0보다 클 경우 추가 요금 결제 링크 노출
	            if (rentalCharge > 0) {
	                $(".add-charge").show();
	                $(".over-time-show").show();
	            } else {
	                $(".add-charge").hide();
	                $(".over-time-show").hide();
	            }
			},
			error: function() {
	            console.error("Error fetching rental time");
	        }
			});
		}
		$(document).ready(function() {
		fetchRemainingTime();
		setInterval(fetchRemainingTime, 60000);
		});
		
		
		//예약 취소까지 시간 계산
		function fetchReservTime() {
		    $.ajax({
			url : "/reserv/reservTime",
			method : "GET",
			dataType : "json",
			success : function(response) {
				 if (response.status == "expired") {
		                alert("예약시간을 초과하여 자동 취소되었습니다.");
		                window.location.href = response.redirectUrl;
		            }  else if (response.status == "no_reservation") {
		                /* console.log("No active reservations."); */
		            } else {
		                $("#cancelTime").text(response.reservTime);
		            }
				}
			});
		}
		$(document).ready(function() {
			fetchReservTime();
			setInterval(fetchReservTime, 1000);
		});
		
		
		// 결제완료시 - 알림 모달
	    const alert_modal = $(".alert_modal_back");
		
        // 알림 모달 닫기
        const btnCloseAlertModal = document.querySelector(".alert_modal_back .close_btn");
        btnCloseAlertModal.addEventListener("click",()=>{
            alert_modal.css("display","none");
        })
		
		// 결제하기
        $(".payBtn").click(function(event){
        	// 
        	var checkel1 = $("#terms1").is(':checked');
        	var checkel2 = $("#terms2").is(':checked');

        	if(checkel1&&checkel2){
        		requestPayment();
        	}else{
        		alert("약관동의에 체크해 주세요.");	
        	}
        	
        })
        
        
        
        // 포인트
        $("input[name='use_point']").on("blur" , function() {
        	var point = Number($("input[name ='use_point']").val())||0;
        	if(point){
        		alert("사용가능한 포인트를 초과하셨습니다.");	
        		$("input[name ='use_point']").val(0);
        	}
        	calculation();
        	
        });
        

        // 결제하기fn
	 	function requestPayment(pg) {
    IMP.init("imp53025480");  // Iamport 키로 초기화

    var productVal = 'B'; // 결제내역구분
    
    // 제품 가격을 가져오는 부분 수정
    var productAmount = Number($("#pay-amount-total").text().replace("원", "").trim()); // 제품가격
    var point = Number($("input[name ='use_point']").val()) || 0;
    var totalAmount = productAmount - point; // 최종 결제 금액

    var payType = $("input[name='pay_type']:checked").val(); // 결제타입
    
    console.log(productVal);
    console.log("_", totalAmount);
    console.log("_typeof", typeof(totalAmount));
    console.log("PG사:", payType);

    totalAmount = totalAmount.toString();
    console.log("_typeof2", typeof(totalAmount));

    // "kakaopay"
    IMP.request_pay({
        pg: payType,  // PG사 설정
        pay_method: 'card',  // 결제 방식
        merchant_uid: "order_" + new Date().getTime(),  // 주문 고유번호
        name: productVal,  // 결제 내역 구분
        amount: totalAmount,
    }, function(response) {
        if (response.success) {
            // 결제내역
            purchaseInsert(payType, productVal, totalAmount, point);
        } else {
            alert("결제 실패: " + response.error_msg);
        }
    });
}

function purchaseInsert(payType, productVal, totalAmount, point) {
    console.log("dddddddd");
    $.ajax({
        url: "/coupon/purchase/insert",
        method: "POST",
        contentType: "application/json", // JSON 데이터임을 명시
        dataType: "json",
        data: JSON.stringify({
            payType: payType,
            amount: totalAmount,
            purchaseDivision: productVal, /* 구분 */
            point: {
                pointDecrease: point
            }
        }),
        success: function(data) {
            if (data) {
                alert_modal.css("display", "flex");
            }
        },
        error: function(data) {
            console.error("결제 처리 중 오류 발생", data);
        }
    });
}
        
       /* calculation();
       $(document).ready(function() {
            $("form[name='payForm']").on('keydown', function(event) {
                if (event.keyCode === 13) {  // Enter key
                    event.preventDefault();  // Enter로 인한 자동 제출 방지
                }
            });
        }); */
       
       
       
	</script>

</body>
</html> 