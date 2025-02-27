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
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ncpClientId&submodules=geocoder"></script>

</head>
<body>

    <!-- 전체 화면 -->
    <div class="main_public">
        <!-- 공통 부분 start -->
        <jsp:include page="/WEB-INF/views/head_board.jsp" />
		<!-- 공통 부분 end -->



            <!-- 메인 컨텐츠 작업 start-->
            <section class="content_section">
            <!-- 컨텐츠 좌측 : map -->
            <div class="map_area" style="width:70%; height: 100%;">
                <div id="map">
                    <!-- 검색기능 -->
                    <div class="search_area">
                        <div class="search_bar">
                            <input type="text" id="searchInput">
                            <img id="searchImg" src="/images/icons8-수색-48.png">
                        </div>
                        <div class="location"> 
							<img class="location_img"  src="/images/icons8-위치-50.png" alt="Bookmark" >
                            현재위치
                        </div>                     
                    </div>

                    <!-- 예약 기능-->
                    <div class="rev">
                        <div class="station_info" style="display:none">
                            <!-- 대여소 정보 -->
                            <div>
                                <p>
                                	<span class="rev_station_number"></span>
                                    <span class="rev_station_name" ></span>
                                    <img class="bookmark_img" src="/images/icons8-별-50.png">
                                </p>
                                <p><span>일반 자전거: 2</span><span>새싹 자전거: 4</span></p>
                            </div>
                            <!-- 예약 가능한 자전거 총 개수 -->
                            <h3 style="font-size: 16px;"></h3>
                        </div>
                        <div class="rev_btn circle_btn1">예약하기</div>
                    </div>
                </div>
                
                
            </div>
            <!-- 컨텐츠 우측 : 공지사항, 이벤트  -->
            <div class="boards">
                <div class="notice">
                    <div class="title">
                        <h3>공지사항</h3>
                        <span onclick="location.href='/notice/nlist'">더보기 ></span>
                    </div>
                    <ul>
                        <!-- for문 돌릴예정 -->
                        <c:choose>
	                       	<c:when test = "${boardList.size() > 0}">
		                        <c:forEach items="${boardList}" var="board">
		                         	<li>
			                            <span>${board.title}</span>
			                            <span>${board.createDt}</span>
		                        	</li>
		                        </c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                        	<li>
	                        		공지사항이 없습니다.
	                        	</li>
	                        </c:otherwise>
                         </c:choose>
                    </ul>
                </div>
                <div class="event">
                    <h3>이벤트</h3>
                    <div class="slideshow-container">
                    	<c:choose>
	                    	<c:when test ="${eventList.size() > 0}">
		                    	<c:forEach items="${eventList}" var="event">
			                    	<div class="mySlides fade">
			                    		<img src="${event.eventThumb}" alt="event img" data-imginfo = "${event.eventKey}">
			                    	</div>
		                    	</c:forEach>
		                    </c:when>	
		                    <c:otherwise>
		                    		<div>
			                    		이벤트가 없습니다.
			                    	</div>
		                    </c:otherwise>
                    	</c:choose>
                    	
                    </div> 
                    	
                    </div>
                     <!-- 진행바  -->
                    <div class="process_station_list">
                        <!-- 이벤트 개수만큼  -->
                        <!-- img를 보여주는 상태바에는 circle-check 클래스명을 넣어줘야함. -->
                        <c:forEach items="${eventList}" var="event">
                        	<div class="circle circle-check"></div>
                        </c:forEach>
                        
                    </div>
                </div> 
            </div>
            </section>




        </div>  
    </div>
    <!-- 예약 모달창 -->
    <div class="modal_back">
        <div class="modal">
            <div class="modal_head">
                <h3 id="modeal-head"></h3>
                <img class="close_btn rev_modal_close icon_style1" src="/images/icon8-close.png">
            </div>
            <div class="modal_body">
                <form class="modal_content" name="revForm" method="post" action="/reserv/insert"> 
                    <div class="bicycle_type form-label">
                        <label for="general">
                            <input type="radio" id="general" name="bicycle_type" value="G"/>
                            <sapn>일반따릉이</sapn>
                        </label>
                        <label for="sprout">
                            <input type="radio" id="sprout" name="bicycle_type" value="S"/>
                            <sapn>새싹따릉이</sapn>
                        </label>
                    </div>
                    <div style="width: 100%; text-align: left;"><h3>자전거 운영 유형</h3></div>
                    <div class="bicycle_operation_type form-label">
                        <label for="LCD">
                            <input type="radio" id="LCD" name="op_type" value="LCD"/>
                            <sapn>LCD</sapn>
                        </label>
                        <label for="QR">
                            <input type="radio" id="QR" name="op_type" value="QR"/>
                            <sapn>QR</sapn>
                        </label>
                    </div>
                    <p class="alert_msg">예약 후 20분 이내로 이용하지 않으면 예약 취소 됩니다.</p>
                    <div class="rev_submit_btn circle_btn1">예약하기</div>
                </form>
            </div>
        </div>
    </div>

    <!-- alert 모달창 -->
    <div class="alert_modal_back">
        <div class="alert_modal">
            <div class="modal_head">
                <h3 id="alert-modeal-head">알림</h3>
                <img class="close_btn icon_style1" src="/images/icon8-close.png">
            </div>
            <div class="modal_body">
                <div class="alert_modal_content"> 
                    
                    
                </div>
            </div>
        </div>
    </div>
    <script>

        // 지도
        var mapOptions = {
            center: new naver.maps.LatLng(37.3595704, 127.105399),
            zoom: 10
        };
        var map = new naver.maps.Map('map', mapOptions);

        
        var markers = [];
        var infoWindows = [];
        var bicycleTypeGStatus = false;
        var bicycleTypeSStatus = false;
		var lcdStatus = false;
		var qrStatus = false;
		
		// 검색 
		function initGeocoder() {
			$('#searchInput').on('keydown', function(e) {
	        var keyCode = e.which;
		        if (keyCode === 13) { // Enter Key
		            searchAddressToCoordinate($('#searchInput').val());
		        }
	    	});
			$('#searchImg').on('click', function(e) {
		        e.preventDefault();
		        searchAddressToCoordinate($('#searchInput').val());
		    });
		}
		
		// 위도로 검색
		function searchCoordinateToAddress(latlng) {

		    infoWindow.close();
		    naver.maps.Service.reverseGeocode({
		        coords: latlng,
		        orders: [
		            naver.maps.Service.OrderType.ADDR,
		            naver.maps.Service.OrderType.ROAD_ADDR
		        ].join(',')
		    }, function(status, response) {
		        if (status === naver.maps.Service.Status.ERROR) {
		            return //alert('Something Wrong!');
		        }

		        var items = response.v2.results,
		            address = '',
		            htmlAddresses = [];

		        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
		            item = items[i];
		            address = makeAddress(item) || '';
		            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

		            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
		        }
		    });
		}
	
		
		/* 주소로 검색 */
		function searchAddressToCoordinate(address) {
	        	naver.maps.Service.geocode({
		        query: address
	            }, function(status, response) {
		        if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }

		        if (response.v2.meta.totalCount === 0) {
		        	return alert("검색 결과가 없습니다.")
		        }
		        var item = response.v2.addresses[0],
		        point = new naver.maps.Point(item.x, item.y);
		        /* 성공시 근처 정류장을 보여줘야함.*/
		        initMap(item.y,item.x)

		        map.setCenter(point);
		        
		    });
	       
		}
		
		
		// 현재위치
		$('.location_img').on('click', function(e) {
	        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	        
	    });
		// 위치조회 성공
		function onSuccessGeolocation(position){
			var location = new naver.maps.LatLng(position.coords.latitude,
            position.coords.longitude);
	        map.setCenter(location);
	        map.setZoom(18);
		}
		// 위치조회 실패
		function onErrorGeolocation(){
			alert("현재위치를 불러올 수 없습니다.");
		}
		
        // 마커 설정
        function initMap(x, y){
        	if(!x){
        		x = 37.3595704;
        	}
        	if(!y){
        		y = 127.105399;
        	}
           // 200m 주위에 있는 데이터만 가져오기
           // 마커 정보 가져오기 
           $.ajax({
    			url:'/reserv/station/info',
    			type:"post",
    			data:{
    				param_lat: x,
    				param_log: y
    			},
    			dataType:'json',
    			success:function(data){
    				if(data.length > 0){
	    				for (key of data) {
	    					var position = new naver.maps.LatLng(
	    							key.stationLat,
	    							key.stationLog);
	    						// 마커 찍기
	    					    var marker = new naver.maps.Marker({
	    					        map: map,
	    					        position: position,
	    					        name: key.stationName,
	    					        stationNumber:key.stationNumber,
	    					        zIndex: 100
	    					    });
	    					    markers.push(marker);
	    					    
	    				}
	    				// 마커 클릭 이벤트 부여
	    				for (var i=0, ii=markers.length; i<ii; i++) {
	    				    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
	    				}
	    				map.setZoom(18);
    				}
    			},
    			error:function(data){
    				console.log(data)
    			}
           })
        }
       
       
		// 마커 클릭시 이벤트
		// 마커 클릭시 markers의 index번호를 넘김
		function getClickHandler(seq) {
			
		    return function(e) {
		        var marker = markers[seq];
		        // 대여소 요약 정보 보여기
	            const marker_info = document.querySelector('.station_info')
	    	    marker_info.style.display="flex";
	            totalCount =0;
	            // 대여 가능한 자전거 데이터 가져오기
	            $.ajax({
	    			url:'/bicycle/select/resPosCnt',
	    			type:"post",
	    			dataType:'json',
	    			data: { stationNumber: marker.stationNumber },
	    			success:function(data){
	    				bicycleTypeGStatus = false;
	    				bicycleTypeSStatus = false;
	    				for(dto of data){
	    					totalCount += dto.count;
	    					if(dto.type ==="G"){
	    						bicycleTypeGStatus=true;
	    						$(".station_info p:eq(1) span:eq(0)").text("일반 자전거 : "+dto.count);
	    					}
	    					if(dto.type ==="S"){
	    						bicycleTypeSStatus=true;
	    						$(".station_info p:eq(1) span:eq(1)").text("새싹 자전거 : "+dto.count);
	    					}
	    				}
	    				
	               		if(!bicycleTypeGStatus){
	               			$(".station_info p:eq(1) span:eq(0)").text("일반 자전거 : 0");
	               		}
	    	            if(!bicycleTypeSStatus){
	    	            	$(".station_info p:eq(1) span:eq(1)").text("새싹 자전거 : 0");
	               		}
	    	            $(".station_info .rev_station_number").text(marker.stationNumber);
	    			   	$(".station_info .rev_station_name").text(marker.name);
	    			   	$(".station_info h3").text(totalCount);
	    			 	// 즐겨찾기 setting
	               		settingBookmark(marker.stationNumber)
	    			},
	    			error:function(data){
	    				console.log(data)
	    			}
           		})
           		
           	
           		
		    }
		}
		
		// 즐겨찾기
		$('.bookmark_img').click(function(){
			var imgSrc = $('.station_info .bookmark_img').attr("src");
			var stationNumber = $(".station_info .rev_station_number").text();
			if(imgSrc.includes("yellow")){
				
				deleteBookmark(stationNumber)
			}else{
				
				insertBookmark(stationNumber)
				
			}
		})
		// 즐겨찾기 추가
		function insertBookmark(stationNumber){
			$.ajax({
				url:"/bookmark/insert",
				method:"post",
				dataType:"json",
				data:{
					stationNumber:stationNumber
				},
				success:function(data){
					if(data){
						$('.station_info .bookmark_img').attr("src",'/images/icons8-별-50_yellow.png');
					}else{
						alert("즐겨찾기 추가를 실패했습니다.")
					}
				},
				error:function(e){
					
				}
			})
		}
		// 즐겨찾기 제거
		function deleteBookmark(stationNumber){
			$.ajax({
				url:"/bookmark/delete",
				method:"post",
				dataType:"json",
				data:{
					stationNumber:stationNumber
				},
				success:function(data){
					if(data){
						$('.station_info .bookmark_img').attr("src",'/images/icons8-별-50.png')
					}else{
						alert("즐겨찾기 제거를 실패했습니다.")
					}
				},
				error:function(e){
					
				}
			})
		}
		
		
		function settingBookmark(stationNumber){
			$.ajax({
				url:"/bookmark/select",
				method:"post",
				dataType:"json",
				data:{stationNumber:stationNumber},
				success:function(data){
					if(data){
						$('.station_info .bookmark_img').attr("src",'/images/icons8-별-50_yellow.png')
					}else{
						$('.station_info .bookmark_img').attr("src",'/images/icons8-별-50.png')
					}
				},
				error:function(){
					
				}
				
				
			})
			
		}
		
		/*naver.maps.Event.addListener(markers, 'click', function(e) {
    	    
             marker.setPosition(e.latlng); 
            
    		// 공공 데이터 대여소별 자전거 정보 가져오기
			 $.ajax({
				url:'http://openapi.seoul.go.kr:8088/4c72714a68736f6e3933495675494b/json/bikeList/1/5/',
				type:"get",
				dataType:'json',
				success:function(data){
					console.log(data)
					console.log(data.rentBikeStatus)
				},
				error:function(data){
					console.log(data)
				}
				
			})  
        }); */

        function checkReserv(){
        	return new Promise((resolve, reject) => {
                $.ajax({
                    url: "/reserv/checkReserv",
                    method: "post",
                    success: function(data) {
                        const checkResult = data.result;
                        if (!checkResult) {
                            alert(data.resultMsg);
                            resolve(false); // 실패한 경우 false 반환
                        }
                        resolve(checkResult); // 성공한 경우 결과 반환
                    },
                    error: function(e) {
                        resolve(false); // 에러가 발생하면 false 반환
                    }
                });
            });
        }
        
        // map > 예약하기 btn click시
        // 예약모달 open
        const modal = document.querySelector('.modal_back');
        const btnOpenModal=document.querySelector('.rev_btn');

        btnOpenModal.addEventListener("click", async()=>{
        	
        	/* 예약버튼 click 조건 start */
        	if($('.station_info').css('display') != "flex"){
        		alert("대여소를 선택해주세요.");
        		return;
        	}
        	var checkRev = await checkReserv();
        	if(!checkRev){return;}
        	/* 예약버튼 click 조건 end */
        	
            modal.style.display="flex";

        	// 모달 제목 설정
            const modal_head = document.querySelector('#modeal-head');
            const stationNumber = $(".station_info .rev_station_number").text()
            const stationName = $(".station_info .rev_station_name").text()
            modal_head.innerText = stationNumber+stationName;
            
            $.ajax({
    			url:'/bicycle/select/opTypeCnt',
    			type:"post",
    			dataType:'json',
    			data: { stationNumber: stationNumber },
    			success:function(data){
    				lcdStatus = false;
    				qrStatus = false;
    				for(dto of data){
    					if(dto.type ==="LCD"){
    						lcdStatus=true;
    					}
    					if(dto.type ==="QR"){
    						qrStatus=true;
    					}
    				}
    				
    				if(!lcdStatus){
    					$(".bicycle_operation_type input:eq(0)").prop('disabled', true);
    				}	
    				if(!qrStatus){
    					$(".bicycle_operation_type input:eq(1)").prop('disabled', true);
    				}	
    				if(!bicycleTypeGStatus){
    					$(".bicycle_type input:eq(0)").prop('disabled', true);
    				}	
    				if(!bicycleTypeSStatus){
    					$(".bicycle_type input:eq(1)").prop('disabled', true);
    				}	
		            
    			},
    			error:function(data){
    				console.log(data)
    			}
       		})
        	
        });


        // 예약 모달 닫기
        const btnCloseModal = document.querySelector(".rev_modal_close");
        btnCloseModal.addEventListener("click",()=>{
            modal.style.display="none";
            $('.modal_content')[0].reset();
            $(".bicycle_operation_type input:eq(0)").prop('disabled', false);
            $(".bicycle_operation_type input:eq(1)").prop('disabled', false);
            $(".bicycle_type input:eq(0)").prop('disabled', false);
            $(".bicycle_type input:eq(1)").prop('disabled', false);
        })

        // 모달 > 예약하기
        const ModalRevBtn = document.querySelector(".rev_submit_btn");
        const alert_modal = document.querySelector(".alert_modal_back");
        ModalRevBtn.addEventListener("click",()=>{
            
            var result = false;
            const stationNumber = $(".station_info .rev_station_number").text()
			var bicycleType = $("input:radio[name='bicycle_type']:checked").val();
			var opType = $("input:radio[name='op_type']:checked").val();
	        
	        /* 값 확인 */
	        if(bicycleType != null){
	        	result = true;
	        }
			if(opType != null){
				result = true;
			}
	        
			if(result === true){
				// ajax로 form의 값 server에 전달 -> 예약 작업
				$.ajax({
					url:"/reserv/insert",
					method:"post",
					dataType:'json',
					data:{
						stationNumber:stationNumber,
						bicycleType:bicycleType,
						opType:opType
						},
					success:function(data){
						var content = ``;
						if(data.status){
							content = `
				                <p class="modal_main_txt">예약 되었습니다.</p>
				                <p>따릉이 번호 : `+data.bicycleNumber+`</p>
				                <div class="horizontal-line"></div>
				                <div>
				                    <p class="alert_msg">예약 후 20분 이내로 이용하지 않으면 예약 취소 됩니다.</p>
				                    <p>예약내용은 마이페이지 > 내 정보에서 확인 할 수 있습니다.</p>
				                </div>
				                <a href="/reserv/delete" style="text-decoration: none; color: #333;"><div class="btn2">예약취소</div></a>
				            `;
			                
			                
						}else{
							content = `
								<p class="modal_main_txt">예약 실패하였습니다.</p>
				                    <p>대여소를 다시 선택해주세요.</p>
				                    <div class="horizontal-line"></div>
				                `;
						}
						$(".alert_modal_content").html(content);
						// 예약 모달 닫기
			            modal.style.display="none";
			         	// 성공시 결과 모달 창 보여주기
			            alert_modal.style.display="flex";
					},
					error:function(xhr, status, error){
						console.error("AJAX 요청 실패:", status, error);
						alert("예약 처리 중 오류가 발생했습니다. 다시 시도해 주세요.");
					}
				})
			}
        })

        


        // 알림 모달 닫기
        const btnCloseAlertModal = document.querySelector(".alert_modal_back .close_btn");
        btnCloseAlertModal.addEventListener("click",()=>{
            alert_modal.style.display="none";
        })
        
        // 자동 슬라이더
        var slideIndex = 0;

	    function showSlides() {
	    	let slides = document.getElementsByClassName("mySlides");
	    	let proccessbars = document.getElementsByClassName("circle");
	    	if(proccessbars.length > 0){
	            for (let i = 0; i < slides.length; i++) {
	                slides[i].style.display = "none";
	            }
	            for (let i = 0; i < proccessbars.length; i++) {
	            	proccessbars[i].classList.remove("circle-check");
	            }
	            slideIndex++;
	            if (slideIndex > slides.length) { slideIndex = 1; }
	            slides[slideIndex - 1].style.display = "block";
	            proccessbars[slideIndex-1].classList.add("circle-check");
	            setTimeout(showSlides, 10000);
	    	}
            
	    }

	    // 이벤트 이미지 클릭시
	    $(".mySlides img").on('click', function(e) {
	    	var imgKey = $(this).data("imginfo")
	    	location.href= "/event/edetail/"+imgKey
	    })
        
	    initMap();
		showSlides();
	    window.onload = function() {
	    	initGeocoder();
	    	/*  searchAddressToCoordinate(); */
	    };
        
    </script>
</body>
</html>