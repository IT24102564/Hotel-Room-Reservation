package com.example.hotel.service;

import com.example.hotel.dto.FeedbackDTO;
import com.example.hotel.model.Feedback;
import com.example.hotel.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class FeedbackService {
    private static final String FILE_NAME = "feedback.txt";
    
    public List<FeedbackDTO> getAllFeedback() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<FeedbackDTO> feedbackList = new ArrayList<>();
        
        for (String line : lines) {
            Feedback feedback = parseFeedback(line);
            if (feedback != null) {
                feedbackList.add(convertToDTO(feedback));
            }
        }
        
        return feedbackList;
    }
    
    public List<FeedbackDTO> getFeedbackByUserId(String userId) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<FeedbackDTO> feedbackList = new ArrayList<>();
        
        for (String line : lines) {
            Feedback feedback = parseFeedback(line);
            if (feedback != null && feedback.getUserId().equals(userId)) {
                feedbackList.add(convertToDTO(feedback));
            }
        }
        
        return feedbackList;
    }
    
    public Optional<FeedbackDTO> getFeedbackById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        
        for (String line : lines) {
            Feedback feedback = parseFeedback(line);
            if (feedback != null && feedback.getId().equals(id)) {
                return Optional.of(convertToDTO(feedback));
            }
        }
        
        return Optional.empty();
    }
    
    public FeedbackDTO createFeedback(Feedback feedback) {
        feedback.setId(FileHandler.generateId());
        FileHandler.appendToFile(FILE_NAME, feedback.toString());
        
        return convertToDTO(feedback);
    }
    
    public boolean updateFeedback(Feedback feedback) {
        return FileHandler.updateLineInFile(FILE_NAME, feedback.getId(), feedback.toString());
    }
    
    public boolean deleteFeedback(String id) {
        return FileHandler.deleteLineFromFile(FILE_NAME, id);
    }
    
    private Feedback parseFeedback(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 6) {
            return new Feedback(
                parts[0],
                parts[1],
                parts[2],
                Integer.parseInt(parts[3]),
                parts[4],
                parts[5]
            );
        }
        return null;
    }
    
    private FeedbackDTO convertToDTO(Feedback feedback) {
        return new FeedbackDTO(
            feedback.getId(),
            feedback.getUserId(),
            feedback.getReservationId(),
            feedback.getRating(),
            feedback.getComment(),
            feedback.getSubmissionDate()
        );
    }
}