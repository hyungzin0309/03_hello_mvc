<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    boolean available = (boolean)request.getAttribute("available");
	String memberId = request.getParameter("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디중복검사</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<style>
div#checkId-container{text-align:center; padding-top:50px;}
span#duplicated{color:red; font-weight:bold;}
</style>
</head>
<body>
	<div id="checkId-container"></div>
	<%if(available){ %>
	[<span><%=memberId %></span>]는 사용가능한 아이디입니다.
	<br /><br />
	<button onclick="popupClose();">닫기</button>
	<%}else{ %>
	[<span><%=memberId %></span>]는 이미 사용중인 아이디입니다.
	<br /><br />
	<form 
	name="checkIdDuplicateFrm" 
	action="<%= request.getContextPath() %>/member/checkIdDuplicate"
	method="GET">
	<input name="memberId" placeholder="아이디를 입력하세요."/>
	<input type="submit" value="아이디 중복검사"/>
	</form>
	<%} %>
</body>
<script>
	const popupClose = () => {
		//opener는 popup창을 생성한 페이지의 window객체
		const $frm = $(opener.document.memberEnrollFrm);
		$frm.find("[name=memberId]").val("<%=memberId%>");
		$frm.find("#idValid").val(1);
		
		close();
	}
</script>
</html>
