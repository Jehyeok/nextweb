<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	/* System Name, CSS Version_Creater_Date */
	/* Common */ 
	body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textare a,button,select{margin:0;padding:0}
	body,input,textarea,select,button,table{font-family:'�뗭�',Dotum,AppleGothic,sans- serif;font-size:1em}
	img,fieldset{border:0}
	ul,ol{list-style:none}
	em,address{font-style:normal} a{text-decoration:none} a:hover,a:active,a:focus{text-decoration:underline}
	
	/* user custom */
	div#wrap {
		width : 800px;
		border : 1px solid red;
		margin-right : auto;
		margin-left : auto;
	}
	
	header > h1 {
		font-family : Raleway,Helvetica Neue,Helvetica,Arial,sans-serif;
		font-size : 4em;
		font-weight : 100; /*default value : 4000 */
		letter-spacing : 0.1em;
		text-align : center;
		margin-top : 100px;
	}
	
	#formArea textarea {
		width: 600px;
		margin : 20px 0px;
	}
	
	#formArea input[type=submit] , input[type=reset] {
		margin-top : 20px;
		padding : 5px;
	}
</style>
</head>
<body>
	<div id="wrap">
		<header>
			<h1>글쓰기 화면 입니다</h1>
		</header>
		<div id="formArea">
			<form action="/board/" method="post" enctype="multipart/form-data">
				제목 : <input type="text" name="title" size=40> <br />
				<textarea placeholder="글자를 미리 넣어보자" name="contents" rows="10" cols="50"></textarea> <br />
				<input type="file" name="file" size="50" /> <br />
				<input type="submit" />
				<input type="reset" />
			</form>
		</div>
	</div>
</body>
</html>