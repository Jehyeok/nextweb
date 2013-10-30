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
<script>
	var Board = {
			// 이미지를 눌렀을 때 새로 뜨는 레이어 
			blackCover : document.querySelector('#blackCover'),
			// 새로운 위에 올라가는 이미지 div 
			newImageLayer : document.querySelector('#newImageLayer'),
			// body 태그 
			body : document.querySelector('body'),
			stopBubbling : function(e) {
				e.stopPropagation();
			},
			hideNewLayer : function(e) {
				this.blackCover.style.display = 'none';
				this.body.style.overflow = 'scroll';
			},
			showNewLayer : function(e) {
				// 새롭게 뜨는 레이어로 전체 화면을 덮도록, width, height를 정한다. 
				this.blackCover.style.width = window.innerWidth;
				this.blackCover.style.height = window.innerHeight;
				
				// 새로운 레이어에 뜨는 이미지의 크기를 기존 크기와 같게 정한다. 
				this.newImageLayer.style.width = e.target.clientWidth;
				this.newImageLayer.style.height = e.target.clientHeight;
				// 이미지를 새로운 이미지 레이어의 배경으로 추가한다. 
				this.newImageLayer.style.backgroundImage = 'url('+e.target.src+')';
				// 'none'이었던 디스플레이 속성을 'block'으로 바꾼다. 
				this.blackCover.style.display = 'block';
				// 기존 페이지에 스크롤이 되지 않도록 한다. 
				this.body.style.overflow = 'hidden';
			},
			imgInit : function() {
				imgDivs = document.querySelectorAll('img');
				for ( var i = 0; i < imgDivs.length; i++) {
					// 이미지의 maxWidth를 750px로 정한다. 
					imgDivs[i].style.maxWidth = '750px';
					// 이미지를 클릭하면 새로운 레이어에 이미지를 띄우도록 이벤트를 등록한다. 
					imgDivs[i].addEventListener('click', this.showNewLayer.bind(this), false);
				}
			},
			preventATagScrollInit : function() {
				// 모든 a 태그를 받아온다. 
				var aTag = document.querySelectorAll('a');
				for ( var i = 0; i < aTag.length; i++) {
					aTag[i].addEventListener('click', function() {
						// a 태그를 클릭해도 자동으로 스크롤 되지 않도록 한다.
						window.event.preventDefault();
					}, false);
				}
			},
			init : function() {
				// 이미지 max width 설정 && 클릭하면 새로운 레이어 띄우는 이벤트 등록 
				this.imgInit();
				// comments visibility 버튼 등록
				// a tag 기본 스크롤 이벤트 삭제
				this.preventATagScrollInit();
				this.blackCover.addEventListener('click', this.hideNewLayer.bind(this), false);
				this.newImageLayer.addEventListener('click', this.stopBubbling);
			}
	}
	
	Comment = {
		toggleComments : function(e) {
			// 클릭한 게시글의 코맨트 div를 받아온다. 
			var clickedComments = e.target.parentNode.parentNode.children[3];
			// 코멘트가 보인다면 안보이도록, 안보인다면 보이도록 한다. 
			if (clickedComments.style.display == 'block') clickedComments.style.display = 'none';
			else clickedComments.style.display = 'block';
		},
		commentToggleBtnInit : function() {
			// 커멘트들의 visibility를 toggle하는 버튼을 받아온다. 
			var commentBtn = document.querySelectorAll('.commentVisible a');
			for ( var i = 0; i < commentBtn.length; i++) {
				// toggle하는 이벤트를 각각의 버튼에 등록한다. 
				commentBtn[i].addEventListener('click', this.toggleComments, false);
			}
		},
		init : function() {
			this.commentToggleBtnInit();
		}
	}
	Board.init();
	Comment.init();
</script>
</html>