package com.kh.mvc.board.model.dao;

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
import com.kh.mvc.board.model.vo.Attachment;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.board.model.vo.BoardComment;
import com.kh.mvc.member.model.dao.MemberDao;

public class BoardDao {
	Properties prop = new Properties();
	public BoardDao() {
		final String sqlConfigPath = MemberDao.class.getResource("/board-query.properties").getPath();
		System.out.println("sqlConfigPath@MemberDao = "+sqlConfigPath);
		try {
			prop.load(new FileReader(sqlConfigPath));
			System.out.println("prop@MemberDao = "+prop);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	public List<Board> selectAllContent(Map<String, Object> param, Connection conn) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectAllContent");
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("startNum"));
			pstmt.setInt(2, (int)param.get("endNum"));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				int no = rset.getInt("no");
				String title = rset.getString("title");
				String writer = rset.getString("writer");
				String content = rset.getString("content");
				int readCount = rset.getInt("read_count");
				Date regDate = rset.getDate("reg_date");
				int attachCount = rset.getInt("attach_count");
				int commentCount = rset.getInt("comment_count");
				Board board = new Board(no,title,writer,content,readCount,regDate,commentCount,attachCount,null);
				list.add(board);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("게시물 불러오기 오류");
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int selectTotalContentCount(Connection conn) {
		int total = 0;
		String sql = prop.getProperty("selectTotalContentCount");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				total = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return total;
	}



	public int insertBoard(Connection conn, Board board) {
		int result = 0;
		String sql = prop.getProperty("insertBoard");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getContent());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException();
		}finally {
			close(pstmt);
		}
		return result;
	}



	public int selectLastBoardNo(Connection conn) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectLastBoardNo");
		ResultSet rset = null;
		int boardNo = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				boardNo = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return boardNo;
	}



	public int insertAttachment(Connection conn, Attachment attach) {
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attach.getBoardNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
				
		return result;
	}



	public Board getBoardContent(Connection conn, int boardNo) {
		Board board = new Board();
		String sql = prop.getProperty("getBoardContent");
		System.out.println("sql@boardDao = "+sql);
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				board.setNo(boardNo);
				board.setTitle(rset.getString("title"));
				board.setWriter(rset.getString("writer"));
				board.setContent(rset.getString("content"));
				board.setReadCount(rset.getInt("read_count"));
				board.setRegDate(rset.getDate("reg_date"));
				System.out.println("board@boardDao = "+board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("게시물 불러오기 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return board;
	}



	public List<Attachment> getAttachment(Connection conn, int boardNo) {
		List<Attachment> list = new ArrayList<>();
		String sql = prop.getProperty("getAttachment");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				int no = rset.getInt("no");
				String ori = rset.getString("original_filename");
				String renamed = rset.getString("renamed_filename");
				Date regDate = rset.getDate("reg_date");
				Attachment att = new Attachment(no,boardNo,ori,renamed,regDate);
				list.add(att);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("첨부파일 불러오기 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public Board getBoardContentAttachment(Connection conn, int boardNo) {
		String sql = prop.getProperty("getBoardContentAttachment");
		Board board = new Board();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				board.setNo(boardNo);
				board.setTitle(rset.getString("title"));
				board.setWriter(rset.getString("writer"));
				board.setContent(rset.getString("content"));
				board.setReadCount(rset.getInt("read_count"));
				board.setRegDate(rset.getDate("reg_date"));
				
				int attachNo = rset.getInt("attach_no");
				if(attachNo != 0) {
					List<Attachment> attachments = new ArrayList<>();
					do {
						int aNo = rset.getInt("attach_no");
						String ori = rset.getString("original_filename");
						String renamed = rset.getString("renamed_filename");
						Date regDate = rset.getDate("reg_date");
						Attachment att = new Attachment(aNo,boardNo,ori,renamed,regDate);
						attachments.add(att);
					}while (rset.next());
					board.setAttachments(attachments);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("게시물 불러오기 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return board;
	}



	public int readCountUp(int boardNo, Connection conn) {
		String sql = prop.getProperty("readCountUp");
		int result = 0;
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("조회수 증가 오류");
		}finally {
			close(pstmt);
		}
		
		return result;
	}



	public Attachment selectOneAttachment(int no, Connection conn) {
		Attachment attach = null;
		String sql = prop.getProperty("selectOneAttachment");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				int boardNo = rset.getInt("board_no");
				String ori = rset.getString("original_filename");
				String renamed = rset.getString("renamed_filename");
				Date regDate = rset.getDate("reg_date");
				attach = new Attachment(no,boardNo,ori,renamed,regDate);
			}
			System.out.println("[BoardDao] attach = "+attach);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("첨부파일 불러오기 오류");
		}finally {
			close(rset);
			close(pstmt);
		}
		return attach;
	}



	public int deleteBoard(int boardNo, Connection conn) {
		int result = 0;
		String sql = prop.getProperty("deleteBoard");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("게시물 삭제 오류!");
		}finally {
			close(pstmt);
		}
		return result;
	}



	public int updateBoard(Board board, Connection conn) {
		int result = 0;
		String sql = prop.getProperty("updateBoard");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("게시물 수정 오류");
		}finally {
			close(pstmt);
		}
		return result;
	}



	public int deleteAttachment(Connection conn, int delFileNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, delFileNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException();
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}



	public List<BoardComment> selectBoardCommentList(int boardNo, Connection conn) {
		List<BoardComment> list = new ArrayList<>();
		String sql = prop.getProperty("selectBoardCommentList");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				BoardComment bc = new BoardComment();
				bc.setNo(rset.getInt("no"));
				bc.setCommentLevel(rset.getInt("comment_level"));
				bc.setWriter(rset.getString("writer"));
				bc.setContent(rset.getString("content"));
				bc.setBoardNo(rset.getInt("board_no"));
				bc.setCommentRef(rset.getInt("comment_ref")); // 댓글인 경우 null이고, 이는 0으로 치환된다.
				bc.setRegDate(rset.getDate("reg_date"));
				list.add(bc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("댓글 불러오기 오류");
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}



	public int insertBoardComment(Connection conn, BoardComment bc) {
		int result = 0;
		String sql = prop.getProperty("insertBoardComment");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bc.getCommentLevel()); // 1 or 2
			pstmt.setString(2,bc.getWriter());
			pstmt.setString(3,bc.getContent());
			pstmt.setInt(4,bc.getBoardNo());
			// 참조하는 댓글이 없는 경우 null을 넣어줘야 하는데 setInt로는 불가
			// setObject 사용
//			pstmt.setInt(5,bc.getCommentRef());
			pstmt.setObject(5, bc.getCommentRef() == 0? null : bc.getCommentRef());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("댓글 등록 오류");
		} finally {
			close(pstmt);
		}
		return result;
	}



	public int commentDelete(Connection conn, int commentNo) {
		int result = 0;
		String sql = prop.getProperty("commentDelete");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("댓글 삭제 오류");
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}

}
