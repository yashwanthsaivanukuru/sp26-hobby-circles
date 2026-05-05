package com.example.HobbyCircles.controller;

import com.example.HobbyCircles.entity.Circle;
import com.example.HobbyCircles.entity.Provider;
import com.example.HobbyCircles.entity.Review;
import com.example.HobbyCircles.service.CircleService;
import com.example.HobbyCircles.service.ProviderService;
import com.example.HobbyCircles.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.HobbyCircles.service.EventService;
import com.example.HobbyCircles.entity.Event;

import java.util.List;
import java.util.Optional;

/**
 * MVC Controller for Provider-side views.
 * Uses FreeMarker templates to render server-side HTML pages.
 * All routes are under /providers.
 */
@Controller
@RequestMapping("/providers")
public class ProviderMvcController {

    @Autowired
    private ProviderService providerService;

    @Autowired
    private CircleService circleService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private EventService eventService;

    // -------------------------------------------------------
    // DASHBOARD
    // -------------------------------------------------------

    /**
     * GET /providers/{id}
     * Provider dashboard - shows the provider's name and circle info.
     */
    @GetMapping("/{id}")
    public String getProviderDashboard(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        Provider provider = providerOpt.get();
        model.addAttribute("provider", provider);

        // Fetch the provider's circle if it exists
        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        circleOpt.ifPresent(circle -> model.addAttribute("circle", circle));

        return "provider-dashboard";
    }

    // -------------------------------------------------------
    // CIRCLE MANAGEMENT
    // -------------------------------------------------------

    /**
     * GET /providers/{id}/circle
     * Show the create/edit circle form pre-populated with existing data (if any).
     */
    @GetMapping("/{id}/circle")
    public String showCircleForm(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        model.addAttribute("provider", providerOpt.get());

        // If provider already has a circle, pre-fill the form
        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        circleOpt.ifPresentOrElse(
            circle -> model.addAttribute("circle", circle),
            () -> model.addAttribute("circle", new Circle())
        );

        return "provider-circle-form";
    }

    /**
     * POST /providers/{id}/circle/save
     * Create a new circle for this provider (if none exists) or update existing one.
     */
    @PostMapping("/{id}/circle/save")
    public String saveCircle(@PathVariable Long id, Circle circleData, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        Provider provider = providerOpt.get();

        Optional<Circle> existingCircle = circleService.getCircleByProviderId(id);
        if (existingCircle.isPresent()) {
            // Update existing circle
            circleService.updateCircle(existingCircle.get().getCircleId(), circleData);
        } else {
            // Create new circle and associate with provider
            circleData.setProvider(provider);
            circleService.createCircle(circleData);
        }

        return "redirect:/providers/" + id;
    }

    // -------------------------------------------------------
    // REVIEWS MANAGEMENT
    // -------------------------------------------------------

    /**
     * GET /providers/{id}/reviews
     * Show all reviews for this provider's circle.
     */
    @GetMapping("/{id}/reviews")
    public String getReviews(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        model.addAttribute("provider", providerOpt.get());

        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        if (circleOpt.isPresent()) {
            Circle circle = circleOpt.get();
            model.addAttribute("circle", circle);
            List<Review> reviews = reviewService.getReviewsByCircleId(circle.getCircleId());
            model.addAttribute("reviews", reviews);

            // Calculate average rating
            double avgRating = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
            model.addAttribute("avgRating", String.format("%.1f", avgRating));
        } else {
            model.addAttribute("reviews", List.of());
            model.addAttribute("avgRating", "N/A");
        }

        return "provider-reviews";
    }

    /**
     * POST /providers/{id}/reviews/{reviewId}/reply
     * Submit a reply to a specific review.
     */
    @PostMapping("/{id}/reviews/{reviewId}/reply")
    public String replyToReview(@PathVariable Long id,
                                 @PathVariable Long reviewId,
                                 @RequestParam String replyText) {
        Optional<Review> reviewOpt = reviewService.getReviewById(reviewId);
        if (reviewOpt.isPresent()) {
            Review replyData = new Review();
            replyData.setReplyText(replyText);
            reviewService.updateReview(reviewId, replyData);
        }
        return "redirect:/providers/" + id + "/reviews";
    }

    // -------------------------------------------------------
    // STATISTICS
    // -------------------------------------------------------

    /**
     * GET /providers/{id}/statistics
     * Show circle statistics: member count, upcoming RSVPs, average rating.
     */
    @GetMapping("/{id}/statistics")
    public String getStatistics(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        model.addAttribute("provider", providerOpt.get());

        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        if (circleOpt.isPresent()) {
            Circle circle = circleOpt.get();
            model.addAttribute("circle", circle);

            // Member count (from memberships on circle's events)
           int memberCount = circle.getEvents() == null ? 0 : circle.getEvents().size();
            model.addAttribute("memberCount", memberCount);

            // Upcoming events count
            int upcomingCount = (int) (circle.getEvents() == null ? 0 : circle.getEvents().stream()
            .filter(e -> e.getStatus() == com.example.HobbyCircles.entity.Event.EventStatus.UPCOMING)
            .count());
            model.addAttribute("upcomingCount", upcomingCount);

            // Average rating from reviews
            List<Review> reviews = reviewService.getReviewsByCircleId(circle.getCircleId());
            double avgRating = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
            model.addAttribute("reviewCount", reviews.size());
            model.addAttribute("avgRating", String.format("%.1f", avgRating));
        } else {
            model.addAttribute("memberCount", 0);
            model.addAttribute("upcomingCount", 0);
            model.addAttribute("reviewCount", 0);
            model.addAttribute("avgRating", "N/A");
        }

        return "provider-statistics";
    }
    // -------------------------------------------------------
    // EVENT SCHEDULING
    // -------------------------------------------------------

    /**
     * GET /providers/{id}/events/new
     * Show the schedule event form.
     */
    @GetMapping("/{id}/events/new")
    public String showEventForm(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        model.addAttribute("provider", providerOpt.get());

        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        if (circleOpt.isEmpty()) {
            model.addAttribute("errorMessage", "You need to create a circle before scheduling an event.");
            return "error";
        }
        model.addAttribute("circle", circleOpt.get());

        return "provider-event-form";
    }

    /**
     * POST /providers/{id}/events/save
     * Save a new event to the database.
     */
    @PostMapping("/{id}/events/save")
    public String saveEvent(@PathVariable Long id, Event event, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }

        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        if (circleOpt.isEmpty()) {
            model.addAttribute("errorMessage", "No circle found for this provider.");
            return "error";
        }

        event.setCircle(circleOpt.get());
        event.setStatus(com.example.HobbyCircles.entity.Event.EventStatus.UPCOMING);
        eventService.createEvent(event);

        return "redirect:/providers/" + id;
    }
    /**
     * GET /providers/{id}/events
     * Show all events for this provider's circle.
     */
    @GetMapping("/{id}/events")
    public String getEvents(@PathVariable Long id, Model model) {
        Optional<Provider> providerOpt = providerService.getProviderById(id);
        if (providerOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Provider not found with ID: " + id);
            return "error";
        }
        model.addAttribute("provider", providerOpt.get());

        Optional<Circle> circleOpt = circleService.getCircleByProviderId(id);
        if (circleOpt.isPresent()) {
            model.addAttribute("circle", circleOpt.get());
            model.addAttribute("events", circleOpt.get().getEvents());
        } else {
            model.addAttribute("events", java.util.List.of());
        }

        return "provider-events";
    }
}
