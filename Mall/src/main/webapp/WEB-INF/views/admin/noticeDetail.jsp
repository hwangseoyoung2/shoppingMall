<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
        }

        h1.noticeName {
            color: #333;
            text-align: center;
            margin-top: 20px;
            font-size: 24px;
            margin-bottom: 100px;
            margin-top:150px;
        }

        .notice-content {
            padding: 20px;
            margin-bottom: 70px;
        }

        .title {
        	font-size: 14px;
            color: #555;
            margin-bottom: 40px;
            font-weight: bold;
        }
        
        .backBtn {
            padding: 10px 30px;
            font-size: 16px;
            cursor: pointer;
            background-color: #E0E0E0;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-top: 20px;
            transition: background-color 0.3s ease-in-out;
        }
        
         .modifyBtn {
            padding: 10px 30px;
            font-size: 16px;
            cursor: pointer;
            background-color: #E0E0E0;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-top: 20px;
            transition: background-color 0.3s ease-in-out;
            margin-left:7px;
            margin-right:7px;
        }
        
        .deleteBtn {
            padding: 10px 30px;
            font-size: 16px;
            cursor: pointer;
            background-color: #E0E0E0;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-top: 20px;
            transition: background-color 0.3s ease-in-out;
        }

        .backBtn:hover {
            background-color: #C0C0C0;
        }
        
        .btns-container {
            text-align: right;
            margin-right:100px;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>
    <div>
        <h1 class="noticeName">NOTICE</h1>
        <div class="title">
            <span>${notice.title }</span>
        </div>
        <div class="notice-content">
            <pre>${notice.content}</pre>
        </div>
        <div class="btns-container">
            <button class="backBtn" onclick="goList()">목록</button>
            <c:if test="${memberId eq 'admin'}">
                <button class="modifyBtn" onclick="modifyNotice()">수정</button>
                <button class="deleteBtn" onclick="deleteNotice()">삭제</button>
            </c:if>
        </div>
    </div>
    
    <script>
    	function goList(){
    		location.href = '/notice';
    	}
    	
    	   function deleteNotice() {
    	        var confirmation = confirm('정말로 삭제하시겠습니까?');

    	        if (confirmation) {

    	            var noticeId = ${notice.id};
    	            $.ajax({
    	                type: 'DELETE',
    	                url: '/deleteNotice/' + noticeId,
    	                success: function (data) {
    	                    alert('삭제되었습니다.');
    	                    window.location.href="/notice";
    	                },
    	                error: function (error) {
    	                    alert('삭제 중 오류가 발생했습니다.');
    	                }
    	            });
    	        }
    	    }

    </script>
</body>
</html>
