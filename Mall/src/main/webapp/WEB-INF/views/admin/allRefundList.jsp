<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 취소 내역</title>
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
    .btn {
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
    <h2>주문 취소 내역</h2>

    <c:if test="${not empty refundList}">
        <table>
            <tr>
                <th>No</th>
                <th>결제번호</th>
                <th>상품명</th>
                <th>금액</th>
                <th>성함</th>
                <th>주소</th>
                <th>전화번호</th>
                <th>취소일자</th>
            </tr>
            <c:forEach items="${refundList.content}" var="refund" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td><a href="${pageContext.request.contextPath}/refundInfo?impUid=${refund.impUid}">${refund.impUid}</a></td>
                    <td>${refund.productName }</td>
                    <td>${refund.cancle_request_amount }</td>
                    <td>${refund.buyerName }</td>
                    <td>${refund.buyerAddr }</td>
                    <td>${refund.buyerTel }</td>
                    <td>${refund.cancleDate }</td>
                </tr>
            </c:forEach>
        </table>
         <div class="pagination-container">
	        <form:form method="get" action="/allRefundList" modelAttribute="refundList">
	            <div class="pagination">
	                <c:if test="${not refundList.first}">
	                    <a href="?page=${refundList.number - 1}">&lt;</a>
	                </c:if>
						<c:forEach begin="${Math.max(0, payments.number - 5)}" end="${Math.min(refundList.totalPages - 1, refundList.number + 5)}" step="1" varStatus="loop">
						    <c:choose>
						        <c:when test="${loop.index eq refundList.number}">
						            <span class="current-page">${loop.index + 1}</span>
						        </c:when>
						        <c:otherwise>
						            <a href="?page=${loop.index}">${loop.index + 1}</a>
						        </c:otherwise>
						    </c:choose>
						</c:forEach>
	                <c:if test="${not refundList.last}">
	                    <a href="?page=${refundList.number + 1}">&gt;</a>
	                </c:if>
	            </div>
	        </form:form>
	    </div>
    </c:if>

    <c:if test="${empty refundList}">
        <p>No refund List found.</p>
    </c:if>
    
    <div class="btn">
        <input type="button" class="back-button" onclick="location.href='/'" value="홈으로">
    </div>
</body>
</html>
