<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        form.register {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top:100px;
        }

        h3 {
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            text-align: center;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 13px;
            text-align: left;
        }

        textarea {
            resize: none;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .cancel-btn {
            background-color: #ccc;
            margin-left: 10px;
        }

        .cancel-btn:hover {
            background-color: #bbb;
        }
    </style>
</head>
<body>
    <form id="registerForm" action="itemQnARegister" method="post" class="register">
        <input type="hidden" id="id" name="id" value="${item.id}">
        <div>
            <h3>상품 : ${item.title}</h3>
        </div>
        <div>
            <label for="category">질문 유형</label>
            <select id="category" name="category" required>
                <option value="상품문의">상품문의</option>
                <option value="배송문의">배송문의</option>
                <option value="반품문의">반품문의</option>
            </select>
        </div>
        <div>
            <label for="content">질문 내용</label>
            <textarea id="content" name="content" rows="8" required></textarea>
        </div>
        <div>
            <button type="submit" onclick="register();">등록</button>
            <button type="button" onclick="location.href='/itemQnA?id=${item.id}'" class="cancel-btn">취소</button>
        </div>
    </form>
    
	<script>
		function register() {
		    if (confirm("질문을 등록하시겠습니까?")) {
		        document.forms["registerForm"].submit();
		        alert("질문이 등록되었습니다");
		    }
		}
	</script>
</body>
</html>
