package com.skilldistillery.itinerary.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "destination_comment")
public class DestinationComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	private String post;

	@ManyToOne
	@JoinColumn(name = "reply")
	private DestinationComment reply;

	@ManyToOne
	@JoinColumn(name = "destination_id")
	private Destination destination;

	public DestinationComment() {
	}

	public DestinationComment(User user, String post, Destination destination) {
		super();
		this.user = user;
		this.post = post;
		this.destination = destination;
	}

	public DestinationComment(User user, String post, DestinationComment reply, Destination destination) {
		super();
		this.user = user;
		this.post = post;
		this.reply = reply;
		this.destination = destination;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public DestinationComment getReply() {
		return reply;
	}

	public void setReply(DestinationComment reply) {
		this.reply = reply;
	}

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DestinationComment other = (DestinationComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "DestinationComment [id=" + id + ", user=" + user + ", post=" + post + ", reply=" + reply
				+ ", destination=" + destination + "]";
	}

}
