<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새로운 공지 등록</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-top: 20px;
        }

        .registerForm {
            width: 50%;
            margin: 20px auto;
            margin-top:80px;
        }

        .registerForm label {
            display: block;
            margin-bottom: 8px;
        }

        .registerForm input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 40px;
            box-sizing: border-box;
        }

        .registerForm textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            resize: none;
            height: 350px;
        }

        .registerForm input[type="submit"] {
            background-color: #C0C0C0;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .registerForm input[type="submit"]:hover {
            background-color: #E0E0E0;
        }
    </style>
</head>
<body>
    <div>
        <form id="noticeForm" class="registerForm" action="${pageContext.request.contextPath}/noticeRegister" method="post" >
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>

            <label for="content">내용</label>
            <textarea id="content" name="content" rows="8" required></textarea>

            <input type="submit" value="등록">
        </form>
    </div>
    <script>
    document.getElementById('noticeForm').addEventListener('submit', function (event) {
        event.preventDefault();
        setTimeout(function () {
            alert('등록하시겠습니까?');
            setTimeout(function () {
                alert('등록되었습니다.');
                document.getElementById('noticeForm').submit();
            }, 500);
        }, 500);
    });
</script>
    
</body>
</html>
