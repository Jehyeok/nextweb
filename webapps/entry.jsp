<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${not empty sessionScope.userId}">
			<form action="/logout" method="post">
				<input type="submit" value="logout" />
			</form>
			<a href="/board/form">글쓰기</a>
			<a href="/board/list">리스트</a>
		</c:when>
		<c:otherwise>
			<form action="/signin" method="post">
				ID:<input type="text" name="userId" /> PW:<input type="password"
					name="password" /> <input type="submit" value="login" />
			</form>
			<a href="/join"><button>회원가입</button></a>
		</c:otherwise>
	</c:choose>
</body>
</html>