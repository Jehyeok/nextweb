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
		<div id="postContainer">
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
						
						<div class="commentNum">
							<input type="hidden" value="${fn:length(board.comments)}" />
							댓글 : ${fn:length(board.comments)}
						</div>
						<div class="commentVisible">
							<a href="#">댓글 보이기</a>
						</div>
						<br />
						<div class="comments">
							<c:forEach items="${board.comments}" var="comment">
								<div class="commentContent">
									<input type="hidden" name="id" value="${comment.id}" />
									${comment.user.userId} : ${comment.contents}
									<div class="commentDelete">delete</div> 
								</div>
							</c:forEach>
							<div class="separator"> <hr /> </div>
							<form action="/board/${board.id}/reply" method="post">
								<input type="hidden" name="id" value="${board.id}" />
								<textarea name="contents"></textarea>
								<input type="submit" value="입력" /> <br />
								<hr />
							</form>
						</div>
					</div>
				</div>
				<br />
			</c:forEach>
		</div>
		<a href="/board">Home</a>
	</div>
	<div id="blackCover" style="position: fixed; display: none">
		<div id="newImageLayer"></div>
	</div>
</body>
<script type="text/javascript" src="/javascripts/list.js"></script>
<script type="text/javascript">
	/* Ajax를 이용한 댓글 등록 */
	function writeComments(e) {
		e.preventDefault();
		var eleForm = e.currentTarget.form; // form element
		var oFormData = new FormData(eleForm); // form data를 자동 등록
		var sID = eleForm[0].value;
		var url = "/board/" + sID + "/comments.json";
		
		var request = new XMLHttpRequest();
		request.open("POST", url, true);
		
		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
				var obj = JSON.parse(request.responseText);
				var eleCommentList = eleForm.parentNode;
				var hr = document.querySelectorAll('.separator');
				hr[sID-1].insertAdjacentHTML("beforebegin" , "<div>" + obj.user.userId + " : " + 
						obj.contents +"</div>");
				
				var commentNum = document.querySelectorAll('.commentNum');
				console.log(commentNum);
				console.log(commentNum[sID-1]);
				console.log(commentNum[sID-1].innerHTML);
				commentNum[sID-1].innerHTML = '댓글 : ' + (parseInt(commentNum[sID-1].innerHTML) + 1);
			}
		}
		request.send(oFormData);
	}

	var formList = document.querySelectorAll('.comments input[type=submit]');
	for (var j = 0; j < formList.length; j++) {
		formList[j].addEventListener('click', writeComments, false);
	}
	
	/* 게시판 Ajax 활용한 업로드 */
	var boardFormList = document.querySelector('#formArea input[type=submit]');
	function writeBoards(e) {
		e.preventDefault();
		var eleForm = e.currentTarget.form; // form element
		var oFormData = new FormData(eleForm); // form data를 자동 등록
		var url = "/board/post.json"
		
		var request = new XMLHttpRequest();
		request.open("POST", url, true);
		
		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
				var obj = JSON.parse(request.responseText);
		        var postList = document.querySelector('#postContainer');
		        postList.insertAdjacentHTML("beforeend", 
		        		'<div class="post">' +
							'<div class="title">' +
								'<a href="/board/${board.id}">제목 : ' + obj.title + '</a> <br />' +
							'</div>' +
							'<div class="imgDiv">' +
								'<img src="/images/' + obj.fileName + '/> <br />' +
							'</div>' +
							'<div class="content">' +
								'내용 : ' + obj.contents + '<br />' +
							'</div>' +
							'<hr />' +
							'<div class="commentList">' +
								'<div class="commentNum">댓글 : 0' + '</div>' +
							'<div class="commentVisible">' +
								'<a href="#">댓글 보이기</a>' + 
							'</div>' +
							'<br />' +
							'<div class="comments">' +
								'<hr id="separator" />' +
								'<form action="/board/' + obj.id +'/reply" method="post">' +
									'<input type="hidden" name="id" value="' + obj.id + '" />' +
									'<textarea name="contents"></textarea>' +
									'<input type="submit" value="입력" /> <br />' +
									'<hr />' +
								'</form>' +
							'</div>' +
						'</div>' +
					'</div>' +
					'<br />'
		        );
			}
		}
		request.send(oFormData);
	}
	boardFormList.addEventListener('click', writeBoards, false);
	
	/* 댓글 삭제 */
	function deleteComment(e) {
		var targetComment = e.currentTarget;
		var cID = e.currentTarget.parentNode.childNodes[1].value;
		var url = "/board/" + cID + "/delete";
		
		var request = new XMLHttpRequest();
		request.open("POST", url, true);
		
		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
				var delComment = targetComment.parentNode;
				delComment.parentNode.removeChild(delComment);
			}
		}
		request.send();
	}

	var commentList = document.querySelectorAll('.commentContent .commentDelete');
	for (var j = 0; j < commentList.length; j++) {
		commentList[j].addEventListener('click', deleteComment, false);
	}
</script>
</html>