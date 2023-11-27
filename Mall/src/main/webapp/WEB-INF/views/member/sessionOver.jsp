<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>세션만료 접근불가</title>
	</head>
	<body>
		<script>
			if('NO' == '${noSession}'){
				alert("로그인 후 이용이 가능한 서비스입니다.")
				location.href='login';
			}
			
			if('NO' == '${noPwUpdate}') {
				alert("")
			}
		</script>
		
	
	</body>
</html>