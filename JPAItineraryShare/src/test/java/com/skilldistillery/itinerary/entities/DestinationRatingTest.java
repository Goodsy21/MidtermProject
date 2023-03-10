package com.skilldistillery.itinerary.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class DestinationRatingTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private DestinationRating destinationRating;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAItineraryShare");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em= emf.createEntityManager();
		DestinationRatingKey key = new DestinationRatingKey(1, 1);
		destinationRating = em.find(DestinationRating.class, key);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		destinationRating = null;
	}

	@Test
	void test() {
		assertNotNull(destinationRating);
		assertEquals("a summer ill never forget", destinationRating.getRatingComment());
		assertTrue(destinationRating.getRating() == 5);
	}

	@Test
	void test_many_to_one_entity_mappings() {
		assertNotNull(destinationRating);
		assertEquals("Chaotic", destinationRating.getUser().getFirstName());
		assertEquals("United States", destinationRating.getDestination().getCountry());
		
	}
}