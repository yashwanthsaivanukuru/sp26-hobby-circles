package com.example.hobby_circles;

import jakarta.persistence.*;

@Entity
@Table(name = "registrations")
public class Registration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long circleId;
    private String userName;
    private String email;
    private String phone;
    
    @Column(length = 1000)
    private String reason;

    // Default Constructor
    public Registration() {}

    // Constructor for easy saving
    public Registration(Long circleId, String userName, String email, String phone, String reason) {
        this.circleId = circleId;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.reason = reason;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public Long getCircleId() { return circleId; }
    public String getUserName() { return userName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getReason() { return reason; }
}