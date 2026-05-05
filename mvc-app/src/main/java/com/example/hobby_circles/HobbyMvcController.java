package com.example.hobby_circles;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@Controller
public class HobbyMvcController {

    @Autowired
    private HobbyCircleRepository repository;

    @Autowired
    private RegistrationRepository registrationRepository;

    @Autowired
    private HobbyistRepository hobbyistRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    // Root redirect
    @GetMapping("/")
    public String home() {
        return "redirect:/search";
    }

    // USE-CASE 1: SEARCH
    @GetMapping("/search")
    public String search(@RequestParam(name = "query", required = false) String query, Model model) {
        if (query != null && !query.isEmpty()) {
            model.addAttribute("circles", repository.findByNameContainingIgnoreCase(query));
        } else {
            model.addAttribute("circles", repository.findAll());
        }
        return "circle-list";
    }

    // USE-CASE 2: JOIN
    @GetMapping("/join/{id}")
    public String showJoinForm(@PathVariable Long id, Model model) {
        model.addAttribute("circleId", id);
        return "join-form";
    }

    @PostMapping("/join/submit")
    public String processJoin(@RequestParam Long circleId,
                              @RequestParam String userName,
                              @RequestParam String email,
                              @RequestParam String phone,
                              @RequestParam String reason,
                              RedirectAttributes ra) {
        Registration newReg = new Registration(circleId, userName, email, phone, reason);
        registrationRepository.save(newReg);

        ra.addFlashAttribute("name",      userName);
        ra.addFlashAttribute("userEmail", email);
        return "redirect:/joined-success";
    }

    @GetMapping("/joined-success")
    public String joinedSuccess(@ModelAttribute("userEmail") String email, Model model) {
        if (email != null && !email.isEmpty()) {
            model.addAttribute("memberships", registrationRepository.findByEmail(email));
        }
        return "joined-circles";
    }

    // USE-CASE 3: EDIT PROFILE
    @GetMapping("/profile/edit/{id}")
    public String showEditProfile(@PathVariable Long id, Model model) {
        Hobbyist hobbyist = hobbyistRepository.findById(id).orElse(new Hobbyist());
        model.addAttribute("hobbyist", hobbyist);
        return "edit-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Hobbyist hobbyist, RedirectAttributes ra) {
        hobbyistRepository.save(hobbyist);
        ra.addFlashAttribute("message", "Profile updated for " + hobbyist.getFirstName());
        return "redirect:/search";
    }

    // USE-CASE 4: WRITE REVIEW
    @GetMapping("/review/{circleId}")
    public String showReviewForm(@PathVariable Long circleId, Model model) {
        model.addAttribute("circleId",   circleId);
        model.addAttribute("hobbyistId", 1L); // default for standalone demo
        return "write-review";
    }

    @PostMapping("/review/submit")
    public String submitReview(@ModelAttribute Review review, RedirectAttributes ra) {
        reviewRepository.save(review);
        ra.addFlashAttribute("message", "Review submitted successfully!");
        return "redirect:/search";
    }

    // USE-CASE 5: HOBBYIST DASHBOARD
    @GetMapping("/hobbyist/dashboard")
    public String hobbyistDashboard(@RequestParam(name = "email", required = false) String email, Model model) {
        if (email != null && !email.isEmpty()) {
            model.addAttribute("memberships", registrationRepository.findByEmail(email));
            model.addAttribute("userEmail",   email);
        }
        return "hobbyist-dashboard";
    }
}