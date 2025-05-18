package com.example.hotel.dto;

public class FeedbackDTO {
    private String id;
    private String userId;
    private String reservationId;
    private int rating;
    private String comment;
    private String submissionDate;
    
    public FeedbackDTO() {
    }
    
    public FeedbackDTO(String id, String userId, String reservationId, int rating, String comment, String submissionDate) {
        this.id = id;
        this.userId = userId;
        this.reservationId = reservationId;
        this.rating = rating;
        this.comment = comment;
        this.submissionDate = submissionDate;
    }
    
    // Getters and Setters
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getReservationId() {
        return reservationId;
    }
    
    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public String getSubmissionDate() {
        return submissionDate;
    }
    
    public void setSubmissionDate(String submissionDate) {
        this.submissionDate = submissionDate;
    }
}