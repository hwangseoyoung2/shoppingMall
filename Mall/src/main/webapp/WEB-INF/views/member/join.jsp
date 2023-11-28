<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Page</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .center-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .input-container {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }

        .input-container label {
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
        }

        .input-container input {
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .input-container button {
            padding: 6px 10px;
            background-color: #C0C0C0;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 11px;
            margin-left: 10px;
        }
        
        .input-container button:hover {
            background-color: #E0E0E0;
        }

        #duplicateResult {
            margin-top: 10px;
            display: block;
        }

        .message-container {
            margin-top: 10px;
        }
        
        #joinFormSubmit {
            background-color: #C0C0C0;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        #joinFormSubmit:hover {
            background-color: #E0E0E0;
        }
    </style>
</head>
<body>
    <div class="center-container">
        <form id="joinForm" action="/join" method="post">
            <div class="input-container">
                <label for="memberId">아이디 </label>
                <div style="display: flex;">
                    <input type="text" id="memberId" name="memberId" required style="flex: 1;" placeholder="최소 6자 이상이어야 하며 영문, 숫자만 가능합니다">
                    <button id="checkDuplicate">중복 체크</button>
                </div>
                <span id="duplicateResult"></span>
            </div>

            <div class="input-container">
                <label for="password">비밀번호 </label>
                <input type="password" id="password" name="password" required placeholder="비밀번호는 대소문자, 숫자, 특수문자를 포함하여 최소 8자 이상이어야 합니다.">
            </div>

            <div class="input-container">
                <label for="confirmPassword">비밀번호 확인 </label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>

            <div class="input-container">
                <label for="name">이름 </label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="input-container">
                <label for="phone">연락처 </label>
                <input type="text" id="phone" name="phone" required>
            </div>

            <div class="input-container">
                <label for="email">이메일 </label>
                <div style="display: flex;">
                    <input type="email" id="email" name="email" required style="flex: 1;">
                    <button id="sendVerificationCode">인증번호 발송</button>
                </div>
            </div>

            <div class="input-container">
                <label for="verificationCode">인증번호</label>
                <div style="display: flex;">
                    <input type="text" id="verificationCode" name="verificationCode" required style="flex: 1;">
                    <button id="verifyCode">인증</button>
                </div>
            </div>

            <div class="input-container">
                <label for="address">주소 </label>
                <input type="text" id="address" name="address" required readonly>
                <input type="text" id="detailAddress" name="detailAddress" required>
                <input type="submit" id="joinFormSubmit" value="회원가입">
            </div>
        </form>
    </div>
<script>
	$(document).ready(function() {
	    var isIdAvailable = false;
	    var isVerificationCodeValid = false;
	    
	    function isAlphanumeric(input) {
	        var alphanumericRegex = /^[a-zA-Z0-9]+$/;
	        return alphanumericRegex.test(input);
	    }
	
	    //아이디 중복 체크
	    $("#checkDuplicate").click(function(event) {
	        event.preventDefault();
	        
	        var memberId = $("#memberId").val();
	        
	        if (memberId) {
	            if (!isAlphanumeric(memberId)) {
	                alert("아이디는 영문과 숫자만 허용됩니다.");
	                return;
	            }
                if (memberId.length < 6) {
                    alert("아이디는 최소 6자 이상이어야 합니다.");
                    return;
                }
                
	            $.ajax({
	                url: "/checkDuplicateId",
	                type: "POST",
	                data: { memberId: memberId },
	                success: function(response) {
	                    if (response.isDuplicate) {
	                        $("#duplicateResult").html("<span style='color: red;'>이미 사용 중인 아이디입니다.</span>");
	                        isIdAvailable = false;
	                    } else {
	                        $("#duplicateResult").html("<span style='color: green;'>사용 가능한 아이디입니다.</span>");
	                        isIdAvailable = true;
	                    }
	                }
	            });
	        } else {
	            alert("아이디를 입력해주세요.");
	        }
	    });
	    
	function isStrongPassword(input) {
	    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/;
	    return passwordRegex.test(input);
	}

    $("#joinFormSubmit").click(function(event) {
        event.preventDefault();

        var name = $("#name").val();
        var phone = $("#phone").val();
        var email = $("#email").val();
        var address = $("#address").val();
        var detailAddress = $("#detailAddress").val();
        
        var password = $("#password").val();
        
        if (!isStrongPassword(password)) {
            alert("비밀번호는 대소문자, 숫자, 특수문자를 포함하여 최소 8자 이상이어야 합니다.");
            return;
        }

        if (!isIdAvailable) {
            alert("아이디 중복확인을 해주세요.");
        } else if (!isVerificationCodeValid) {
            alert("인증번호 확인을 해주세요.");
        } else if (!name || !phone || !email || !address || !detailAddress) {
            alert("모든 필드를 입력해주세요.");
        } else {
            if (!confirm("회원가입을 하시겠습니까?")) {
            } else {
                alert("회원가입을 완료했습니다.");
                $("#joinForm").submit();
            }
        }
    });

	$("#sendVerificationCode").click(function(event) {
	    event.preventDefault();
	
	    var email = $("#email").val();
	
	    if (email) {
	        $.ajax({
	            url: "/checkDuplicateEmail",
	            type: "POST",
	            data: { email: email },
	            success: function(response) {
	                if (response.isDuplicate) {
	                    alert("이미 가입된 이메일입니다.");
	                } else {
	                    $.ajax({
	                        url: "/sendVerificationCode",
	                        type: "POST",
	                        data: { email: email },
	                        success: function(response) {
	                            alert("인증번호가 발송되었습니다.");
	                        },
	                        error: function(xhr, status, error) {
	                            alert("인증번호 발송에 실패했습니다.");
	                            console.error(xhr.responseText);
	                        }
	                    });
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("중복 확인 중 오류가 발생했습니다.");
	                console.error(xhr.responseText);
	            }
	        });
	    } else {
	        alert("이메일을 입력해주세요.");
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
	                    alert("인증에 성공했습니다.");
	                    isVerificationCodeValid = true;
	                } else {
	                    alert("인증에 실패했습니다. 올바른 인증번호를 입력해주세요.");
	                    isVerificationCodeValid = false;
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("인증 번호를 다시 확인해주세요");
	                console.error(xhr.responseText);
	                isVerificationCodeValid = false;
	            }
	        });
	    } else {
	        alert("인증번호를 입력해주세요.");
	        isVerificationCodeValid = false;
	    }
	});


    // 주소 검색 버튼 클릭 이벤트
    document.getElementById('address').addEventListener('click', function() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('address').value = data.address;
            }
        }).open();
    });
});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>