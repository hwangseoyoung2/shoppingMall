<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item List Page</title>
    <style>
   body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
   }

    .item-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-start;
        gap: 0px;
        padding: 0px;
    }

    .item {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 10px;
        flex: 1 1 calc(33.33% - 20px);
        max-width: calc(33.33% - 20px);
    }

    .item-title {
        font-size: 12px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 5px;
    }

    .item-content {
        font-size: 16px;
        text-align: center;
        margin-bottom: 10px;
    }

    .item-image {
        display: block;
        width: 300px;
        height: 300px;
        object-fit: cover;
        margin-top: 50px;
    }
    
     .item-price {
        font-size: 12px;
    }
    
    .item-title {
    	font-size: 14px;
    }
   </style>
</head>
    <div class="item-container">
        <c:forEach var="itemDTO" items="${listItem}">
            <div class="item">
                <c:choose>
                    <c:when test="${not empty itemDTO.images}">
                        <a href="itemContent?id=${itemDTO.id}">
                            <img class="item-image" src="/files/${itemDTO.images[0].fileName}" alt="Image">
                        </a>
                		<p class="item-title">${itemDTO.title}</p>
                		<p class="item-price"><fmt:formatNumber value="${itemDTO.price}" type="currency"/></p>
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
