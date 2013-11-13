package org.nhnnext.web;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	public Long getId() {
		return id;
	}
	
	@JsonIgnore
	@ManyToOne
	private Board board;
	
	@ManyToOne
	private User user;

	@Column(length=1000, nullable=false)
	private String contents;
	
	public Comment() {}
	
	public Comment(Board board, String contents) {
		this.board = board;
		this.contents = contents;
	}
	
	public Board getBoard() {
		return board;
	}
	
	public void setBoard(Board board) {
		this.board = board;
	}
	
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public User getUser() {
		return this.user;
	}
	
	@Override
	public String toString() {
		return "Comment [id=" + id + ", contents=" + contents + "]";
	}

	public void setUser(User foundUser) {
		this.user = foundUser;
	}
}
