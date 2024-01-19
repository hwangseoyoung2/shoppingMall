<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 인증</title>
</head>
<style>

	body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
	}
	
	.container {
	    max-width: 600px;
	    margin: 50px auto;
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 10px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	h4 {
	    color: #333;
	}
	
	#sendForm, #verifyForm {
	    margin-bottom: 20px;
	}
	
	.findIdForm input {
	    padding: 10px;
	    vertical-align: middle;
	    margin-bottom: 10px;
	}
	
	.findIdForm {
		margin-top: 150px;
	}
	
	.findIdForm button {
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
	
</style>
<body>
	<div class="findIdForm">
	    <h4>회원가입 시 이용한 이메일을 입력하세요</h4>
	    <form id="sendVerificationForm" class="sendForm">
	        <input type="text" id="email" name="email" style="margin-right:10px;" required>
	        <input type="button" id="sendVerification" value="인증 코드 전송">
	    </form>
	
	    <h4>인증 코드를 입력하세요</h4>
	    <form id="verifyCodeForm" class="verifyForm">
	        <input type="text" id="verificationCode" name="verificationCode" style="margin-right:10px;" required>
	        <input type="button" id="verifyCode" value="인증 확인">
	    </form>
	    <button id="goLogin" name="goLogin" onclick="location.href='/login'">로그인 하러 가기</button>
	    <button id="findPw" name="findPw" onclick="location.href='/findPassword'">비밀번호 찾기</button>
	</div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var emailVerificationCode = "";
            var isVerificationCodeValid = false;

            $("#sendVerification").click(function() {
                var email = $("#email").val();

                if (email) {
                    $.ajax({
                        url: "/sendVerificationCode",
                        type: "POST",
                        data: { email: email },
                        success: function(response) {
                            alert("인증 코드가 전송되었습니다.");
                            emailVerificationCode = response;
                        },
                        error: function(xhr, status, error) {
                            alert("인증 코드 전송에 실패했습니다.");
                            console.error(xhr.responseText);
                        }
                    });
                } else {
                    alert("이메일을 입력하세요.");
                }
            });
            
            $("#verifyCode").click(function(event) {
                event.preventDefault();

                var userVerificationCode = $("#verificationCode").val();

                if (userVerificationCode) {
                	$.ajax({
                	    url: "/verifyVerificationCode",
                	    type: "POST",
                	    contentType: "application/json",
                	    data: JSON.stringify({ userVerificationCode: userVerificationCode }),
                	    success: function(response, status, xhr) {
                	        if (xhr.status === 200) {
                	            $.ajax({
                	                url: "/sendMemberId",
                	                type: "POST",
                	                contentType: "application/json",
                	                data: JSON.stringify({ email: $("#email").val() }),
                	                success: function(response) {
                	                    alert("입력하신 이메일로 아이디가 발송되었습니다.");
                	                },
                	                error: function(xhr, status, error) {
                	                    alert("아이디 발송에 실패했습니다.");
                	                    console.error(xhr.responseText);
                	                }
                	            });
                	        } else {
                	            alert("인증에 실패했습니다. 올바른 인증번호를 입력해주세요.");
                	        }
                	    },
                	    error: function(xhr, status, error) {
                	        alert("인증 번호를 다시 확인해주세요");
                	        console.error(xhr.responseText);
                	    }
                	});

                } else {
                    alert("인증번호를 입력해주세요.");
                }
            });

        });
    </script>
</body>
</html>
