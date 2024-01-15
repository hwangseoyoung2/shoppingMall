<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0px;
            text-align: center;
    }

    .item-container {
        display: flex;
        flex-wrap: wrap;
        text-align: center;
    }

    .item {
        width: 25%;
        margin: 10px;
    }

    .item-image {
        width: 250px;
        height: 350px;
        object-fit: cover;
        margin-top: 50px;
    }

    .item-title {
        font-size: 14px;
    }

    .item-price {
        font-size: 12px;
    }
</style>
</head>
<body>
    <h1></h1>
    <div class="item-container">
        <c:forEach var="products" items="${products}">
            <div class="item">
                <c:choose>
                    <c:when test="${not empty products.images}">
                        <a href="itemContent?id=${products.id}">
                            <img class="item-image" src="/files/${products.images[0].fileName}" alt="Image">
                        </a>
                        <p class="item-title">${products.title}</p>
                        <p class="item-price"><fmt:formatNumber value="${products.price}" type="currency"/></p>
                    </c:when>
                    <c:otherwise>
                        <p>No Image</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>
</body>
</html>
