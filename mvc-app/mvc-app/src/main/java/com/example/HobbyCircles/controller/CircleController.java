package com.example.HobbyCircles.controller;

import com.example.HobbyCircles.entity.Circle;
import com.example.HobbyCircles.service.CircleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/circles")
@CrossOrigin(origins = "*")
public class CircleController {

    @Autowired
    private CircleService circleService;

    @PostMapping
    public ResponseEntity<Circle> createCircle(@RequestBody Circle circle) {
        return new ResponseEntity<>(circleService.createCircle(circle), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Circle>> getAllCircles() {
        return new ResponseEntity<>(circleService.getAllCircles(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Circle> getCircleById(@PathVariable Long id) {
        Optional<Circle> circle = circleService.getCircleById(id);
        return circle.map(c -> new ResponseEntity<>(c, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/provider/{providerId}")
    public ResponseEntity<Circle> getCircleByProvider(@PathVariable Long providerId) {
        Optional<Circle> circle = circleService.getCircleByProviderId(providerId);
        return circle.map(c -> new ResponseEntity<>(c, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/city/{city}")
    public ResponseEntity<List<Circle>> getCirclesByCity(@PathVariable String city) {
        return new ResponseEntity<>(circleService.getCirclesByCity(city), HttpStatus.OK);
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<Circle>> getCirclesByCategory(@PathVariable String category) {
        return new ResponseEntity<>(circleService.getCirclesByCategory(category), HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Circle> updateCircle(@PathVariable Long id,
                                                @RequestBody Circle circleDetails) {
        try {
            return new ResponseEntity<>(circleService.updateCircle(id, circleDetails), HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCircle(@PathVariable Long id) {
        circleService.deleteCircle(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
