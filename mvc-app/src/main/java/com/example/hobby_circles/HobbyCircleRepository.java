package com.example.hobby_circles;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List; 

@Repository
public interface HobbyCircleRepository extends JpaRepository<HobbyCircle, Long> {
    
    
    List<HobbyCircle> findByNameContainingIgnoreCase(String name);
}