<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<section id=enroll-container>
	<h2>비밀번호 변경</h2>
	<form name="updatePwdFrm"
		action="<%=request.getContextPath()%>/member/updatePassword"
		method="post">
		<table>
			<tr>
				<th>현재 비밀번호</th>
				<td><input type="password" name="oldPassword" id="oldPassword"
					required></td>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td><input type="password" name="newPassword" id="newPassword"
					required></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="newPasswordCheck" required><br>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><input
					type="submit" value="변경" /></td>
			</tr>
		</table>
	</form>
</section>
<script>
	$(document.updatePwdFrm).submit(()=>{
		
		// 기존 패스워드와 동일한지
		const $password = $(newPassword);
		const $passwordCheck = $(newPasswordCheck);
		
		if(!/^[a-zA-Z0-9!@#$]{4,}$/.test($password.val())){
			alert("유효한 패스워드를 입력하세요.");
			return false;
		}
		if($password.val() != $passwordCheck.val()){
			alert("패스워드가 일치하지 않습니다.");
			return false;
		}	
	
	});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
