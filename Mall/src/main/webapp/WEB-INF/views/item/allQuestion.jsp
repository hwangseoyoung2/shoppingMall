<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 문의</title>
    <style>
        h1.qnaName {
            color: #333;
            text-align: center;
            margin-top: 80px;
            font-size:22px;
        }

		.input-button-style,
		.button-container2 .qnaBtn {
		    padding: 10px 20px;
		    font-size: 13px;
		    cursor: pointer;
		    background-color: #D3D3D3;
		    color: #fff;
		    border: none;
		    border-radius: 4px;
		    margin-top: 20px;
		}
		
		.button-container2 {
		    display: flex;
		    justify-content: center;
		    margin-top: 20px;
		}


		.input-button-style:hover,
		.button-container2 .qnaBtn:hover {
		    background-color: #E3E3E3;
		}

        h2 {
            color: #333;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
            
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #E3E3E3;
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
            background-color: #D3D3E3;
        }

        .pagination .current-page {
            background-color: #D3D3E3;
            color: #333;
            padding: 2px 6px;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .button-container2 {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        .searchForm {
            float: right;
            margin-top: 20px;
            margin-right: 30px;
            margin-bottom:30px;
            display: flex;
    		align-items: center;
        }
        #searchCategory {
		    padding: 8px;
		    font-size: 13px;
		}
		
		#searchField {
		    padding: 8px;
		    font-size: 13px;
		}
        
	.searchForm input[type="submit"] {
	    padding: 7px 20px;
	    font-size: 13px;
	    cursor: pointer;
	    background-color: #fff;
	    color: black;
	    border: 1px solid #C3C3C3;
	    border-radius: 0;
	    margin-left: 10px;
	}

    </style>
</head>
<body>
    <h1 class="qnaName">전체 문의 목록</h1>
    <div class="searchForm">
	    <form action="${pageContext.request.contextPath}/searchQnA" method="get">
			<select id="searchCategory" name="searchCategory">
			    <option value="전체">전체</option>
			    <option value="category">질문 유형</option>
			    <option value="itemTitle">상품명</option>
			    <option value="userName">작성자</option>
			</select>
			<input type="text" id="searchField" name="searchField">
	
	        <input type="submit" value="검색">
	    </form>
    </div>
    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>질문 유형</th>
                <th>상품명</th>
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
                    <td>${q.item.title }</td>
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
    <div class="button-container2">
        <input type="button" class="input-button-style" value="상품 문의 등록" onclick="location.href='/itemQnARegister?id=${itemId}'">
        <input type="button" class="qnaBtn" value="홈으로" onclick="location.href='/'">
    </div>
</body>
</html>
