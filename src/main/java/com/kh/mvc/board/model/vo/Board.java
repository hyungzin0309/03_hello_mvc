package com.kh.mvc.board.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Board extends BoardEntity implements Serializable{
	
	private int commentCount;
	private int attachCount; // 첨부파일 수
	private List<Attachment> attachments;
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board(int no, String title, String writer, String content, int readCount, Date regDate) {
		super(no, title, writer, content, readCount, regDate);
		// TODO Auto-generated constructor stub
	}
	public Board(int no, String title, String writer, String content, int readCount, Date regDate, int attachCount,
			List<Attachment> attachments) {
		super(no, title, writer, content, readCount, regDate);
		this.attachCount = attachCount;
		this.attachments = attachments;
	}

	public Board(int no, String title, String writer, String content, int readCount, Date regDate, int commentCount,
			int attachCount, List<Attachment> attachments) {
		super(no, title, writer, content, readCount, regDate);
		this.commentCount = commentCount;
		this.attachCount = attachCount;
		this.attachments = attachments;
	}

	public int getAttachCount() {
		return attachCount;
	}
	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}
	public List<Attachment> getAttachments() {
		return attachments;
	}
	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}
	
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	@Override
	public String toString() {
		return "Board ["+super.toString()
			+ ", commentCount=" + commentCount
			+ ", attachCount=" + attachCount
			+ ", attachments=" + attachments + "]";
	}
	
	
	
}
