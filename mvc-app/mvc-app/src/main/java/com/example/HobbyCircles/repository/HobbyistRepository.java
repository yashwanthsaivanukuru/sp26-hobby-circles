package com.example.hobby_circles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HobbyistRepository extends JpaRepository<Hobbyist, Long> { }