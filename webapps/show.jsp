<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	작성자 : ${sessionScope.userId} <br />
	제목 : ${board.title}
	<br /> 내용 : ${board.contents}
	<br /> 파일 :
	<img src="/images/${board.fileName}" />
	<br />
	<form action="/board/${id}/reply" method="post">
		<textarea name="contents"></textarea>
		<input type="submit" value="입력" /> <br />
		<hr />
	</form>
	<br />
	<c:forEach items="${board.comments}" var="comment">
		${comment.user.userId} : ${comment.contents} <br />
		<hr />
	</c:forEach>
	<a href="/"><button>home</button></a>
	<a href="/board/modify/${id}"><button>update</button></a>
	<form action="/board/delete/${id}" method="post">
		<input type="submit" value="delete" />
	</form>
</body>
</html>