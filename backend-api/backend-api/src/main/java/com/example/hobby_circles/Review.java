package com.example.hobby_circles;

import jakarta.persistence.*;

@Entity
@Table(name = "reviews")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int rating;
    private String comment;

    @Column(name = "hobbyist_id")
    private Long hobbyistId;

    @Column(name = "circle_id")
    private Long circleId;

    public Review() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Long getHobbyistId() { return hobbyistId; }
    public void setHobbyistId(Long hobbyistId) { this.hobbyistId = hobbyistId; }
    public Long getCircleId() { return circleId; }
    public void setCircleId(Long circleId) { this.circleId = circleId; }
}