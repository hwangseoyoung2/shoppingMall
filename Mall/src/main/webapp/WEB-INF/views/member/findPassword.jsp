<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
</head>
<style>

	body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
	}
	
	h3 {
		margin-top:120px;
	    color: #333;
	}

	.findPwForm button {
	    padding: 10px;
	    background-color: #B0B0B0;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    margin-top: 30px;
	}
	
	button:hover {
	    background-color: #C0C0C0;
	}
	
	.findPwForm input {
	    padding: 10px;
	    vertical-align: middle;
	    margin-bottom: 10px;
	}
	
	.findPwForm {
		margin-top: 100px;
	}
	
</style>
<body>
    <h3>비밀번호 찾기</h3>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    
    <c:if test="${not empty successMessage}">
        <p style="color: green;">${successMessage}</p>
    </c:if>
	<div class="findPw">
	    <form action="/resetPassword" method="post" class="findPwForm">
	        <label for="memberId">아이디:</label>
	        <input type="text" id="memberId" name="memberId" required><br>
			<br>
	        <label for="email">이메일:</label>
	        <input type="email" id="email" name="email" required><br>
	
	        <button style="margin-right:10px;" type="submit">이메일 발송</button>
	        <button id="goLogin" name="goLogin" onclick="location.href='/login'">로그인 하러 가기</button>
	    </form>
  	</div>
</body>
</html>
