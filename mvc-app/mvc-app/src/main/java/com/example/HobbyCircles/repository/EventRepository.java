package com.example.HobbyCircles.repository;

import com.example.HobbyCircles.entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {

    @Query(value = "SELECT e.* FROM events e WHERE e.circle_id = :circleId", nativeQuery = true)
    List<Event> findByCircleId(Long circleId);
}