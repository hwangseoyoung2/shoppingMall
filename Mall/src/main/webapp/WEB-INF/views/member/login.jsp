<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
    	body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #container {
            width: 50%;
            max-width: 300px;
            padding: 40px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin: auto;
            margin-top:100px;
        }
        #container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        #container form {
            display: flex;
            flex-direction: column;
        }
        #container label {
            margin-bottom: 8px;
        }
        #container input {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        #container button {
            padding: 12px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        #container button[type="submit"] {
            background-color: #B0B0B0;
        }
        #container button[type="submit"]:hover {
            background-color: #C0C0C0;
        }
		#kakaoBtn {
		    border: none;
		    border-radius: 5px;
		    margin-top:5px;
		    width: 100%;
		    height:70%;
		}
		
		#container a {
            text-decoration: none; 
            color: gray;
            font-size:12px;
            margin-bottom:10px;
        }

        #container a:hover {
            color: black;
        }
        
        .aTag {
        	margin-bottom:10px;
        	margin-top:20px;
        }
        
        label {
        	text-align: left;
        	font-size:13px;
        }
    </style>
</head>
<body>
    <div id="container">
        <h2>Login</h2>
        <form action="/login" method="post">
            <label for="memberId">ID</label>
            <input type="text" id="memberId" name="memberId" required>
            <label for="password">PASSWORD</label>
            <input type="password" id="password" name="password" required>
            <div class="aTag">
                <a style="margin-right:5px;" href="/findMemberId">아이디 찾기</a>
                <a href="/findPassword">비밀번호 찾기</a>
                <a style="margin-left:90px;" href="/join">회원가입</a>
            </div>
            <button type="submit">로그인</button>
            <a href="kakaoTerms"><img height="38px;" id="kakaoBtn" src="/image/kakao_login_btn2.png"></a>
        </form>
    </div>
</body>
</html>
