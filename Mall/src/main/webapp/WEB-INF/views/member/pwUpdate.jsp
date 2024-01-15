<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/resources/header.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Update</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }

        .pwUpdate {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 120px;
            width: 60%;
            align-content: center;
            margin-left:330px;
            height:400px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom:100px;
        }

        .pwUpdateForm {
            max-width: 300px;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .pwUpdateForm input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .pwUpdateForm input[type="submit"] {
            background-color: #B0B0B0;
            color: #fff;
            cursor: pointer;
        }

       .pwUpdateForm input[type="submit"]:hover {
            background-color: #C0C0C0;
        }
    </style>
</head>
<body>
    <div class="pwUpdate">
        <h2>비밀번호 변경</h2>
        <form action="/pwUpdate" method="post" class="pwUpdateForm" onsubmit="return checkPasswords()">
            <label for="password">새 비밀번호</label>
            <input style="margin-bottom:20px;" type="password" id="password" name="password" required>
            <br>
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <br>
            <input type="submit" value="비밀번호 변경">
        </form>
    </div>
    
    <script>
        function checkPasswords() {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                alert("입력한 비밀번호가 일치하지 않습니다.");
                return false;
            } else {
                return confirm("비밀번호를 변경하시겠습니까?");
            }
        }
    </script>
</body>
</html>
