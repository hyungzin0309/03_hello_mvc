package com.kh.mvc.member.model.dao;

import static com.kh.mvc.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.mvc.board.model.exception.BoardException;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.member.model.exception.MemberException;
import com.kh.mvc.member.model.vo.Member;

public class MemberDao {
	private Properties prop = new Properties();
	
	public MemberDao() {
		final String sqlConfigPath = MemberDao.class.getResource("/member_query.properties").getPath();
		System.out.println("sqlConfigPath@MemberDao = "+sqlConfigPath);
		try {
			prop.load(new FileReader(sqlConfigPath));
			System.out.println("prop@MemberDao = "+prop);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
	}
	
	/*
	 * DQL
	 * - PreparedStatement
	 * - sql:String
	 * - ResultSet
	 * - Member
	 */
	public Member selectOneMember(Connection conn, String memberId) {
		Member member = null;
		String sql = prop.getProperty("selectOneMember");
		PreparedStatement pstmt = null;
		ResultSet rSet = null;
		System.out.println("memberId@MemberDao = "+memberId);
		try {
			pstmt = conn.prepareStatement(sql);
			System.out.println("pstmt@MemberDao = "+pstmt);
			System.out.println("sql@MemberDao = "+sql);
			pstmt.setString(1, memberId);
			rSet = pstmt.executeQuery();
			System.out.println("rSet@MemberDao = "+rSet);
			while(rSet.next()) {
				String id = rSet.getString("member_id");
				System.out.println("memberId@MemberDao = "+id);
				String pwd = rSet.getString("password");
				String name = rSet.getString("member_name");
				String role = rSet.getString("member_role");
				String gender = rSet.getString("gender");
				Date BD = rSet.getDate("birthday");
				String email = rSet.getString("email");
				String phone = rSet.getString("phone");
				String address = rSet.getString("address");
				String hobby = rSet.getString("hobby");
				Date enroll = rSet.getDate("enroll_date");
				
				member = new Member(id,pwd,name,role,gender,BD,email,phone,address,hobby,enroll);
				System.out.println("member@MemberDao = "+member);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstmt);
		}
		return member;
	}

	public int enrollMember(Connection conn, Member member) {
		int result = 0;
		String sql = prop.getProperty("enrollMember");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberid());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getGender());
			pstmt.setDate(5, member.getBirthday());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getPhone());
			pstmt.setString(8, member.getAddress());
			pstmt.setString(9, member.getHobby());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new MemberException();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int updateMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,member.getMemberName());
			pstmt.setString(2,member.getGender());
			pstmt.setDate(3,member.getBirthday());
			pstmt.setString(4,member.getEmail());
			pstmt.setString(5,member.getPhone());
			pstmt.setString(6,member.getAddress());
			pstmt.setString(7,member.getHobby());
			pstmt.setString(8,member.getMemberid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int memberWithdraw(String memberId, Connection conn) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("memberWithdraw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public List<Member> selectAllMember(Connection conn, Map<String, Object> param) {
		String sql = prop.getProperty("selectAllMember");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = new ArrayList<>();
		/*
		 * member_id varchar2(15),
    password varchar2(300) not null, -- 암호화
    member_name varchar2(100) not null,
    member_role char(1) default 'U' not null, -- 회원권한 : 일반사용자(U), 관리자(A)
    gender char(1),
    birthday date,
    email varchar2(100),
    phone char(11) not null,
    address varchar2(300),
    hobby varchar2(300), -- 운동, 등산, 독서, 게임, 여행 -> check box랑 연동
    enroll_date date default sysdate,
		 */
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("startNum"));
			pstmt.setInt(2, (int)param.get("endNum"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				String id = rset.getString("member_id");
				String password = rset.getString("password");
				String name = rset.getString("member_name");
				String role = rset.getString("member_role");
				String gender = rset.getString("gender");
				Date birthday = rset.getDate("birthday");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("enroll_date");
				Member member = new Member(id,password,name,role,gender,birthday,email,phone,address,hobby,enrollDate);
				System.out.println(member);
				list.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}

	public int updateMemberRole(Member member, Connection conn) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMemberRole");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberRole());
			pstmt.setString(2, member.getMemberid());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updatePassword(Connection conn, Member updateMember) {
		int result = 0;
		String sql = prop.getProperty("updatePassword");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,updateMember.getPassword());
			pstmt.setString(2,updateMember.getMemberid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
//			throw new MemberException();
		} finally{
			close(pstmt);
		}
		
		return result;
	}

	public List<Member> searchMember(Map<String, Object> param, Connection conn) {
		List<Member> list = new ArrayList<>();
		String sql = prop.getProperty("searchMember");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String searchType = (String)param.get("searchType");
		String searchKeyword = (String)param.get("searchKeyword");
		
		//sql완성
		switch(searchType) {
		case "memberId": sql += " member_id like '%"+searchKeyword+"%'"; break;
		case "memberName" : sql += " member_Name like '%"+searchKeyword+"%'"; break;
		case "gender" : sql += " gender = '"+searchKeyword+"'"; break;
		}
		System.out.println("sql@Dao = "+sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				String id = rset.getString("member_id");
				String password = rset.getString("password");
				String name = rset.getString("member_name");
				String role = rset.getString("member_role");
				String gender = rset.getString("gender");
				Date birthday = rset.getDate("birthday");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("enroll_date");
				Member member = new Member(id,password,name,role,gender,birthday,email,phone,address,hobby,enrollDate);
				System.out.println(member);
				list.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int selectTotalMemberCount(Connection conn) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectTotalMemberCount");
		int totalCount = 0;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalCount = rset.getInt(1); // 컬럼인덱스 1부터
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return totalCount;
	}



}
