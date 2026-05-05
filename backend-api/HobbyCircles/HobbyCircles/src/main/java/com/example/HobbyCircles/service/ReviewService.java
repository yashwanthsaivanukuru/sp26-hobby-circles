package com.example.HobbyCircles.service;

import com.example.HobbyCircles.entity.Review;
import com.example.HobbyCircles.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public Review createReview(Review review) {
        return reviewRepository.save(review);
    }

    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
    }

    public Optional<Review> getReviewById(Long id) {
        return reviewRepository.findById(id);
    }

    public List<Review> getReviewsByMembershipId(Long membershipId) {
        return reviewRepository.findByMembershipId(membershipId);
    }

    public List<Review> getReviewsByCircleId(Long circleId) {
        return reviewRepository.findByCircleId(circleId);
    }

    public Review updateReview(Long id, Review reviewDetails) {
        return reviewRepository.findById(id).map(review -> {
            if (reviewDetails.getRating() != null)
                review.setRating(reviewDetails.getRating());
            if (reviewDetails.getComment() != null)
                review.setComment(reviewDetails.getComment());
            if (reviewDetails.getReplyText() != null)
                review.setReplyText(reviewDetails.getReplyText());
            return reviewRepository.save(review);
        }).orElseThrow(() -> new RuntimeException("Review not found"));
    }

    public void deleteReview(Long id) {
        reviewRepository.deleteById(id);
    }
}