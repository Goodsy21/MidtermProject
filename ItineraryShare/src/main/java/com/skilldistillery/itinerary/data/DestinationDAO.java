package com.skilldistillery.itinerary.data;

import java.util.List;

import com.skilldistillery.itinerary.entities.Destination;

public interface DestinationDAO {
	public Destination createDestination (Destination input);
	public Destination findDestinationById (int id);
	public List<Destination> findAllDestinations ();
	public Destination updateDestination(int destinationId, Destination updateMe);
	List<Destination> findDestinationsByKeyword(String search);
}
