package com.kh.mvc.member.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.kh.mvc.common.JdbcTemplate.getConnection;
import static com.kh.mvc.common.JdbcTemplate.close;
import static com.kh.mvc.common.JdbcTemplate.commit;
import static com.kh.mvc.common.JdbcTemplate.rollback;

import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.member.model.dao.MemberDao;
import com.kh.mvc.member.model.vo.Member;

public class MemberService {
	private MemberDao memberDao = new MemberDao();
	
	public static final String USER_ROLE = "U";
	public static final String ADMIN_ROLE = "A";

	public Member selectOneMember(String memberId) {
		
		// 1. Connection 객체 생성
		Connection conn = getConnection();
		System.out.println("id@MemberService.java : "+memberId);

		// 2. Dao에 쿼리실행 요청
		Member member = memberDao.selectOneMember(conn,memberId);
				
		// 3. Connection 객체 자원반납
		close(conn);
		return member;
	}
	public int enrollMember(Member member) {
		Connection conn = getConnection();
		int result = memberDao.enrollMember(conn, member);
		if(result > 0) 
			commit(conn);
		else rollback(conn);
		close(conn);
		return result ;
	}
	public int memberUpdate(Member member) {
		Connection conn = null;
		int result = 0;
		
		try {
			conn = getConnection();
			result = memberDao.updateMember(conn, member);
			commit(conn);
		}catch(Exception e) {
			e.printStackTrace();
			rollback(conn);
		}finally {
			close(conn);
		}
		
		return result;
	}
	public int memberWithdraw(String memberId) {
		Connection conn = null;
		int result = 0;
		
		try {
			conn = getConnection();
			result = memberDao.memberWithdraw(memberId,conn);
			commit(conn);
		}catch(Exception e) {
			e.printStackTrace();
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}
	public List<Member> selectAllMember(Map<String, Object> param) {
		
		Connection conn = getConnection();
		List<Member> list = memberDao.selectAllMember(conn,param);			
		close(conn);
		return list;
	}
	public int updateMemberRole(Member member) {
		Connection conn = null;
		int result = 0;
		
		try {
			conn = getConnection();
			result = memberDao.updateMemberRole(member,conn);
			commit(conn);
			
		}catch(Exception e){
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}
	public int updatePassword(Member updateMember) {
		Connection conn = null;
		int result = 0;
		
		try {
			conn = getConnection();
			result = memberDao.updatePassword(conn, updateMember);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}
	public List<Member> searchMember(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> list = memberDao.searchMember(param,conn);
		close(conn);
		return list;
	}
	public int selectTotalMemberCount() {
		Connection conn = getConnection();
		int totalCount = memberDao.selectTotalMemberCount(conn);
		close(conn);
		return totalCount;
	}


}
