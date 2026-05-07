package com.example.hobby_circles;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {
    // This will allow you to show "Proof" by finding all circles for a specific user
    List<Registration> findByEmail(String email);
}