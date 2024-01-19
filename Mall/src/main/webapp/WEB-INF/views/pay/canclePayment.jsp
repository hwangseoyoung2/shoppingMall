<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 취소 요청</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0px;
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #ddd;
            background-color: #fff;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #B0B0B0;
            color: white;
        }

        .cancleContainer button {
            padding: 10px 20px;
            background-color: #C0C0C0;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

       .cancleContainer button:hover {
            background-color: #E0E0E0;
        }

        .cancleContainer input[type="text"] {
            padding: 10px;
            margin-top: 20px;
            margin-right:10px;
            width: 50%;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
	<h1 style="margin-top: 50px;">주문 취소 확인</h1>
	<div class="cancleContainer">
    <c:if test="${not empty payments}">
        <table>
            <tr>
                <th>결제일</th>
                <th>결제 번호</th>
                <th>금액</th>
                <th>상품명</th>
                <th>배송지</th>
            </tr>
            <c:forEach items="${payments}" var="payment">
                <tr>
                    <td>${payment.payedDate}</td>
                    <td>${payment.impUid}</td>
                    <td>${payment.amount}</td>
                    <td>${payment.name}</td>
                    <td>${payment.buyerAddr}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
	<input type="text" id="reason" name="reason" required placeholder="취소 사유를 입력하세요">
	<button onclick="initiateRefund('${payment.impUid}', ${payment.amount})">결제 취소</button><br>
    <button onclick="location.href='/'">홈으로 이동</button>
	</div>
	<script>

	    function initiateRefund() {
            var selectedPaymentImpUid = '${payments[0].impUid}';
            var selectedPaymentAmount = '${payments[0].amount}';
            var buyerName = '${payments[0].buyerName}';
            var buyerAddr = '${payments[0].buyerAddr}';
            var productName = '${payments[0].name}';
            var buyerTel = '${payments[0].buyerTel}';
            var buyerEmail = '${payments[0].buyerEmail}'

            var apiKey = '3570817181544746';
            var secretKey = 'hcMCT9jjBouLTkCfND4MJf8xK4vWjy0NGEFebDEEzf4MHVGFMKVQS3wWiSFYPSBwcokv1Q90qeUW18sO';

            var specificReason = document.getElementById("reason").value;
            var requestData = {
                impUid: selectedPaymentImpUid,
                cancel_request_amount: selectedPaymentAmount,
                reason: specificReason,
                buyerEmail: buyerEmail,
                buyerAddr: buyerAddr,
            	buyerName: buyerName,
                buyerTel: buyerTel,
                productName: productName,
            };

            getToken(apiKey, secretKey, function(token) {
                if (token) {
                    canclePayment(selectedPaymentImpUid, token, requestData);
                } else {
                    console.error('토큰 생성 실패');
                }
            });
        }

	    function getToken(apiKey, secretKey, callback) {
	        $.ajax({
	            type: "POST",
	            url: "/getToken",
	            data: JSON.stringify({ apiKey: apiKey, secretKey: secretKey }),
	            contentType: "application/json",
	            success: function(data) {
	                var token = data;
	                callback(token);
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.error("토큰 생성 중 오류 발생: " + errorThrown);
	                callback(null);
	            }
	        });
	    }

	    function canclePayment(impUid, token, requestData) {
	        $.ajax({
	            type: "POST",
	            url: "/payment/cancle/" + impUid,
	            headers: {
	                'Authorization': 'Bearer ' + token
	            },
	            data: JSON.stringify(requestData),
	            contentType: "application/json",
	            success: function(data) {
	                console.log('결제 취소 성공: ' + data);
	                alert("결제 취소가 완료되었습니다.");
	                window.location.href="/";
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.error("결제 취소 중 오류 발생: " + errorThrown);
	                alert("결제 취소 중 오류가 발생했습니다.");
	            }
	        });
	    }
    </script>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
</body>
</html>
