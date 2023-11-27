<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }

	.container {
	    position: relative;
	    max-width: 800px;
	    margin: 50px auto;
	    padding: 40px 20px;
	    background-color: #ffffff;
	    height: 400px;
	    width: 80%;
	    border: 1px solid #ddd;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	}

    h2 {
        text-align: center;
        margin-bottom: 60px;
    }

    p {
        margin: 10px 0;
        font-size: 20px;
    }
    
    form p,
	form button {
	    font-size: 16px;
	}
	
	 .page-container {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
    }

	.button-container2 {
	    position: absolute;
	    bottom: 20px;
	    left: 20px;
	    text-align: left;
	    padding: 10px;
	    border-radius: 4px;
	    display: flex; /* 버튼을 수평으로 정렬하기 위해 추가 */
	    margin-left:900px;
	}
	
	.button-container2 button {
	    padding: 10px 20px;
	    margin-right: 10px; /* 버튼 사이의 오른쪽 여백을 추가 */
	   background-color: #D3D3D3;
        color: #333;
	    border: none;
	    cursor: pointer;
	}
	
	.button-container2 button:last-child {
	    margin-right: 10px; /* 마지막 버튼의 오른쪽 여백을 제거 */
	}
	
	.button-container2 button:hover {
	    background-color: #0056b3;
	}

</style>
</head>

<body>
	 <div class="page-container">
	    <div class="container">
	        <h2>회원 정보</h2>
	        <p style="margin-bottom:30px;"><strong>ID:</strong> ${member.memberId }</p>
	        <p style="margin-bottom:30px;"><strong>이름:</strong> ${member.name }</p>
	        <p style="margin-bottom:30px;"><strong>전화번호:</strong> ${member.phone }</p>
	        <p style="margin-bottom:30px;"><strong>이메일:</strong> ${member.email }</p>
	        <p style="margin-bottom:30px;"><strong>주소:</strong> ${member.address }</p>
	        <p style="margin-bottom:30px;"><strong>상세주소:</strong> ${member.detailAddress }</p>
	    </div>
	</div>
        
    <div class="button-container2">
        <form id="deleteForm" action="/delete" method="post">
           <button type="submit">회원탈퇴</button>
        </form>
           <button onclick="location.href='/modifyMember'">회원정보 수정</button>
           <button onclick="location.href='/payedItemList'">주문 내역</button>
    </div>

    
    <script>
	    document.getElementById("deleteForm").addEventListener("submit", function(event) {
	        event.preventDefault(); // 폼의 기본 동작을 막음
	        if (confirm("탈퇴하시겠습니까?")) {
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "/delete", true);
	            xhr.onreadystatechange = function() {
	                if (xhr.readyState === XMLHttpRequest.DONE) {
	                    if (xhr.status === 200) {
	                        alert("회원탈퇴가 완료되었습니다.");
	                        window.location.href = '/';
	                    } else {
	                        alert("회원탈퇴 실패");
	                    }
	                }
	            };
	            xhr.send();
	        }
	    });
    </script>
</body>
</html>
