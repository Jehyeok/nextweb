<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" media="screen" type="text/css"
	href="/stylesheets/list.css" />
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
		<c:forEach items="${boards}" var="board" varStatus="status">
			<div class="post">
				<div class="title">
					<a href="/board/${board.id}">제목 : ${board.title}</a> <br />
				</div>
				<div class="imgDiv">
					<img src="/images/${board.fileName}" /> <br />
				</div>
				<div class="content">
					내용 : ${board.contents} <br />
				</div>
				<hr />
				<div class="commentList">
					<div class="commentNum">댓글 : ${fn:length(board.comments)}</div>
					<div class="commentVisible">
						<a href="#">댓글 보이기</a>
					</div>
					<br />
					<div class="comments">
						<c:forEach items="${board.comments}" var="comment">
						${comment.user.userId} : ${comment.contents} <br />
						</c:forEach>
						<hr />
						<form action="/board/${board.id}/reply" method="post">
							<textarea name="contents"></textarea>
							<input type="submit" value="입력" /> <br />
							<hr />
						</form>
					</div>
				</div>
			</div>
			<br />
		</c:forEach>
		<a href="/"><button>home</button></a>
	</div>
	<div id="blackCover" style="position: fixed; display: none">
		<div id="newImageLayer"></div>
	</div>
</body>
<script type="text/javascript" src="/javascripts/list.js"></script>
</html>