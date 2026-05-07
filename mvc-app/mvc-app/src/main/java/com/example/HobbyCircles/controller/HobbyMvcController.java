package com.example.HobbyCircles.controller;

import com.example.HobbyCircles.entity.Circle;
import com.example.HobbyCircles.entity.Event;
import com.example.HobbyCircles.entity.Membership;
import com.example.HobbyCircles.entity.Review;
import com.example.HobbyCircles.repository.CircleRepository;
import com.example.HobbyCircles.repository.EventRepository;
import com.example.HobbyCircles.repository.MembershipRepository;
import com.example.HobbyCircles.repository.ReviewRepository;
import com.example.HobbyCircles.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class HobbyMvcController {

    @Autowired
    private CircleRepository circleRepository;

    @Autowired
    private MembershipRepository membershipRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EventRepository eventRepository;

    // ── Browse / Search Circles ──────────────────────────────────────────────

    @GetMapping("/search")
    public String search(@RequestParam(name = "query", required = false) String query,
                         HttpSession session,
                         Model model) {

        List<Circle> circles;
        if (query != null && !query.isBlank()) {
            circles = circleRepository.findByNameContainingIgnoreCase(query);
            if (circles.isEmpty()) circles = circleRepository.findByCity(query);
            if (circles.isEmpty()) circles = circleRepository.findByCategory(query);
        } else {
            circles = circleRepository.findAll();
        }

        model.addAttribute("circles",   circles);
        model.addAttribute("query",     query);
        model.addAttribute("userId",    session.getAttribute("userId"));
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "circle-list";
    }

    // ── Join a Circle ────────────────────────────────────────────────────────

    @GetMapping("/join/{id}")
    public String showJoinForm(@PathVariable Long id,
                               HttpSession session,
                               Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/?next=/join/" + id;
        }
        circleRepository.findById(id).ifPresent(c -> model.addAttribute("circle", c));
        model.addAttribute("circleId",  id);
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "join-form";
    }

    @PostMapping("/join/submit")
    public String processJoin(@RequestParam Long circleId,
                              @RequestParam String userName,
                              @RequestParam String email,
                              @RequestParam String phone,
                              @RequestParam String reason,
                              HttpSession session,
                              RedirectAttributes ra) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        circleRepository.findById(circleId).ifPresent(circle -> {
            Membership membership = new Membership();
            membership.setCircle(circle);
            membership.setHobbyistId((Long) session.getAttribute("userId"));
            membership.setStatus(Membership.MembershipStatus.ACTIVE);
            membershipRepository.save(membership);
        });

        ra.addFlashAttribute("name", userName);
        ra.addFlashAttribute("circleId", circleId);
        return "redirect:/joined-success";
    }

    @GetMapping("/joined-success")
    public String joinedSuccess(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        List<Membership> memberships = membershipRepository.findAll()
            .stream()
            .filter(m -> m.getStatus() == Membership.MembershipStatus.ACTIVE
                      && userId.equals(m.getHobbyistId()))
            .toList();
        model.addAttribute("memberships", memberships);
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "joined-circles";
    }

    // ── Leave a Circle ───────────────────────────────────────────────────────

    @PostMapping("/leave/{membershipId}")
    public String leaveCircle(@PathVariable Long membershipId,
                              HttpSession session,
                              RedirectAttributes ra) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        Long userId = (Long) session.getAttribute("userId");
        membershipRepository.findById(membershipId).ifPresent(membership -> {
            if (userId.equals(membership.getHobbyistId())) {
                membership.setStatus(Membership.MembershipStatus.CANCELLED);
                membershipRepository.save(membership);
            }
        });
        ra.addFlashAttribute("successMessage", "You have left the circle.");
        return "redirect:/hobbyist/dashboard";
    }

    // ── View Events for a Circle ─────────────────────────────────────────────

    @GetMapping("/circle/{circleId}/events")
    public String viewCircleEvents(@PathVariable Long circleId,
                                   HttpSession session,
                                   Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        circleRepository.findById(circleId).ifPresent(c -> model.addAttribute("circle", c));
        List<Event> events = eventRepository.findByCircleCircleId(circleId);
        model.addAttribute("events", events);
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "circle-events";
    }

    // ── Write a Review ───────────────────────────────────────────────────────

    @GetMapping("/review/{circleId}")
    public String showReviewForm(@PathVariable Long circleId,
                                 HttpSession session,
                                 Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        circleRepository.findById(circleId).ifPresent(c -> model.addAttribute("circle", c));
        return "write-review";
    }

    @PostMapping("/review/submit")
    public String submitReview(@RequestParam Long circleId,
                               @RequestParam Integer rating,
                               @RequestParam String comment,
                               HttpSession session,
                               RedirectAttributes ra) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }

        Long userId = (Long) session.getAttribute("userId");

        Review review = new Review();
        review.setCircleId(circleId);
        review.setHobbyistId(userId);
        review.setRating(rating);
        review.setComment(comment);
        reviewRepository.save(review);

        ra.addFlashAttribute("successMessage", "Your review has been submitted!");
        return "redirect:/search";
    }

    // ── Hobbyist Dashboard ───────────────────────────────────────────────────

    @GetMapping("/hobbyist/dashboard")
    public String hobbyistDashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        Long userId = (Long) session.getAttribute("userId");
        List<Membership> memberships = membershipRepository.findAll()
            .stream()
            .filter(m -> m.getStatus() == Membership.MembershipStatus.ACTIVE
                      && userId.equals(m.getHobbyistId()))
            .toList();
        model.addAttribute("memberships", memberships);
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "hobbyist-dashboard";
    }

    // ── Edit Profile ─────────────────────────────────────────────────────────

    @GetMapping("/profile/edit/{id}")
    public String editProfile(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/";
        model.addAttribute("userEmail", session.getAttribute("userEmail"));
        return "edit-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String email,
                                @RequestParam(required = false) String password,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (session.getAttribute("userId") == null) return "redirect:/";
        Long userId = (Long) session.getAttribute("userId");
        userRepository.findById(userId).ifPresent(user -> {
            user.setEmail(email);
            if (password != null && !password.isBlank()) {
                user.setPasswordHash(password);
            }
            userRepository.save(user);
            session.setAttribute("userEmail", email);
        });
        ra.addFlashAttribute("successMessage", "Profile updated!");
        return "redirect:/profile/edit/" + userId;
    }
}