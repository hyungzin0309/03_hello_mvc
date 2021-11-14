<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	List<Member> list = (List<Member>)request.getAttribute("list");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 관리자용 admin.css link -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<style>
	/* 사용자 요청을 처리한 이후 선택이 그대로 남아있기 위함 */
    div#search-container {margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
    /* 처음 페이지에 진입했을 때 (searchType이 null일 때 아이디 검색창이 먼저 뜨도록 기본값 설정한 것) */
    div#search-memberId {display: <%=searchType == null ||"memberId".equals(searchType) ? "inline-block":"none"%>;}
    div#search-memberName{display: <%="memberName".equals(searchType) ? "inline-block":"none"%>;}
    div#search-gender{display: <%="gender".equals(searchType) ? "inline-block":"none"%>;}
</style>
<section id="memberList-container">
	<h2>회원관리</h2>
    <div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
        								<!-- 요청이 있은 이후에도 검색타입 선택 그대로 유지 -->
            <option value="memberId" <%="memberId".equals(searchType) ? "selected":"" %>>아이디</option>		
            <option value="memberName" <%="memberName".equals(searchType) ? "selected":"" %>>회원명</option>
            <option value="gender" <%="gender".equals(searchType) ? "selected":"" %>>성별</option>
        </select>
        <!-- 서치타입이 있으면서 해당 서치타입일 때, 서치키워드를 value값에 넣어 유지해 주면서 어떤 검색을 했는지 알 수 있도록 함 -->
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="memberId"/>
                <input type="text" name="searchKeyword" value="<%= "memberId".equals(searchType)?searchKeyword:"" %>" size="25" placeholder="검색할 아이디를 입력하세요."/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-memberName" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="memberName"/>
                <input type="text" name="searchKeyword" value="<%= "memberName".equals(searchType)?searchKeyword:"" %>" size="25" placeholder="검색할 이름을 입력하세요."/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-gender" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="gender"/>
                <input type="radio" name="searchKeyword" value="M" <%= "gender".equals(searchType) && "M".equals(searchKeyword)?"checked":""%>> 남
                <input type="radio" name="searchKeyword" value="F" <%= "gender".equals(searchType) && "F".equals(searchKeyword)?"checked":""%>> 여
                <button type="submit">검색</button>
            </form>
        </div>
    </div>
	
	<table id="tbl-member">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>회원권한</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>취미</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody>
<%  
	for(Member member : list){
%>
			<tr>
				<td><%= member.getMemberid() %></td>
				<td><%= member.getMemberName() %></td>
				<td>
				<!-- 사용자권한 바꾸기 -->
					<form 
						name="memberRoleUpdateFrm"
						action="<%= request.getContextPath() %>/admin/memberRoleUpdate"
						method="POST">
						<!-- 아이디값을 같이 전달하여 누구의 권한을 바꿀 것인지 알도록 함 -->
						<input type="hidden" name="memberId" value="<%= member.getMemberid() %>" />
						<select name="memberRole" class="member-role">
							<!-- 최대한 변수(상수) 사용하여 유지보수에 대비 -->              <!-- 처음엔 member의 기존 권한이 선택되어 나타나도록 기본값 설정 -->
							<option value="<%= MemberService.USER_ROLE %>" <%= MemberService.USER_ROLE.equals(member.getMemberRole()) ? "selected" : "" %>>일반</option>
							<option value="<%= MemberService.ADMIN_ROLE %>" <%= MemberService.ADMIN_ROLE.equals(member.getMemberRole()) ? "selected" : "" %>>관리자</option>
						</select>
					</form>
				</td>
				<td><%= member.getGender() %></td>
				<td><%= member.getBirthday() != null ? member.getBirthday() : "" %></td>
				<td><%= member.getEmail() != null ? member.getEmail() : "" %></td>
				<td><%= member.getPhone() %></td>
				<td><%= member.getAddress() != null ? member.getAddress() : "" %></td>
				<td><%= member.getHobby() != null ? member.getHobby() : "" %></td>
				<td><%= member.getEnrollDate() %></td>
			</tr>

<%
	}
%>
			
		</tbody>
	</table>
	<!-- 회원목록 바로 밑에 페이지바 위치시킴 -->
	<div id="pageBar">
		<%= request.getAttribute("pagebar") %>
	</div>
</section>
<script>
/* 검색타입 바뀌면 검색창 바뀌도록 함 */
$(searchType).change((e)=>{
	$(".search-type").hide();
	const v = $(e.target).val();
	$("#search-"+v).css("display","inline-block");
})
$(".member-role").change((e) => {
	const $select = $(e.target); // select
	const memberRole = $select.val();
	console.log(memberRole);
	if(confirm(`회원의 권한을 [\${memberRole}]로 변경하시겠습니까?`)){
		const $frm = $select.parent();
		$frm.submit();
	}
	else {
		// selected 초기값으로 복원
		/* selected속성이 있는 select의 자식요소의 selected속성을 true */
		$select.children("[selected]").prop("selected", true);
	}
	// 이게 가능한 이유 : 사용자가 선택을 바꾸더라도 당장 바뀌지 않고 confirm이 먼저임.
	// 즉, confirm까지 끝이나야지 사용자가 선택한 변환값으로 선택이 변환됨
	// 그렇기 때문에 confirm이 아직 끝나지 않은 시점 여전히 selected속성을 가지고 있는 기존의 선택값의 selected 속성을 다시 true로 설정함으로써
	// confirm이 끝나고 나서도 기존의 선택값이 유지되도록 하는 것
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>







