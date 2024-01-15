<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>결제 취소 상세 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h2 {
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
	    .button-container2 {
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
	    <h2>결제 취소 상세 정보</h2>
    <c:if test="${not empty refundUid}">
        <table>
	        <c:forEach items="${refundUid}" var="refund">
	            <tr>
	                <th>결제번호</th>
	                <td>${refund.impUid}</td>
	            </tr>
	            <tr>
	                <th>이메일</th>
	                <td>${refund.buyerEmail }</td>
	            </tr>
	            <tr>
	                <th>이름</th>
	                <td>${refund.buyerName}</td>
	            </tr>
	            <tr>
	                <th>전화번호</th>
	                <td>${refund.buyerTel }</td>
	            </tr>
	            <tr>
	                <th>배송지</th>
	                <td>${refund.buyerAddr }</td>
	            </tr>
	            <tr>
	                <th>상품명</th>
	                <td>${refund.productName }</td>
	            </tr>
	            <tr>
	                <th>결제 금액</th>
	                <td>${refund.cancle_request_amount}원</td>
	            </tr>
	            <tr>
	                <th>날짜</th>
	                <td>${refund.cancleDate}</td>
	            </tr>
	        </c:forEach>
        </table>
    </c:if>
    
   <div class="button-container2">
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