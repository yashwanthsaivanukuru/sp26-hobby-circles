package com.example.hobby_circles;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api")
public class HobbyistController {

    @Autowired
    private HobbyistRepository hobbyistRepository;

    @Autowired
    private HobbyCircleRepository hobbyCircleRepository;

    @Autowired
    private MembershipRepository membershipRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    // --- 1. HOBBYIST PROFILE ENDPOINTS ---

    // Create Profile: POST /api/hobbyists/create
    @PostMapping("/hobbyists/create")
    public Hobbyist createHobbyist(@RequestBody Hobbyist hobbyist) {
        return hobbyistRepository.save(hobbyist);
    }

    // Modify Profile: PUT /api/hobbyists/update/{id}
    @PutMapping("/hobbyists/update/{id}")
    public Hobbyist updateHobbyist(@PathVariable Long id, @RequestBody Hobbyist details) {
        return hobbyistRepository.findById(id).map(hobbyist -> {
            hobbyist.setFirstName(details.getFirstName());
            hobbyist.setLastName(details.getLastName());
            hobbyist.setEmail(details.getEmail());
            hobbyist.setPassword(details.getPassword());
            return hobbyistRepository.save(hobbyist);
        }).orElseThrow(() -> new RuntimeException("Hobbyist not found with id: " + id));
    }

    // --- 2. CIRCLE (SERVICE) ENDPOINTS ---

    // Browse All Circles: GET /api/circles/all
    @GetMapping("/circles/all")
    public List<HobbyCircle> getAllCircles() {
        return hobbyCircleRepository.findAll();
    }

    // --- 3. MEMBERSHIP (JOIN) ENDPOINTS ---

    // Join a Circle: POST /api/hobbyists/join?hobbyistId=1&circleId=1
    @PostMapping("/hobbyists/join")
    public Membership joinCircle(@RequestParam Long hobbyistId, @RequestParam Long circleId) {
        // Validation: Ensure both exist
        if (!hobbyistRepository.existsById(hobbyistId) || !hobbyCircleRepository.existsById(circleId)) {
            throw new RuntimeException("Invalid User or Circle ID");
        }
        Membership newMember = new Membership(hobbyistId, circleId);
        return membershipRepository.save(newMember);
    }

    // --- 4. REVIEW ENDPOINTS ---

    // Add a Review: POST /api/reviews/add
    @PostMapping("/reviews/add")
    public Review addReview(@RequestBody Review review) {
        // Simple rating validation
        if (review.getRating() < 1 || review.getRating() > 5) {
            throw new RuntimeException("Rating must be between 1 and 5");
        }
        return reviewRepository.save(review);
    }
}