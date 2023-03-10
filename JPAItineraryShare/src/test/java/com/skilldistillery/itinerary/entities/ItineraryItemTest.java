package com.skilldistillery.itinerary.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ItineraryItemTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ItineraryItem itineraryItem;

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
		itineraryItem = em.find(ItineraryItem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		itineraryItem = null;
	}

	@Test
	void test_itineraryItem_entity() {
		assertNotNull(itineraryItem);
		assertEquals("salt lakes utah", itineraryItem.getDescription());
	}

}
