<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${boards}" var="board">
제목 : ${board.title} <br />
내용 : ${board.contents} <br />
파일 : <img src="/images/${board.fileName}" /> <br />
<a href="/board/${board.id}">detail</a> <br />
</c:forEach>
<a href="/"><button>home</button></a>
</body>
</html>