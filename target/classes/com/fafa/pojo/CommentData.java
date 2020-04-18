package com.fafa.pojo;

import java.io.Serializable;
import java.util.List;

public class CommentData extends Goods implements Serializable {
    private List<Comments> comments;
	public List<Comments> getComments() {
		return comments;
	}
	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}
	
	
}