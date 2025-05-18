package com.example.hotel.controller;

import com.google.gson.Gson;
import com.example.hotel.dto.FeedbackDTO;
import com.example.hotel.model.Feedback;
import com.example.hotel.service.FeedbackService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/feedback/*")
public class FeedbackServlet extends HttpServlet {
    private FeedbackService feedbackService;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        feedbackService = new FeedbackService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson(); // Make sure this is initialized in init()

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all feedback or filter by userId
            String userId = request.getParameter("userId");
            List<FeedbackDTO> feedbackList;

            if (userId != null && !userId.isEmpty()) {
                feedbackList = feedbackService.getFeedbackByUserId(userId);
            } else {
                feedbackList = feedbackService.getAllFeedback();
            }

            response.getWriter().write(gson.toJson(feedbackList));
        } else {
            // Get feedback by ID
            String feedbackId = pathInfo.substring(1); // e.g., /123 -> 123
            Optional<FeedbackDTO> feedbackOptional = feedbackService.getFeedbackById(feedbackId);

            if (feedbackOptional.isPresent()) {
                response.getWriter().write(gson.toJson(feedbackOptional.get()));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Feedback not found\"}");
            }
        }

        response.getWriter().close();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new feedback
            BufferedReader reader = request.getReader();
            Feedback feedback = gson.fromJson(reader, Feedback.class);
            
            FeedbackDTO createdFeedback = feedbackService.createFeedback(feedback);
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdFeedback));
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && !pathInfo.equals("/")) {
            String feedbackId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            Feedback feedback = gson.fromJson(reader, Feedback.class);
            feedback.setId(feedbackId);
            
            boolean updated = feedbackService.updateFeedback(feedback);
            
            if (updated) {
                Optional<FeedbackDTO> updatedFeedback = feedbackService.getFeedbackById(feedbackId);
                
                if (updatedFeedback.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedFeedback.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated feedback");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Feedback not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Feedback ID is required");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && !pathInfo.equals("/")) {
            String feedbackId = pathInfo.substring(1);
            
            boolean deleted = feedbackService.deleteFeedback(feedbackId);
            
            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Feedback not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Feedback ID is required");
        }
    }
}