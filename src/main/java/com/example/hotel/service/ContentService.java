package com.example.hotel.service;

import com.example.hotel.dto.ContentDTO;
import com.example.hotel.model.Content;
import com.example.hotel.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ContentService {
    private static final String FILE_NAME = "content.txt";

    public List<ContentDTO> getAllContent() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<ContentDTO> contentList = new ArrayList<>();

        for (String line : lines) {
            Content content = parseContent(line);
            if (content != null) {
                contentList.add(convertToDTO(content));
            }
        }

        return contentList;
    }

    public List<ContentDTO> getActiveContent() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<ContentDTO> activeContent = new ArrayList<>();

        for (String line : lines) {
            Content content = parseContent(line);
            if (content != null && content.isActive()) {
                activeContent.add(convertToDTO(content));
            }
        }

        return activeContent;
    }

    public Optional<ContentDTO> getContentById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            Content content = parseContent(line);
            if (content != null && content.getId().equals(id)) {
                return Optional.of(convertToDTO(content));
            }
        }

        return Optional.empty();
    }

    public List<ContentDTO> getContentByType(String type) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<ContentDTO> contentList = new ArrayList<>();

        for (String line : lines) {
            Content content = parseContent(line);
            if (content != null && content.getType().equalsIgnoreCase(type)) {
                contentList.add(convertToDTO(content));
            }
        }

        return contentList;
    }

    public ContentDTO createContent(Content content) {
        content.setId(FileHandler.generateId());
        FileHandler.appendToFile(FILE_NAME, content.toString());

        return convertToDTO(content);
    }

    public boolean updateContent(Content content) {
        return FileHandler.updateLineInFile(FILE_NAME, content.getId(), content.toString());
    }

    public boolean deleteContent(String id) {
        return FileHandler.deleteLineFromFile(FILE_NAME, id);
    }

    private Content parseContent(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new Content(
                    parts[0],
                    parts[1],
                    parts[2],
                    parts[3],
                    parts[4],
                    parts[5],
                    parts[6],
                    Boolean.parseBoolean(parts[7])
            );
        }
        return null;
    }

    private ContentDTO convertToDTO(Content content) {
        return new ContentDTO(
                content.getId(),
                content.getTitle(),
                content.getDescription(),
                content.getType(),
                content.getImageUrl(),
                content.getStartDate(),
                content.getEndDate(),
                content.isActive()
        );
    }
}