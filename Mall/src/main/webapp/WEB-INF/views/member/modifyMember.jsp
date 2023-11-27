<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0px;
        background-color: #f4f4f4;
    }
    
    h3 {
		margin-top:40px;
	    color: #333;
	}

    .modify {
        max-width: 40%;
        margin: 0 auto;
        margin-top: 50px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .modifyForm {
        display: flex;
        flex-direction: column;
        width: 100%;
    }

    label {
        margin-bottom: 10px;
        color: #333;
        width: 100%;
        text-align: left;
    }

    .modify input {
        padding: 10px;
        margin-bottom: 15px;
        box-sizing: border-box;
        width: 100%;
    }

    button {
        background-color: #4CAF50;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 15px;
    }

    button:hover {
        background-color: #45a049;
    }

    #changeAddressBtn,
    #updatePwBtn,
    #modifyBtn {
        background-color: #B0B0B0;
    }

    #changeAddressBtn:hover,
    #updatePwBtn:hover,
    #modifyBtn:hover {
        background-color: #C0C0C0;
    }
</style>

</head>
<body>
	<h3>회원 정보 수정</h3>
    <div class="modify">
        <form action="/modifyMember" method="post" class="modifyForm">
            <label for="name">이름:</label>
            <input type="text" name="name" id="name" value="${member.name}" required>
            
            <label for="phone">전화번호:</label>
            <input type="text" name="phone" id="phone" value="${member.phone}" required>
            
            <label for="email">이메일:</label>
            <input type="text" name="email" id="email" value="${member.email}" required>
            
            <label for="address">주소:</label>
            <input type="text" name="address" id="address" value="${member.address}" readonly onclick="executeDaumPostcode()" required>
            
            <label for="detailAddress">상세주소:</label>
            <input type="text" name="detailAddress" id="detailAddress" value="${member.detailAddress}">
        </form>
                    
            <button style="margin-right:10px;" type="submit" id="modifyBtn" onclick="modifyBtn()">수정</button>
            <button id="updatePwBtn" onclick="location.href='/pwUpdate'">비밀번호 변경</button>
    </div>

    <script>
        function executeDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var newAddress = data.address;
                    document.getElementById('address').value = newAddress;
                }
            }).open();
        }
        
        function modifyBtn() {
            if(confirm("수정하시겠습니까?")) {
            	alert("수정되었습니다");
            }
        }
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
