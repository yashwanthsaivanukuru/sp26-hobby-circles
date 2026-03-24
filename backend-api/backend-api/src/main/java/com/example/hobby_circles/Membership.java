package com.example.hobby_circles;

import jakarta.persistence.*;

@Entity
@Table(name = "memberships")
public class Membership {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "hobbyist_id")
    private Long hobbyistId;

    @Column(name = "circle_id")
    private Long circleId;

    public Membership() {}
    public Membership(Long hobbyistId, Long circleId) {
        this.hobbyistId = hobbyistId;
        this.circleId = circleId;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getHobbyistId() { return hobbyistId; }
    public void setHobbyistId(Long hobbyistId) { this.hobbyistId = hobbyistId; }
    public Long getCircleId() { return circleId; }
    public void setCircleId(Long circleId) { this.circleId = circleId; }
}