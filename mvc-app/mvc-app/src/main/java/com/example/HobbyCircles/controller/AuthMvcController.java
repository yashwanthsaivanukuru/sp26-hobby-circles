package main.java.com.example.HobbyCircles.controller;

import com.example.HobbyCircles.entity.Provider;
import com.example.HobbyCircles.entity.User;
import com.example.HobbyCircles.entity.UserRole;
import com.example.HobbyCircles.entity.UserStatus;
import com.example.HobbyCircles.repository.ProviderRepository;
import com.example.HobbyCircles.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthMvcController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProviderRepository providerRepository;

    // ── Show login page ──────────────────────────────────────────────────────

    @GetMapping("/")
    public String landingPage() {
        return "login";
    }

    @GetMapping("/auth/login")
    public String loginPage() {
        return "login";
    }

    // ── Process login ────────────────────────────────────────────────────────

    @PostMapping("/auth/login")
    public String handleLogin(@RequestParam String email,
                              @RequestParam String password,
                              HttpSession session,
                              RedirectAttributes ra) {

        User user = userRepository.findByEmail(email);

        if (user == null || !user.getPasswordHash().equals(password)) {
            ra.addFlashAttribute("errorMessage", "Invalid email or password. Please try again.");
            return "redirect:/";
        }

        if (user.getStatus() == UserStatus.SUSPENDED) {
            ra.addFlashAttribute("errorMessage", "Your account has been suspended.");
            return "redirect:/";
        }

        session.setAttribute("userId",    user.getUserId());
        session.setAttribute("userRole",  user.getRole().name());
        session.setAttribute("userEmail", user.getEmail());

        if (user.getRole() == UserRole.PROVIDER) {
            return "redirect:/providers/" + user.getUserId();
        } else {
            return "redirect:/search";
        }
    }

    // ── Process registration ─────────────────────────────────────────────────

    @PostMapping("/auth/register")
    public String handleRegister(@RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam String role,
                                 @RequestParam(required = false, defaultValue = "") String bio,
                                 HttpSession session,
                                 RedirectAttributes ra) {

        if (userRepository.findByEmail(email) != null) {
            ra.addFlashAttribute("errorMessage", "An account with that email already exists.");
            return "redirect:/?tab=register";
        }

        UserRole userRole;
        try {
            userRole = UserRole.valueOf(role.toUpperCase());
        } catch (IllegalArgumentException e) {
            userRole = UserRole.HOBBYIST;
        }

        Long savedUserId;

        if (userRole == UserRole.PROVIDER) {
            Provider provider = new Provider();
            provider.setEmail(email);
            provider.setPasswordHash(password);
            provider.setStatus(UserStatus.ACTIVE);
            provider.setRole(UserRole.PROVIDER);
            if (!bio.isBlank()) provider.setBio(bio);
            Provider saved = providerRepository.save(provider);
            savedUserId = saved.getUserId();
        } else {
            User hobbyist = new User();
            hobbyist.setEmail(email);
            hobbyist.setPasswordHash(password);
            hobbyist.setStatus(UserStatus.ACTIVE);
            hobbyist.setRole(UserRole.HOBBYIST);
            User saved = userRepository.save(hobbyist);
            savedUserId = saved.getUserId();
        }

        session.setAttribute("userId",    savedUserId);
        session.setAttribute("userRole",  userRole.name());
        session.setAttribute("userEmail", email);

        ra.addFlashAttribute("successMessage", "Welcome to HobbyCircles!");

        if (userRole == UserRole.PROVIDER) {
            return "redirect:/providers/" + savedUserId;
        } else {
            return "redirect:/search";
        }
    }

    // ── Logout ───────────────────────────────────────────────────────────────

    @GetMapping("/auth/logout")
    public String logout(HttpSession session, RedirectAttributes ra) {
        session.invalidate();
        ra.addFlashAttribute("successMessage", "You have been signed out.");
        return "redirect:/";
    }
}