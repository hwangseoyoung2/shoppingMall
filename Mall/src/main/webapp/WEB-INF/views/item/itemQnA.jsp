<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 문의</title>
    <style>
	    body {
	      font-family: Arial, sans-serif;
	      margin: 0;
	      padding: 0;
	      background-color: #f4f4f4;
	    }

        h2 {
            color: #333;
            text-align: center;
        }

        h3 {
            color: #333;
            margin-top: 120px;
        }

        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 10px;
            margin: 0 auto;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #B3B3B3;
        }

        a {
            text-decoration: none;
            color: #3498db;
        }

        a:hover {
            text-decoration: underline;
        }

        .answered {
            color: green;
            font-weight: bold;
        }

        .unanswered {
            color: red;
            font-weight: bold;
        }

        .qna-button-container input[type="button"]{
		     background-color: #B0B0B0;
		     color: #fff;
		     border: none;
		     padding: 10px 20px;
		     cursor: pointer;
		     border-radius: 5px;
		     margin-top: 30px;
		     float: center;
		     margin-left: 10px;
        }
        
        .qna-button-container input[type="button"]:hover {
        	background-color: #C0C0C0;
        }

        .pagination-container {
            text-align: center;
            margin-top: 50px;
        }

        .pagination a, .pagination span {
            color: #333;
            padding: 2px 6px;
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
            padding: 2px 6px;
            border: 1px solid #ddd;
            margin: 0 4px;
        }
    </style>
</head>
<body>
    <h3>상품 문의 목록</h3>
    <div class="qna">
	    <table>
	        <thead>
	            <tr>
	                <th>No</th>
	                <th>질문 유형</th>
	                <th>작성자</th>
	                <th>작성일</th>
	                <th>답변 여부</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="q" items="${question.content}" varStatus="loopStatus">
	                <tr>
	                    <td>${loopStatus.index + 1}</td>
	                    <td><a href="itemQnADetail?id=${q.id}">${q.category}</a></td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${not empty q.member}">
	                                ${q.member.memberId}
	                            </c:when>
	                            <c:otherwise>
	                                ${q.kakaoUser.userId}
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td>${q.createdDate}</td>
	                    <td class="${empty q.answers ? 'unanswered' : 'answered'}">
	                        ${empty q.answers ? 'N' : 'Y'}
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    </div>
    <div class="pagination-container">
        <c:if test="${question.totalPages gt 1}">
            <div class="pagination">
                <c:if test="${not question.first}">
				    <a href="?id=${itemId}&page=${question.number - 1}">&lt;</a>
				</c:if>
				<c:forEach begin="${Math.max(0, question.number - 5)}" end="${Math.min(question.totalPages - 1, question.number + 5)}" step="1" varStatus="loop">
				    <c:choose>
				        <c:when test="${loop.index eq question.number}">
				            <span class="current-page">${loop.index + 1}</span>
				        </c:when>
				        <c:otherwise>
				            <a href="?id=${itemId}&page=${loop.index}">${loop.index + 1}</a>
				        </c:otherwise>
				    </c:choose>
				</c:forEach>
				<c:if test="${not question.last}">
				    <a href="?id=${itemId}&page=${question.number + 1}">&gt;</a>
				</c:if>
            </div>
        </c:if>
    </div>
    <div class="qna-button-container">
        <input type="button" value="상품 문의 등록" onclick="location.href='/itemQnARegister?id=${itemId}'">
        <input type="button" value="뒤로 가기" onclick="history.go(-1)">
    </div>
</body>
</html>
