package com.example.HobbyCircles.service;

import com.example.HobbyCircles.entity.Circle;
import com.example.HobbyCircles.repository.CircleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CircleService {

    @Autowired
    private CircleRepository circleRepository;

    public Circle createCircle(Circle circle) {
        return circleRepository.save(circle);
    }

    public List<Circle> getAllCircles() {
        return circleRepository.findAll();
    }

    public Optional<Circle> getCircleById(Long id) {
        return circleRepository.findById(id);
    }

    public Optional<Circle> getCircleByProviderId(Long providerId) {
        return circleRepository.findByProviderId(providerId);
    }

    public List<Circle> getCirclesByCity(String city) {
        return circleRepository.findByCity(city);
    }

    public List<Circle> getCirclesByCategory(String category) {
        return circleRepository.findByCategory(category);
    }

    public Circle updateCircle(Long id, Circle circleDetails) {
        return circleRepository.findById(id).map(circle -> {
            if (circleDetails.getName() != null)
                circle.setName(circleDetails.getName());
            if (circleDetails.getCity() != null)
                circle.setCity(circleDetails.getCity());
            if (circleDetails.getDescription() != null)
                circle.setDescription(circleDetails.getDescription());
            if (circleDetails.getCategory() != null)
                circle.setCategory(circleDetails.getCategory());
            return circleRepository.save(circle);
        }).orElseThrow(() -> new RuntimeException("Circle not found"));
    }

    public void deleteCircle(Long id) {
        circleRepository.deleteById(id);
    }
}