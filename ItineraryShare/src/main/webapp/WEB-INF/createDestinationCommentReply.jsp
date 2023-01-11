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
			<!-- Destination Info START -->
			<div class="col-lg-4 addBorder sepLine itinerary__info"
				data-spy="affix">

				<!--   fixed position -->
				<img class="destinationPicture" src="${destination.image}" onerror="this.onerror=null; this.src='https://media.istockphoto.com/photos/couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island-picture-id1160947136?b=1&k=20&m=1160947136&s=612x612&w=0&h=AsFmKSBYTtacl0DvI-RanCnAXFU0cmuW8NAo0g-tGzA='">
				
				<div class="flex">
					<h4>Name</h4>
					<p>${destination.name}</p>
					<br />
					<h4>Location</h4>
					<p>${destination.city}, ${destination.country}</p>
					<br />
					<h4>Rating</h4>
					<p>${rating} / 5</p>
					<br />
					<h4>Description</h4>
					<p>${destination.description}</p>
					<br />
					</div>
			</div>


			<!-- Destination Info END -->
				<!-- Comments Section Start -->
			<div class="col-lg-8" style="background: white;">
				<c:if test="${sessionScope.loggedInUser.id != 0}">
					<div class="panel">
						<div class="panel-body">
							<form action="createDestinationCommentReply.do" method="post">
								<input type="hidden" value="${destination.id}" name="destinationId">
								<input type="hidden" value="${commentId}"
									name="destinationCommentId">
								<textarea class="form-control" rows="2"
									placeholder="What are you thinking?" name="destinationComment"></textarea>
								<div class="mar-top clearfix">
									<button class="btn btn-sm btn-primary pull-right" type="submit">
										<i class="fa fa-pencil fa-fw"></i>Reply
									</button>
								</div>
							</form>
						</div>
					</div>
					<br />
				</c:if>
				<div class="panel">
					<div class="panel-body">
							<!-- Newsfeed Content -->
							<!--===================================================-->
							<div class="media-block">

								<a class="media-left"
									href="viewAccount.do?userId=${comment.user.id}"><img
									class="img-circle img-sm" alt="Profile Picture"
									src="${comment.user.profilePicture}"
									onerror="this.onerror=null; this.src='https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg'"></a>
								<div class="media-body">
									<div class="mar-btm">
										<a href="viewAccount.do?userId=${comment.user.id}"
											class="btn-link text-semibold media-heading box-inline">${comment.user.username}</a>
									</div>
									<p>${comment.post }</p>
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
					</div>
				</div>
			</div>
			<!-- Comments Sectino End -->
		</div>
	</div>
	<%@include file="bootstrapFooter.jsp"%>
</body>
</html>