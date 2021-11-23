package com.kh.mvc.board.model.service;

import static com.kh.mvc.common.JdbcTemplate.close;
import static com.kh.mvc.common.JdbcTemplate.commit;
import static com.kh.mvc.common.JdbcTemplate.rollback;
import static com.kh.mvc.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.mvc.board.model.dao.BoardDao;
import com.kh.mvc.board.model.vo.Attachment;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.board.model.vo.BoardComment;
import com.kh.mvc.member.model.dao.MemberDao;

public class BoardService {
	private BoardDao boardDao = new BoardDao();
	
	public List<Board> selectAllContent(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Board> list = boardDao.selectAllContent(param,conn);
		close(conn);
		return list;
	}
	public int selectTotalContentCount() {
		Connection conn = getConnection();
		int total = boardDao.selectTotalContentCount(conn);
		close(conn);
		return total;
	}
	
	
	/*
	 * insertBoard
	 * insertAttachment * n
	 */
	public int insertBoard(Board board) {
		Connection conn = null;
		int result = 0;
		
		try {
			conn = getConnection();
			result = boardDao.insertBoard(conn, board);
			
			// 방금 insert된 boardNo조회 : select seq_board_no.currval from dual
			int boardNo = boardDao.selectLastBoardNo(conn);
			System.out.println("boardNo@BoardService = "+boardNo);
			board.setNo(boardNo);
			
			List<Attachment> attachments = board.getAttachments();
			if(attachments != null) {
				for(Attachment attachment : attachments) {
					attachment.setBoardNo(boardNo);
					System.out.println("attachment@BoardService = "+attachment);
					result = boardDao.insertAttachment(conn,attachment);
				}
			}	
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
		}finally{
			close(conn);
		}
		
		return result;
	}
	public Board getBoardContent(int boardNo) {
		Connection conn = getConnection();
		Board board = boardDao.getBoardContent(conn, boardNo);
		List<Attachment> aList = boardDao.getAttachment(conn,boardNo);
		if(aList!=null) {
			board.setAttachments(aList);
		}
		close(conn);
		
		return board;
	}
	public Board getBoardContentAttachment(int boardNo) {
		Connection conn = getConnection();
		Board board = boardDao.getBoardContentAttachment(conn, boardNo);
		close(conn);
		
		return board;
	}
	public int readCountUp(int boardNo) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.readCountUp(boardNo, conn);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}
	public Attachment selectOneAttachment(int no) {
		Connection conn = getConnection();
		Attachment attach = boardDao.selectOneAttachment(no,conn);
		close(conn);
		return attach;
	}
	public int deleteBoard(int boardNo) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.deleteBoard(boardNo, conn);
			commit(conn);
			
		}catch(Exception e) {
			rollback(conn);
		}finally {
			close(conn);
		}
		
		return result;
	}
	public int updateBoard(Board board) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.updateBoard(board,conn);
			
			List<Attachment> list = board.getAttachments();
			if(list != null && !list.isEmpty()) {
				for(Attachment attach : list) {
					result = boardDao.insertAttachment(conn,attach);
				}
			}
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally{
			close(conn);
		}
		
		return result;
	}
	public int deleteAttachment(int delFileNo) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.deleteAttachment(conn, delFileNo);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}
	public List<BoardComment> selectBoardCommentList(int boardNo) {
		Connection conn = getConnection();
		List<BoardComment> list = boardDao.selectBoardCommentList(boardNo, conn);
		close(conn);
		return list ;
	}
	public int insertBoardComment(BoardComment bc) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.insertBoardComment(conn, bc);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}
	public int commentDelete(int commentNo) {
		int result = 0;
		Connection conn = null;
		
		try {
			conn = getConnection();
			result = boardDao.commentDelete(conn, commentNo);
			commit(conn);
		}catch(Exception e){
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}
	


}
