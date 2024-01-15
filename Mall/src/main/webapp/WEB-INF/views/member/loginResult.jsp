<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Result</title>
</head>
<body>
		<script>
			if('OK' == '${result}'){
				alert("로그인 완료!")
				location.href='/';
			}else if('FAIL' == '${result}'){
				alert("아이디 또는 비밀번호를 확인하세요.")
				history.go(-1);
			}else if('NONE_ID' == '${result}'){
				alert("아이디 또는 비밀번호를 확인하세요.")
				history.go(-1);
			}
			
			//myPage 로그인 상태 확인
			if('notOK' === '${myResult}') {
				alert("로그인 후 이용이 가능한 서비스입니다")
				location.href='/login';
			}
			
			//로그아웃
			if('LOGOUT_SUCCESS'=='${result}') {
				alert("로그아웃 되었습니다")
				location.href='/';
			}
			
			if('notOK' === '${accessQnA}') {
				alert("접근 불가능한 게시글입니다")
				 window.history.back();
			}
			
			if('notOK' === '${accessAnswer}') {
				alert("삭제 권한이 없습니다")
			}
		</script>
		
</body>
</html>
