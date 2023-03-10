package com.skilldistillery.itinerary.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.itinerary.entities.Destination;
import com.skilldistillery.itinerary.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User findById(int userId) {
		return em.find(User.class, userId);
	}

	@Override
	public User findByUsernameAndPassword(String username, String password) {
		User loggedInUser = null;
		String query = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND u.enabled = true";
		List<User> userQuery = em.createQuery(query, User.class).setParameter("un", username).setParameter("pw", password).getResultList();
		if (userQuery.size() == 1) {
			loggedInUser = userQuery.get(0);
		}
		return loggedInUser;
	}
	
	@Override
	public User findByUsername(String username) {
		User isLoggedIn = null;
		String query = "SELECT u FROM User u WHERE u.username = :un";
		List<User> userQuery = em.createQuery(query, User.class).setParameter("un", username).getResultList();
		if (userQuery.size() > 0) {
			isLoggedIn = userQuery.get(0);
		}
		return isLoggedIn;
	}
	
	@Override
	public User addUser(User input) {
		em.persist(input);
		User output = findByUsernameAndPassword(input.getUsername(), input.getPassword());
		em.flush();
		return output;
	}
	
	@Override
	public User updateUser (User user, int id) {
		User output = em.find(User.class, id);
		if (output != null) {
			output.setFirstName(user.getFirstName());
			output.setLastName(user.getLastName());
			output.setPassword(user.getPassword());
			output.setBiography(user.getBiography());
			output.setProfilePicture(user.getProfilePicture());
		}
		
		return output;
	}
	
	@Override
	public User deleteAccount(int id) {
		User toDelete = em.find(User.class, id);
		if (toDelete != null) {
			toDelete.setEnabled(false);
		}
		return toDelete;
	}
	
	@Override
	public List<User> findAllActiveUsers () {
		String query = "SELECT u FROM User u WHERE u.enabled = true";
		List<User> results = em.createQuery(query, User.class).getResultList();
		return results;
	}
	
	@Override
	public List<User> findAllDisabledUsers () {
		String query = "SELECT u FROM User u WHERE u.enabled = false";
		List<User> results = em.createQuery(query, User.class).getResultList();
		return results;
	}
	
	@Override
	public List<User> findUsersByKeyword(String search) {
		String query = "SELECT DISTINCT u FROM User u WHERE u.enabled = true AND (u.username LIKE :search OR u.firstName LIKE :search OR u.lastName LIKE :search)";
		List<User> resultList = em.createQuery(query, User.class).setParameter("search", "%" + search + "%").getResultList();
		
		return resultList;
	}
}
