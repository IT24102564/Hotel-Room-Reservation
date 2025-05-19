package com.example.hotel.controller;

import com.google.gson.Gson;
import com.example.hotel.dto.ContentDTO;
import com.example.hotel.model.Content;
import com.example.hotel.service.ContentService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/content/*")
public class ContentServlet extends HttpServlet {
    private ContentService contentService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        contentService = new ContentService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();


        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all content or filter by type/active
            String type = request.getParameter("type");
            String activeParam = request.getParameter("active");
            List<ContentDTO> contentList;

            if (type != null && !type.isEmpty()) {
                contentList = contentService.getContentByType(type);
            } else if (activeParam != null && "true".equals(activeParam)) {
                contentList = contentService.getActiveContent();
            } else {
                contentList = contentService.getAllContent();
            }

            response.getWriter().write(gson.toJson(contentList));
        } else {
            // Get content by ID
            String contentId = pathInfo.substring(1);
            Optional<ContentDTO> content = contentService.getContentById(contentId);

            if (content.isPresent()) {
                response.getWriter().write(gson.toJson(content.get()));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Content not found\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {

            BufferedReader reader = request.getReader();
            Content content = gson.fromJson(reader, Content.class);

            ContentDTO createdContent = contentService.createContent(content);

            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdContent));
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String contentId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            Content content = gson.fromJson(reader, Content.class);
            content.setId(contentId);

            boolean updated = contentService.updateContent(content);

            if (updated) {
                Optional<ContentDTO> updatedContent = contentService.getContentById(contentId);

                if (updatedContent.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedContent.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated content");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Content not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Content ID is required");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String contentId = pathInfo.substring(1);

            boolean deleted = contentService.deleteContent(contentId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Content not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Content ID is required");
        }
    }
}
