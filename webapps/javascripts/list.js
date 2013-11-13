/* global */
// 원하는 css 값 return 
function getCss(node, attr) {
	return node.style[attr];
}
// 원하는 css 값 set
function setCss(node, attr, value) {
	node.style[attr] = value;
}

/* Object */
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
		setCss(this.blackCover, 'display', 'none');
		setCss(this.body, 'overflow', 'scroll');
	},
	showNewLayer : function(e) {
		// 새롭게 뜨는 레이어로 전체 화면을 덮도록, width, height를 정한다.
		setCss(this.blackCover, 'width', window.innerWidth);
		setCss(this.blackCover, 'height', window.innerHeight);

		// 새로운 레이어에 뜨는 이미지의 크기를 기존 크기와 같게 정한다.
		setCss(this.newImageLayer, 'width', e.target.clientWidth);
		setCss(this.newImageLayer, 'height', e.target.clientHeight);
		// 이미지를 새로운 이미지 레이어의 배경으로 추가한다.
		setCss(this.newImageLayer, 'backgroundImage', 'url(' + e.target.src
				+ ')');
		// 'none'이었던 디스플레이 속성을 'block'으로 바꾼다.
		setCss(this.blackCover, 'display', 'block');
		// 기존 페이지에 스크롤이 되지 않도록 한다.
		setCss(this.body, 'overflow', 'hidden');
	},
	imgInit : function() {
		imgDivs = document.querySelectorAll('img');
		for ( var i = 0; i < imgDivs.length; i++) {
			// 이미지의 maxWidth를 750px로 정한다.
			setCss(imgDivs[i], 'maxWidth', '750px');
			// 이미지를 클릭하면 새로운 레이어에 이미지를 띄우도록 이벤트를 등록한다.
			imgDivs[i].addEventListener('click', this.showNewLayer.bind(this),
					false);
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
		this.blackCover.addEventListener('click', this.hideNewLayer.bind(this),
				false);
		this.newImageLayer.addEventListener('click', this.stopBubbling);
	}
}

var Comment = {
	toggleComments : function(e) {
		// 클릭한 게시글의 코맨트 div를 받아온다.
		var clickedComments = e.target.parentNode.parentNode.children[3];
		// 코멘트가 보인다면 안보이도록, 안보인다면 보이도록 한다.
		if (getCss(clickedComments, 'display') == 'block')
			setCss(clickedComments, 'display', 'none');
		else
			setCss(clickedComments, 'display', 'block');
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