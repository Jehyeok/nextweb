package org.nhnnext.web;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Board {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	public Long getId() {
		return id;
	}
	
	@OneToMany(mappedBy = "board", fetch = FetchType.EAGER)
	private List<Comment> comments;
	
	@ManyToOne
	private User user;
	
	@Column(length=50, nullable=false)
	private String title;
	
	@Column(length=1000, nullable=false)
	private String contents;
	
	@Column(length=50, nullable=false)
	private String fileName;
	
	public User getUser() {
		return this.user;
	}
	public List<Comment> getComments() {
		return comments;
	}

	public void setComment(Comment comment) {
		this.comments.add(comment);
	}
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	@Override
	public String toString() {
		return "Board [title=" + title + ", contents=" + contents + "]";
	}

	public void setUserId(String userId) {
		this.user.setUserId(userId);
	}
	public void setUser(User foundUser) {
		this.user = foundUser;
	}
}
