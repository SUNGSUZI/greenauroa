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
        
        <title>문의하기</title>
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
                <h2>문의사항 수정</h2>
            </div>
            <div>
            
			<form:form modelAttribute="qna" method="post" class="form" enctype="multipart/form-data">
			    <form:input path="memberId" readonly="true" style="visibility: hidden;"/>
			    <form:input path="category" value="문의사항" readonly="true" style="visibility: hidden;"/>
			    
			    <div class="form-div">
			        <div class="form-label">제목: </div>
			        <form:input path="title" class="form-control" value="${qna.title}"/>
			    </div>
			
			    <div class="form-div">
			        <div class="form-label">문의사항: </div>
			        <form:select path="sub" class="form-control" value="${qna.sub}">
			            <form:option value="문의사항" label="문의사항"/>
			            <form:option value="대여 및 반납" label="대여 및 반납"/>
			            <form:option value="자전거 추가 배치" label="자전거 추가 배치"/>
			            <form:option value="대여소(개설/폐쇄)" label="대여소(개설/폐쇄)"/>
			            <form:option value="결제/환불/마일리지" label="결제/환불/마일리지"/>
			            <form:option value="운영 및 정책" label="운영 및 정책"/>
			            <form:option value="자전거 및 시설 관리" label="자전거 및 시설 관리"/>
			            <form:option value="앱 또는 홈페이지 관리" label="앱 또는 홈페이지 관리"/>
			            <form:option value="방치 자전거 발견" label="방치 자전거 발견"/>
			        </form:select>
			    </div>   
			    
			    <div class="form-div">
			        <div class="form-label">첨부파일: </div>
			        <input type="file" name=filePath class="form-control" value="${qna.filePath}"/>
			    </div> 
			    
			    <div class="form-div">
			    	<div class="form-label">내용: </div>
			        <%-- <form:textarea path="contents" id="contents" class="form-control" value="${qna.contents}"/> --%>
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
					<form:input type="hidden" path="contents"  name="contents" id="contents" value="${qna.contents}"/>
					<script src="https://cdn.ckeditor.com/ckeditor5/44.1.0/ckeditor5.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/44.1.0/ckeditor5-premium-features.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5/44.1.0/translations/ko.umd.js" crossorigin></script>
					<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/44.1.0/translations/ko.umd.js" crossorigin></script>
					<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js" crossorigin></script>
				    <script src="/js/ckeditor.js"></script>
			    </div> 			    
			
			    <div style="display: flex; justify-content: space-between;">
			        <div>
			            <form:checkbox path="secret" value="Y" label="비공개로 설정"/>
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

    <script src="https://cdn.ckeditor.com/ckeditor5/44.1.0/ckeditor5.umd.js"></script>
		<script>
			const {
				ClassicEditor,
				Essentials,
				Paragraph,
				Bold,
				Italic,
				Font
			} = CKEDITOR;
			// Create a free account and get <YOUR_LICENSE_KEY>
			// https://portal.ckeditor.com/checkout?plan=free
			ClassicEditor
				.create( document.querySelector( '#contents' ), {
					licenseKey: 'eyJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3MzgzNjc5OTksImp0aSI6IjI0Yzg4MDQzLTk5MWEtNGMzNS05ODU1LTkzNWM1M2VmODUxZCIsInVzYWdlRW5kcG9pbnQiOiJodHRwczovL3Byb3h5LWV2ZW50LmNrZWRpdG9yLmNvbSIsImRpc3RyaWJ1dGlvbkNoYW5uZWwiOlsiY2xvdWQiLCJkcnVwYWwiLCJzaCJdLCJ3aGl0ZUxhYmVsIjp0cnVlLCJsaWNlbnNlVHlwZSI6InRyaWFsIiwiZmVhdHVyZXMiOlsiKiJdLCJ2YyI6IjhlYTAwMjg5In0.iaU2zQl0e8JPvGbQ04EUqQL7tfX0Yptxe572a5-IP153z142Tx3tAuiQEbiYKmeHkvk4cqDwc3sYo-l4zF1n6g',
					plugins: [ Essentials, Paragraph, Bold, Italic, Font ],
					toolbar: [
						'undo', 'redo', '|', 'bold', 'italic', '|',
						'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor'
					]
				} )
				.then( editor => {
					window.editor = editor;
				} )
				.catch( error => {
					console.error( error );
				} );
	</script>
    
    </body>
</html>