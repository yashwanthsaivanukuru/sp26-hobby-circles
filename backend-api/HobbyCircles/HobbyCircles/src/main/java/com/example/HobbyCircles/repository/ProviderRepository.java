package com.example.HobbyCircles.repository;

import com.example.HobbyCircles.entity.Provider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProviderRepository extends JpaRepository<Provider, Long> {
    Provider findByEmail(String email);
}