package com.example.hotel.model;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Reservation implements Serializable, Comparable<Reservation> {
    private String id;
    private String userId;
    private String roomId;
    private String checkInDate;
    private String checkOutDate;
    private int numberOfGuests;
    private double totalPrice;
    private String status; // confirmed, cancelled, completed
    private String specialRequests;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    public Reservation() {
    }

    public Reservation(String id, String userId, String roomId, String checkInDate, String checkOutDate, int numberOfGuests, double totalPrice, String status, String specialRequests) {
        this.id = id;
        this.userId = userId;
        this.roomId = roomId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.numberOfGuests = numberOfGuests;
        this.totalPrice = totalPrice;
        this.status = status;
        this.specialRequests = specialRequests;
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

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getNumberOfGuests() {
        return numberOfGuests;
    }

    public void setNumberOfGuests(int numberOfGuests) {
        this.numberOfGuests = numberOfGuests;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    @Override
    public String toString() {
        return id + "," + userId + "," + roomId + "," + checkInDate + "," + checkOutDate + "," + numberOfGuests + "," + totalPrice + "," + status + "," + specialRequests;
    }

    @Override
    public int compareTo(Reservation other) {
        try {
            Date thisDate = DATE_FORMAT.parse(this.checkInDate);
            Date otherDate = DATE_FORMAT.parse(other.checkInDate);
            return thisDate.compareTo(otherDate);
        } catch (ParseException e) {
            return 0;
        }
    }
}