<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 구매 내역</title>
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
</style>

</head>
<body>
    <h1>회원 구매 내역</h1>

	 <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/adminCheckMember'" value="일반회원" style="margin-right: 30px;">
        <input type="button" class="back-button" onclick="location.href='/adminCheckKakaoMember'" value="카카오회원">
    </div>
    <c:if test="${not empty paymentList}">
        <table>
            <tr>
                <th>구매 번호</th>
                <th>구매자</th>
                <th>연락처</th>
                <th>상품명</th>
                <th>금액</th>
                <th>결제일</th>
                <th>주소</th>
            </tr>
            <c:forEach items="${paymentList }" var="member">
                <tr>
                    <td>${member.impUid}</td>
                    <td>${member.buyerName}</td>
                    <td>${member.buyerTel}</td>
                    <td>${member.name}</td>
                    <td>${member.amount }</td>
                    <td>${member.payedDate }</td>
                    <td>${member.buyerAddr}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <c:if test="${empty paymentList}">
        <p>No member found.</p>
    </c:if>
    
    <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/'" value="홈으로">
    </div>
</body>
</html>
