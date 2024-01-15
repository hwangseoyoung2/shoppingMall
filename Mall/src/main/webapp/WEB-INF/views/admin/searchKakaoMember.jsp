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
    
    .search-button {
	    background-image: url('/image/search.png');
	    width: 24px;
	    height: 24px;
	    border: none;
	    cursor: pointer;
	    background-size: cover;
	    margin-right:20px;
	    margin-left:5px;
	}
	.search-container {
	    display: flex;
	    margin-right: 20px;
	}
</style>

</head>
<body>
    <h1>회원 리스트</h1>

	 <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/adminCheckMember'" value="일반회원" style="margin-right: 30px;">
        <input type="button" class="back-button" onclick="location.href='/adminCheckKakaoMember'" value="카카오회원">
    </div>
    <div id="search-container">
        <form action="/searchKakaoMember" method="get">
	        <input type="text" name="keyword" placeholder="이름 검색" style="margin-left:1300px">
	        <input type="submit" class="search-button" value="">
    	</form>
    </div>
    <c:if test="${not empty kakaoUser}">
        <table>
            <tr>
                <th>이메일</th>
                <th>아이디</th>
                <th>이름</th>
            </tr>
            <c:forEach items="${kakaoUser.content }" var="kakaoUser">
                <tr>
                    <td><a href="${pageContext.request.contextPath}/selectOneKakaoMember?userId=${kakaoUser.email}">${kakaoUser.email}</a></td>
                    <td>${kakaoUser.userId}</td>
                    <td>${kakaoUser.name}</td>
                </tr>
            </c:forEach>
        </table>
	         <div class="pagination-container">
		        <form:form method="get" action="/searchKakaoMember" modelAttribute="kakaoUser">
		            <div class="pagination">
		                <c:if test="${not kakaoUser.first}">
		                    <a href="?page=${kakaoUser.number - 1}">&lt;</a>
		                </c:if>
							<c:forEach begin="${Math.max(0, kakaoUser.number - 5)}" end="${Math.min(kakaoUser.totalPages - 1, kakaoUser.number + 5)}" step="1" varStatus="loop">
							    <c:choose>
							        <c:when test="${loop.index eq kakaoUser.number}">
							            <span class="current-page">${loop.index + 1}</span>
							        </c:when>
							        <c:otherwise>
							            <a href="?page=${loop.index}">${loop.index + 1}</a>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>
		                <c:if test="${not kakaoUser.last}">
		                    <a href="?page=${kakaoUser.number + 1}">&gt;</a>
		                </c:if>
		            </div>
		        </form:form>
		    </div>
    </c:if>

    <c:if test="${empty kakaoUser}">
        <p>No member found.</p>
    </c:if>
    
    <div class="button-container">
        <input type="button" class="back-button" onclick="location.href='/'" value="홈으로">
    </div>
</body>
</html>
