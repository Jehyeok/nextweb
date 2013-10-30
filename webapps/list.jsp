<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/list.css" />
<title>Insert title here</title>
<style>

</style>
</head>
<body>
	<div id="wrap">
		<div id="formArea">
			<form action="/board/" method="post" enctype="multipart/form-data">
				제목 : <input type="text" name="title" size=40> <br />
				<textarea width="750px" placeholder="글자를 미리 넣어보자" name="contents"
					rows="10" cols="50"></textarea>
				<br /> <input type="file" name="file" size="50" /> <br /> <input
					type="submit" /> <input type="reset" />
			</form>
		</div>
		<br />
		<c:forEach items="${boards}" var="board">
			<div class="post">
				<div class="title">
					제목 : ${board.title} <br />
				</div>
				<div class="imgDiv">
					<img src="/images/${board.fileName}" /> <br />
				</div>
				<div class="content">
					내용 : ${board.contents} <br />
				</div>
				<hr />
				<c:forEach items="${board.comments}" var="comment">
					${comment.user.userId} : ${comment.contents} <br />
				</c:forEach>
				<hr />
				<form action="/board/${board.id}/reply" method="post">
					<textarea name="contents"></textarea>
					<input type="submit" value="입력" /> <br />
					<hr />
				</form>
				<a href="/board/${board.id}">detail</a> <br />
			</div>
			<br />
		</c:forEach>
		<a href="/"><button>home</button></a>
	</div>
</body>
<script>
	var imgDivs = document.querySelectorAll('img');
	for ( var i = 0; i < imgDivs.length; i++) {
		imgDivs[i].style.maxWidth = '750px';
	}
</script>
</html>