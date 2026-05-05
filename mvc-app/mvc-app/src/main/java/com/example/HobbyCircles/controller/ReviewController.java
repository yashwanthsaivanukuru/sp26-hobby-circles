package com.example.HobbyCircles.controller;

import com.example.HobbyCircles.entity.Review;
import com.example.HobbyCircles.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/reviews")
@CrossOrigin(origins = "*")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping
    public ResponseEntity<Review> createReview(@RequestBody Review review) {
        return new ResponseEntity<>(reviewService.createReview(review), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Review>> getAllReviews() {
        return new ResponseEntity<>(reviewService.getAllReviews(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Review> getReviewById(@PathVariable Long id) {
        Optional<Review> review = reviewService.getReviewById(id);
        return review.map(r -> new ResponseEntity<>(r, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/circle/{circleId}")
    public ResponseEntity<List<Review>> getReviewsByCircle(@PathVariable Long circleId) {
        return new ResponseEntity<>(reviewService.getReviewsByCircleId(circleId), HttpStatus.OK);
    }

    @GetMapping("/membership/{membershipId}")
    public ResponseEntity<List<Review>> getReviewsByMembership(@PathVariable Long membershipId) {
        return new ResponseEntity<>(reviewService.getReviewsByCircleId(membershipId), HttpStatus.OK);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Review> updateReview(@PathVariable Long id,
                                                @RequestBody Review reviewDetails) {
        try {
            return new ResponseEntity<>(reviewService.updateReview(id, reviewDetails), HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        reviewService.deleteReview(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}