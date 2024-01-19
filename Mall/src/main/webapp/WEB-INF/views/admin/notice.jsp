<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
    
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h1.noticeName {
            color: #333;
            text-align: center;
            margin-top: 100px;
            font-size: 20px;
            margin-bottom: 60px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            border-spacing: 0;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #F0F0F0;
            font-size: 13px;
            border: none;
        }

        .btn-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .add-notice-btn {
            padding: 7px 10px;
            font-size: 14px;
            cursor: pointer;
            background-color: #E0E0E0;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-right:10px;
            color: black;
        }

        .add-notice-btn:hover {
            background-color: #C0C0C0;
        }
        
       a {
        	color: black;
	        text-decoration: none; 
	    }
	
	    a:visited {
	        color: black; 
	    }
	
	    a:hover {
	        color: black; 
	        text-decoration: none;
	    }
    </style>
</head>
<body>
    <div>
        <h1 class="noticeName">NOTICE</h1>
        <div class="btn-container">
            <c:if test="${not empty memberId and memberId eq 'admin'}">
                <a href="/noticeRegister" class="add-notice-btn">공지 등록</a>
            </c:if>
        </div>
        <table>
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 70%;">
                <col style="width: 20%;">
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>제목</th>
                    <th>작성자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${notice}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><a href="/noticeDetail?id=${notice.id}">${notice.title}</a></td>
                        <td>${notice.member.memberId}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
