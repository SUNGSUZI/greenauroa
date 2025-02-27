<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<sec:authorize access="isAuthenticated( )">
   <sec:authentication property="principal" var="principal"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link href="../css/main.css" rel="stylesheet" />
    <link href="../css/main_content.css" rel="stylesheet" />
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
      <!-- 전체 화면 -->
    <div class="main_public">
        <!-- 공통 부분 start -->
        <jsp:include page="/WEB-INF/views/head_board.jsp" />
		<!-- 공통 부분 end -->

            <!-- 메인 컨텐츠 작업 start-->
            <section class="coupon_main_content">
                <h3>이용권 구매</h3>
                <form name="payForm">
                    <div class="payment">
                        <h4>이용권 구분</h4>
                        <div class="coupon_type form-label2">
                            <label for="1hour">
                                <input type="radio" id="1hour" name="couponType" value="1HP" data-amount = "1000"/>
                                <span>일일권 1시간</span>
                            </label>
                            <label for="2hour">
                                <input type="radio" id="2hour" name="couponType" value="2HP" data-amount = "2000"/>
                                <span>일일권 2시간</span>
                            </label>
                        </div>

                       <h4>결제수단</h4>
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
                        
                        <h4>포인트</h4>
                        <div class="point">
                            <input type="text" name="use_point" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                            <span>사용가능한 포인트 :</span><span > ${usePoint}</span> 
                        </div>
                    </div>
                    <div class="total_pay">
                        
                    </div>
                    <ul class="terms">
                        <li>
                            <input type="checkbox" name="" id="terms1">
                            <label for="terms1">(필수) 서비스 이용약관 동의 (상세내용 보기)추가요금자동결제,환불규정, 이용약관에 동의하며 결제를 진행합니다.(이용권 사용안내)</label>
                        </li>
                        <li>
                            <input type="checkbox" name="" id="terms2">
                            <label for="terms2">만 13세 미만의 미성년자가 서비스를 이용하는 경우, 사고 발생 시 보험 적용을 받을 수 없는 등의 불이익을 받으실 수 있습니다. (만 15세 미만의 경우 상법 제732조에 의거하여 사망 보험 적용 불가)</label>
                        </li>
                    </ul>
                    
                    <input class="payBtn btn3" type="button" value="결제하기">
                </form>

            </section>

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
                    
                    <p class="modal_main_txt">이용권 구매가 완료되었습니다.</p>
                    <p>결제완료되었습니다.</p>
                    
                    <div class="horizontal-line"></div>

                    <div>
                        <p class="alert_msg">최초 대여 시각부터 24시간 동안 사용 가능합니다</p>
                        <p>마이페이지 > 구매내역에서 구매한 이용권을 확인 할 수 있습니다.</p>
                    </div>
                    <div class="btn2" onclick="location.href='/main'">메인페이지 이동</div>
                </div>
            </div>
        </div>
    </div>
    <script>


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
        	var couponCheck = $("input[name='couponType']").is(":checked");

        	if(checkel1&&checkel2&&couponCheck){
        		requestPayment();
        	}else if(couponCheck){
       			alert("약관동의에 체크해주세요.");	
        		
        	}else{
        		alert("구매하실 이용권을 선택해주세요.");	
        	}
        	
        })
        
        // 이용권 구분
        $("input[name='couponType']").on("click" , function() {
        	calculation();
        	
        });
        
        
        // 포인트
        $("input[name='use_point']").on("blur" , function() {
        	var point = Number($("input[name ='use_point']").val())||0;
        	if(point){
        		alert("사용가능한 포인트를 초과하셨습니다.");	
        		$("input[name ='use_point']").val(0);
        	}
        	calculation();
        	
        });
        
        // 계산
        function calculation(){
        	var productAmount = 0
        	if($("input[name='couponType']").is(":checked")){
        		productAmount = Number($("input[name='couponType']:checked").data().amount); // 제품가격;
        	}
        	var point = Number($("input[name ='use_point']").val())||0;
        	var totalAmount = productAmount - point;
        	
        	if($("input[name='couponType']").is(":checked")){
        		console.log()
        		$(".total_pay").html("<p><span>이용권</span><span>"+productAmount+"</span></p>");
        	}
        	if(point!==0){
        		$(".total_pay").append("<p><span>포인트</span><span>"+point+"</span></p>");
        	}
        	if($("input[name='couponType']").is(":checked") || point!==0){
        		$(".total_pay").append('<p class="total_money"><span>총 금액</span><span>'+totalAmount+'</span></p>');
        	}else{
        		$(".total_pay").html('<p class="total_money"><span>총 금액</span><span>'+totalAmount+'</span></p>');
        	}
        }
        
        
        
        
        // 결제하기fn
	 	function requestPayment(pg) {
	        IMP.init("imp53025480");  // Iamport 키로 초기화
	
	        var productName = $("input[name='couponType']:checked+span").text(); // 제품명
	        var productVal = $("input[name='couponType']:checked").val(); // 결제내역구분
	        var productAmount = Number($("input[name='couponType']:checked").data().amount); // 제품가격;
	        var point = Number($("input[name ='use_point']").val())||0;
	        var totalAmount = productAmount - point; // 최종 결제 금액
	        
	        
	        var payType= $("input[name='pay_type']:checked").val(); // 결제타입
	        
	        console.log(productName);
	        console.log("_",totalAmount);
	        console.log("_typeof",typeof(totalAmount));
	        console.log("PG사:",payType)
			totalAmount = totalAmount.toString();
	        console.log("_typeof2",typeof(totalAmount));
	        /* "kakaopay" */
            IMP.request_pay({
                pg: payType,  // 카카오페이 PG사 설정
                pay_method: 'card',  // 결제 방식
                merchant_uid: "order_" + new Date().getTime(),  // 주문 고유번호
                name: productName,  
                amount: totalAmount,
            }, function(response) {
                if (response.success) {                	
                	// 결제내역
                	purchaseInsert(payType, productVal, totalAmount, point)
                	
                	
                	
                } else {
                    alert("결제 실패: " + response.error_msg);
                }
            }); 
        
       
    	}
        
        function purchaseInsert(payType, productVal, totalAmount, point){
        	console.log("dddddddd")
        	$.ajax({
        		url:"/coupon/purchase/insert",
        		method:"post",
        		contentType: "application/json", // JSON 데이터임을 명시
        		dataType:"json",
        		data:JSON.stringify({
        			payType:payType,
        			amount: totalAmount,
        			purchaseDivision: productVal, /* 구분 */
        			point:{
        				pointDecrease : point
        			}
        			
        			}),
        		success:function(data){
        			if(data){
        				alert_modal.css("display","flex");
        			}
        		},error:function(data){
        			
        		}
        	})
        }
        
       calculation();
       $(document).ready(function() {
            $("form[name='payForm']").on('keydown', function(event) {
                if (event.keyCode === 13) {  // Enter key
                    event.preventDefault();  // Enter로 인한 자동 제출 방지
                }
            });
        });
    </script>
</body>
</html>