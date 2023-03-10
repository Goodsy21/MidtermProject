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
@Table(name="itinerary_comment")
public class ItineraryComment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	private String post;
	@ManyToOne
	@JoinColumn(name="reply")
	private ItineraryComment reply;
	@ManyToOne
	@JoinColumn(name = "itinerary_id")
	private Itinerary itinerary;
	
	public ItineraryComment () {}
	
	public ItineraryComment(User user, String post, Itinerary itinerary) {
		super();
		this.user = user;
		this.post = post;
		this.itinerary = itinerary;
	}
	public ItineraryComment(User user, String post, ItineraryComment reply, Itinerary itinerary) {
		super();
		this.user = user;
		this.post = post;
		this.reply = reply;
		this.itinerary = itinerary;
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

	public ItineraryComment getReply() {
		return reply;
	}

	public void setReply(ItineraryComment reply) {
		this.reply = reply;
	}

	public Itinerary getItinerary() {
		return itinerary;
	}

	public void setItinerary(Itinerary itinerary) {
		this.itinerary = itinerary;
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
		ItineraryComment other = (ItineraryComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ItineraryComment [id=" + id + ", user=" + user + ", post=" + post + ", reply=" + reply + ", itinerary="
				+ itinerary + "]";
	}
	
	
}
