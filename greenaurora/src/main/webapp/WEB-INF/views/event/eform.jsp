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
        <link href="/css/main2.css" rel="stylesheet" />
        <link href="/css/main.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/44.1.0/ckeditor5.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link href="/css/ckeditor.css" rel="stylesheet" />
        
        <title>이벤트</title>
    </head>
    <body>
    <!-- 전체 화면 -->
    <div class="main_public">
        <!-- 공통 부분 start -->
        <jsp:include page="/WEB-INF/views/head_board.jsp" />
		<!-- 공통 부분 end -->

        <!-- 컨텐츠 작업 start -->
        <section class="list">
            <div class="list_top">
                <h2>이벤트 작성</h2>
            </div>
            <div>
            <form:form modelAttribute="eventForm" method="post" class="form" enctype="multipart/form-data">
			    <div class="form-div">
			        <div class="form-label">이벤트 제목: </div>
			        <form:input path="eventName" class="form-control"/>
			    </div>
			    
			    <div class="form-div">
			        <div class="form-label">따릉이 정거장: </div> <!-- 나중에 시간 되면 조회하는 기능도 추가할 것 -->
			        <form:input path="stationNumber" class="form-control"/>
			    </div>
			    
			    <div class="form-div">
			        <div class="form-label">추가 포인트: </div>
			        <form:input path="plusPoint" class="form-control"/>
			    </div>
			    
			    <div class="form-div">
				    <div class="form-label">이벤트 시작일: </div>
				    <form:input type="date" path="startDt" class="form-control"/>
			    </div>
			    
			    <div class="form-div">
				    <div class="form-label">이벤트 종료일: </div>
				    <form:input type="date" path="endDt" class="form-control"/>
			    </div>
			    
			    <div class="form-div">
			    	<div class="form-label">이벤트 내용: </div>
					<div class="main-container">
						<div class="editor-container editor-container_document-editor editor-container_include-style" id="editor-container">
							<div class="editor-container__toolbar" id="editor-toolbar"></div>
							<div class="editor-container__editor-wrapper">
								<div class="editor-container__editor">
									<div id="editor"></div>
								</div>
							</div>
						</div>
					</div>
					<form:input type="hidden" path="eventContent"  name="contents" id="contents" />
					<script src="https://cdn.ckeditor.com/ckeditor5/44.1.0/ckeditor5.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/44.1.0/ckeditor5-premium-features.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5/44.1.0/translations/ko.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/44.1.0/translations/ko.umd.js" crossorigin></script>
					<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js" crossorigin></script>
				    <script src="/js/ckeditor.js"></script>
			    </div> 		
			    	    
			    <div class="form-div">
			        <div class="form-label">이벤트 썸네일: </div>
			        <input type="file" name="eventThumb" class="form-control" />
			    </div>
			    
			    <div style="display: flex; justify-content: space-between;">
			        <div>
						<input type="radio" name="state" value="A" checked> 활성화하기
						<input type="radio" name="state" value="D"> 비활성화하기
			        </div>
			        <div>
			            <button class="form_submit button">등록하기</button>
			        </div>
			    </div>
            </form:form>			
            </div>
        </section>
		<!-- 컨텐츠 작업 end -->
		
	</div>
    </body>
</html>