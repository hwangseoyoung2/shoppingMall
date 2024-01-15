<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체 주문 내역</title>
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
        width: 80%;
        margin: 20px auto;
        margin-top: 50px;
        border-collapse: collapse;
        background-color: #fff;
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
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .button-container {
        text-align: center;
        margin-top: 20px;
    }
    .back-button {
        background-color: #D3D3D3;
        color: #333;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }
    
    .pagination-container {
    text-align: center;
    margin-top: 20px;
	}
	
	.pagination a, .pagination span {
	    color: #333;
	    padding: 8px 16px;
	    text-decoration: none;
	    border: 1px solid #ddd;
	    margin: 0 4px;
	    cursor: pointer;
	}
	
	.pagination a:hover {
	    background-color: #D3D3D3;
	}
	
	.pagination .current-page {
	    background-color: #D3D3D3;
	    color: #333;
	    padding: 8px 16px;
	    border: 1px solid #ddd;
	    margin: 0 4px;
	}
	    
</style>

</head>
<body>
    <h1>주문 내역</h1>

    <c:if test="${not empty payments}">
        <table>
            <tr>
                <th>No</th>
                <th>결제번호</th>
                <th>결제 금액</th>
                <th>날짜</th>
                <th>아이디</th>
                <th>이름</th>
            </tr>
            <c:forEach items="${payments.content}" var="payment" varStatus="loop">
                <tr>
                    <td>${loop.index + payments.number * payments.size + 1}</td>
                    <td><a href="${pageContext.request.contextPath}/payedInfo?impUid=${payment.impUid}">${payment.impUid}</a></td>
                    <td>${payment.amount}</td>
                    <td>${payment.payedDate}</td>
                    <td>${payment.buyerId}</td>
                    <td>${payment.buyerName}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="pagination-container">
	        <form:form method="get" action="/allPayedList" modelAttribute="payments">
	            <div class="pagination">
	                <c:if test="${not payments.first}">
	                    <a href="?page=${payments.number - 1}">&lt;</a>
	                </c:if>
						<c:forEach begin="${Math.max(0, payments.number - 5)}" end="${Math.min(payments.totalPages - 1, payments.number + 5)}" step="1" varStatus="loop">
						    <c:choose>
						        <c:when test="${loop.index eq payments.number}">
						            <span class="current-page">${loop.index + 1}</span>
						        </c:when>
						        <c:otherwise>
						            <a href="?page=${loop.index}">${loop.index + 1}</a>
						        </c:otherwise>
						    </c:choose>
						</c:forEach>
	                <c:if test="${not payments.last}">
	                    <a href="?page=${payments.number + 1}">&gt;</a>
	                </c:if>
	            </div>
	        </form:form>
	    </div>
    </c:if>

    <c:if test="${empty payments}">
        <p>No payments found.</p>
    </c:if>
    
    <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/'" value="홈으로">
    </div>
</body>
</html>
