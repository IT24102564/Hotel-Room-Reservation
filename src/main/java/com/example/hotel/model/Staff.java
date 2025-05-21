package com.example.hotel.model;

import java.io.Serializable;

public class Staff implements Serializable {
    private String id;
    private String name;
    private String position;
    private String email;
    private String phoneNumber;
    private String department;
    private double salary;
    private String hireDate;

    public Staff() {
    }

    public Staff(String id, String name, String position, String email, String phoneNumber, String department, double salary, String hireDate) {
        this.id = id;
        this.name = name;
        this.position = position;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.department = department;
        this.salary = salary;
        this.hireDate = hireDate;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + position + "," + email + "," + phoneNumber + "," + department + "," + salary + "," + hireDate;
    }
}

