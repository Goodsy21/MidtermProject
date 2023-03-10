package com.skilldistillery.itinerary.data;

import java.util.List;

import com.skilldistillery.itinerary.entities.DestinationComment;

public interface DestinationCommentDAO {
	DestinationComment addComment(int destinationId, int userId, String body);

	List<DestinationComment> findCommentsWithNullReply();

	List<DestinationComment> findCommentsWithReply();

	DestinationComment addCommentReply(int user, String post, int reply, int destination);

	DestinationComment findCommentById(int id);

	List<DestinationComment> findCommentsByReplyId(int id);

	List<DestinationComment> findCommentsById(int destinationId);

	boolean deleteDestinationComment(int commentId);

	DestinationComment updateDestinationComment(DestinationComment input, int commentId);

}
