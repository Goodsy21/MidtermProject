<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Results</title>
<%@include file="bootstraphead.jsp"%>
</head>
<body>
	<%@include file="navbarGuest.jsp"%>
	
	<div>
	<h3 class="text-center" >SEARCH RESULTS FOR " ${ search } "</h3>
	
	</div>
	<br>
	<br>
	<br>
	
	<c:choose>
		<c:when test="${ ! empty destinations or ! empty itineraries or ! empty users }">
		
		
		<c:if test="${ ! empty itineraries }">
		<div class="centerMe">
		<h4>Itineraries</h4>
		</div>
			<div class="cards">
				<c:forEach var="itinerary" items="${ itineraries }">
					<div class="card">
						<a href="viewItinerary.do?itineraryId=${ itinerary.id }"> <img alt="" src="${ itinerary.image}"
							onerror="this.onerror=null; this.src='https://media.istockphoto.com/photos/couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island-picture-id1160947136?b=1&k=20&m=1160947136&s=612x612&w=0&h=AsFmKSBYTtacl0DvI-RanCnAXFU0cmuW8NAo0g-tGzA="
							class="card__image">
						</a>
						<div class="card__content centerMe">
							<a href="viewItinerary.do?itineraryId=${ itinerary.id }" class="card__link"> ${itinerary.name } </a>
						</div>
					</div>

				</c:forEach>
			</div>
			</c:if>

<br/>

		<c:if test="${ ! empty destinations }">
		<div class="centerMe">
		<h4>Destinations</h4>
		</div>
		<div class="cards">
				<c:forEach var="destination" items="${ destinations }">
					<div class="card">
						<a href="viewDestination.do?destinationId=${ destination.id }"> <img alt="" src="${ destination.image}"
							onerror="this.onerror=null; this.src='https://media.istockphoto.com/photos/couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island-picture-id1160947136?b=1&k=20&m=1160947136&s=612x612&w=0&h=AsFmKSBYTtacl0DvI-RanCnAXFU0cmuW8NAo0g-tGzA="
							class="card__image">
						</a>
						<div class="card__content centerMe">
							<a href="viewDestination.do?destinationId=${ destination.id }" class="card__link"> ${destination.name } </a>
						</div>
					</div>

				</c:forEach>
			</div>
			</c:if>

<br/>
			<c:if test="${ ! empty users }">
			<div class="centerMe">
				<h4>Users </h4>
				</div>
				<div class="cards">
					<c:forEach var="user" items="${ users }">
						<div class="card">
							<a href="viewAccount.do?userId=${ user.id }"> <img
								alt="user profile picture" src="${ user.profilePicture}"
								onerror="this.onerror=null; this.src='https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg'" class="card__image">
							</a>
							<div class="card__content centerMe">
								<a href="viewAccount.do?userId=${ user.id }"
									class="card__link"> ${user.username } </a>
							</div>
						</div>

					</c:forEach>
				</div>
			</c:if>




		</c:when>
		<c:otherwise>
		<br/>
		<div class="centerMe">
		<h4>
		Nothing found by that search!
		</h4>
		</div>
		</c:otherwise>

	</c:choose>

<%@include file="bootstrapFooter.jsp"%>
</body>
</html>