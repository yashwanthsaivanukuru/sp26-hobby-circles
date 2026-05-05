package com.example.HobbyCircles.repository;

import com.example.HobbyCircles.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    @Query(value = "SELECT r.* FROM reviews r WHERE r.membership_id = :membershipId", nativeQuery = true)
    List<Review> findByMembershipId(Long membershipId);

    @Query(value = "SELECT r.* FROM reviews r JOIN memberships m ON r.membership_id = m.membership_id WHERE m.circle_id = :circleId", nativeQuery = true)
    List<Review> findByCircleId(Long circleId);
}