<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${sessionScope.loggedInUser.username}</title>
<%@include file="bootstraphead.jsp"%>
</head>
<body>
	<%@include file="navbarGuest.jsp"%>
	<div class="itinerary__content">
		<div class="row">
			<!-- Itinerary Info START -->
			<div class="col-lg-4 addBorder sepLine itinerary__info itinerary-col"
				data-spy="affix">

				<!--   fixed position -->
				<img class="itineraryPicture itinerary-image" src="${itinerary.image}"
					onerror="this.onerror=null; this.src='https://media.istockphoto.com/photos/couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island-picture-id1160947136?b=1&k=20&m=1160947136&s=612x612&w=0&h=AsFmKSBYTtacl0DvI-RanCnAXFU0cmuW8NAo0g-tGzA=">

				<div class="flex">
					<h4 class="centerMe">Itinerary Info</h4>
					<br /> <strong>Author:</strong>
					<div class="media-block">
						<a class="media-left"
							href="viewAccount.do?userId=${itinerary.userId.id}"><img
							class="mx-auto rounded-circle img-fluid img-sm"
							alt="Profile Picture" src="${itinerary.userId.profilePicture}"
							onerror="this.onerror=null; this.src='https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg'"></a>
						<div class="media-body">
							<div class="mar-btm">
								<a href="viewAccount.do?userId=${itinerary.userId.id}"
									class="btn-link text-semibold media-heading box-inline">${itinerary.userId.username}</a>
							</div>
						</div>
					</div>
					<br> <strong>Name:</strong> ${itinerary.name} <br><strong>Budget:</strong> $
					${itinerary.budget} <br><strong>Start Date:</strong> ${itinerary.startDate} <br><strong>End
					Date:</strong> ${itinerary.endDate}
				</div>
				<br>
				<div class="flex">
					<h5>Description</h5>
					<br />
					<p>${itinerary.description}</p>
				</div>
				<c:if
					test="${(sessionScope.loggedInUser.id == itinerary.userId.id) or sessionScope.loggedInUser.username == 'admin' }">
					<form action="deleteItinerary.do" method="post">
						<button type="submit" class="btn btn-primary deleteButton"
							value="${itinerary.id}" name="deleteId">Delete</button>
					</form>
					<br>
					<form action="goUpdateItinerary.do" method="post">
						<button type="submit" class="btn btn-primary"
							value="${itinerary.id}" name="updateId">Update</button>
					</form>
					<br>
				</c:if>
				<c:choose>
					<c:when
						test="${sessionScope.loggedInUser.id != 0 and bookmarked == false}">
						<form action="addBookmark.do" method="post">
							<button type="submit" class="btn btn-primary"
								value="${itinerary.id}" name="itineraryId">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
  <path
										d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z" />
</svg>
								Bookmark
							</button>
						</form>
					</c:when>
					<c:when
						test="${sessionScope.loggedInUser.id != 0 and bookmarked == true}">
						<form action="deleteBookmark.do" method="post">
							<button type="submit" class="btn btn-primary" name="itineraryId"
								value="${itinerary.id }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-bookmark-check-fill"
									viewBox="0 0 16 16">
  <path fill-rule="evenodd"
										d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z" />
</svg>
								Bookmarked
							</button>
						</form>
					</c:when>
				</c:choose>
			</div>
			<!-- Itineraries START -->
			<div class="col-8" style="padding-left:0px;padding-right:0px;">
			<div class="centerMe">
			<br/>
				<h4>Itinerary Days</h4>
				<c:if
					test="${(sessionScope.loggedInUser.id == itinerary.userId.id) or sessionScope.loggedInUser.username == 'admin' }">
					<br>
					<form action="goCreateItineraryItem.do" method="GET">
					<button type="submit" class="btn btn-primary" name="itineraryId" value="${itinerary.id }">Create Itinerary Item</button>
					</form>
					<br/>
				</c:if>
			</div>
				<br>
				<c:if test="${!empty itineraryDays }">
					<table class="table table-primary table-striped">
						<thead>
							<tr>
								<th class="centerMe">Day</th>
								<th class="centerMe">Description</th>
								<th class="centerMe">Destination</th>
								<th  class="centerMe" colspan="2">Pictures</th>
								<c:if
									test="${(sessionScope.loggedInUser.id == itinerary.userId.id) or sessionScope.loggedInUser.username == 'admin' }">
									<th class="centerMe">Delete</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="days" items="${itineraryDays}">
								<tr>
									<td class="centerMe">${days.tripDay}</td>
									<td class="centerMe">${days.description }</td>
									<td class="centerMe"><a
										href="viewDestination.do?destinationId=${days.destination.id}">${days.destination.name}</a></td>
									<td class="centerMe"><form action="viewTripPictures.do" method="post">
											<button value="${days.id }" type="submit"
												class="btn btn-primary deleteButton" name="itineraryItemId">View</button>
										</form></td>
									<td class="centerMe"><c:if test="${(sessionScope.loggedInUser.id == itinerary.userId.id) or (sessionScope.loggedInUser.username == 'admin' )}">
											<form action="createTripPicture.do" method="post">
												<input type="text"
													placeholder="Enter a URL to add a picture" name="imageUrl">
												<input type="hidden" value="${days.id }" name="itineraryItemId">
												<button type="submit" class="btn btn-primary deleteButton">Submit</button>
											</form>
										</c:if></td>
									<c:if
										test="${(sessionScope.loggedInUser.id == itinerary.userId.id) or (sessionScope.loggedInUser.username == 'admin' )}">
										<td class="centerMe">
											<form action="deleteItineraryItem.do" method="post">
												<input type="hidden" value="${itinerary.id }"
													name="itineraryId"> <input type="hidden"
													value="${days.id}" name="itineraryItemId">
												<button type="submit" class="btn btn-primary deleteButton">Delete</button>
											</form>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12 comments comment-row">
				<!-- Comments Section Start -->
				<c:if test="${sessionScope.loggedInUser.id != 0}">
					<div class="panel">
						<div class="panel-body">
							<form action="createItineraryComment.do" method="post">
								<input type="hidden" value="${itinerary.id}" name="itineraryId">
								<textarea class="container" rows="3"
									placeholder="What are you thinking?" name="itineraryComment"></textarea>
								<div class="mar-top clearfix">
									<button class="btn btn-sm btn-primary pull-right" type="submit">
										<i class="fa fa-pencil fa-fw"></i> Comment
									</button>
								</div>
							</form>
						</div>
					</div>
				</c:if>
				<div class="panel">
					<div class="panel-body">
						<c:forEach var="comment" items="${comments}">
							<!-- Newsfeed Content -->
							<!--===================================================-->
							<div class="media-block">


								<a class="media-left"
									href="viewAccount.do?userId=${comment.user.id}"><img
									class="mx-auto rounded-circle img-fluid img-sm"
									alt="Profile Picture" src="${comment.user.profilePicture}"
									onerror="this.onerror=null; this.src='https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg'"></a>
								<div class="media-body">
									<div class="mar-btm">
										<a href="viewAccount.do?userId=${comment.user.id}"
											class="btn-link text-semibold media-heading box-inline">${comment.user.username}</a>
									</div>
									<p>${comment.post }</p>
									<c:if test="${sessionScope.loggedInUser.id != 0}">
										<div class="pad-ver">
											<form action="goCreateItineraryCommentReply.do" method="post">
												<input type="hidden" value="${itinerary.id}"
													name="itineraryId"> <input type="hidden"
													value="${comment.id}" name="itineraryCommentId">
												<button class="btn btn-sm btn-primary pull-right"
													type="submit">
													<i class="fa fa-pencil fa-fw"></i> Reply
												</button>
											</form>
										</div>
									</c:if>
									<hr>
								</div>
								<!--  Replies Start -->
								<div
									class="comment-reply col-md-11 offset-md-1 col-sm-10 offset-sm-2">
									<c:forEach var="reply" items="${replies}">
										<c:if test="${reply.reply.id == comment.id}">
											<div class="row">
												<div
													class="comment-avatar col-md-1 col-sm-2 text-center pr-1">
													<a href="viewAccount.do?userId=${reply.user.id}"><img
														class="mx-auto rounded-circle img-fluid img-sm"
														alt="Profile Picture"
														onerror="this.onerror=null; this.src='https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg'"
														src="${reply.user.profilePicture}"></a>
												</div>
												<div class="comment-content col-md-11 col-sm-10 col-12">

													<div class="small comment-meta">
														<a href="viewAccount.do?userId=${reply.user.id}"
															class="btn-link text-semibold media-heading box-inline">${reply.user.username}</a>
													</div>
													<div class="comment-body">
														<p>${reply.post }</p>
													</div>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
								<!-- REPLIES END -->
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>


		<!-- Itinerary Info END -->

	</div>
	<!-- ItineraryItems END -->
	<%@include file="bootstrapFooter.jsp"%>
</body>
</html>