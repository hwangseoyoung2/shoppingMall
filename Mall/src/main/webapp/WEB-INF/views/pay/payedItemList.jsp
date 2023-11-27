<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="com.project.mall.entity.Payment" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    h3 {
        text-align: center;
        background-color: #f4f4f4;
        color: #333;
        padding: 20px;
        margin-top:70px;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        margin-top:40px;
    }

    th, td {
        padding: 12px;
        text-align: left;
    }

    th {
        background-color: #D3D3D3;
        color: #333;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    p {
        text-align: center;
        margin: 20px;
    }

    .itemList input[type="button"] {
        background-color: #D3D3D3;
        color: #333;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 16px;
        margin: 20px auto;
        display: block;
    }
</style>
</head>
<body>
    <h3>주문 내역</h3>
	<div class="itemList">
	    <c:if test="${not empty payments}">
	        <table>
	            <tr>
	            	<th>결제일</th>
	                <th>결제 번호</th>
	                <th>금액</th>
	                <th>상품명</th>
	                <th>배송지</th>
	                <th></th>
	            </tr>
	            <c:forEach items="${payments}" var="payment">
	                <tr>
	                	<td>${payment.payedDate }</td>
	                    <td>${payment.impUid}</td>
	                    <td>${payment.amount}</td>
	                    <td>${payment.name}</td>
	                    <td>${payment.buyerAddr}</td>
	                    <td>
	                    	<input type="hidden" name="id" value="${payment.id}">
	            			<button onclick="location.href='/canclePayment?id=${payment.id}'" style="padding: 5px 10px;">결제 취소</button>
	        			</td>
	                </tr>
	            </c:forEach>
	        </table>
	    </c:if>
	
	    <input type="button" value="홈으로 이동" onclick="location.href='/'">
	</div>
    <c:if test="${empty payments}">
        <p>No payments found.</p>
    </c:if>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>	    
</body>
</html>
