<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>결제 상세 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding: 10px;
        }
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            margin-top: 100px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #D3D3D3;
            color: #333;
        }
	    .button-container {
	        text-align: center;
	        margin-top: 40px;
	    }
	    .back-button {
	        background-color: #D3D3D3;
	        color: #333;
	        padding: 10px 20px;
	        border: none;
	        cursor: pointer;
	        margin-left:20px;
	    }
    </style>
</head>
<body>
	    <h1>결제 상세 정보</h1>
    <c:if test="${not empty paymentUid}">
        <table>
	        <c:forEach items="${paymentUid}" var="payment">
	            <tr>
	                <th>결제번호</th>
	                <td>${payment.impUid}</td>
	            </tr>
	            <tr>
	            	<th>아이디</th>
	            	<td>${payment.buyerId}</td>
	            </tr>
	            <tr>
	                <th>이메일</th>
	                <td>${payment.buyerEmail }</td>
	            </tr>
	            <tr>
	                <th>이름</th>
	                <td>${payment.buyerName}</td>
	            </tr>
	            <tr>
	                <th>전화번호</th>
	                <td>${payment.buyerTel }</td>
	            </tr>
	            <tr>
	                <th>배송지</th>
	                <td>${payment.buyerAddr }</td>
	            </tr>
	            <tr>
	                <th>상품명</th>
	                <td>${payment.name }</td>
	            </tr>
	            <tr>
	                <th>결제 금액</th>
	                <td>${payment.amount}원</td>
	            </tr>
	            <tr>
	                <th>날짜</th>
	                <td>${payment.payedDate}</td>
	            </tr>
	            <tr>
	                <th>결제 수단</th>
	                <td>${payment.pay_method }</td>
	            </tr>
	        </c:forEach>
        </table>
    </c:if>
    
   <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/'" value="홈으로">
    	<input type="button" class="back-button" onclick="goBack()" value="뒤로 가기">
   </div>
</body>

<script>
        function goBack() {
            window.history.back();
        }
</script>
</html>