<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <script>
        // 페이지가 로드될 때 바로 alert를 표시하고 페이지 이동
        window.onload = function() {
            alert("로그인이 만료되었습니다.");
            window.location.href = "/"; // 원하는 URL로 변경
        }
    </script>
</body>
</html>