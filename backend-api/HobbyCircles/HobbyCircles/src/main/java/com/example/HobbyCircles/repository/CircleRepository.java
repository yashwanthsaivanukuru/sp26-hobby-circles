package com.example.HobbyCircles.repository;

import com.example.HobbyCircles.entity.Circle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CircleRepository extends JpaRepository<Circle, Long> {

    List<Circle> findByCity(String city);

    List<Circle> findByCategory(String category);

    @Query(value = "SELECT c.* FROM circles c WHERE c.provider_id = :providerId", nativeQuery = true)
    Optional<Circle> findByProviderId(Long providerId);
}
