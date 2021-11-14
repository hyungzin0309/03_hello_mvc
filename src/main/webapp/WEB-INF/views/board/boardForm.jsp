<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />

<script>
/**
* boardEnrollFrm 유효성 검사
*/
function boardValidate(){
	const $title = $("[name=title]");
	const $title = $("[name=content]");
	
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test($title.val()))){ // 아무 글자도 안썼으면 alert
		alert("제목을 입력하세요.");
		return false;
	}			   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	//\n은 . 에 포함되지 않기 때문에 따로 작성해줘야 함
	if(!/^(.|\n)+$/.test($title.val())){
		alert("내용을 작성하세요.");
		return false;
	}
	
	
	return true;
}

$(document.boardEnrollForm).submit(boardValidate);
</script>
<section id="board-container">
<h2>게시판 작성</h2>
<form
	name="boardEnrollFrm"
	action="<%=request.getContextPath() %>/board/boardEnroll" 
	method="post"
	enctype = "multipart/form-data">
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%=loginMember.getMemberid() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>			
			<input type="file" name="upFile1">
			<br>
			<input type="file" name="upFile2">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기">
		</th>
	</tr>
</table>
</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
