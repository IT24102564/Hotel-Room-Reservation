package com.example.hotel.controller;

import com.google.gson.Gson;
import com.example.hotel.dto.UserDTO;
import com.example.hotel.model.User;
import com.example.hotel.service.UserService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/users/*")
public class UserServlet extends HttpServlet {
    private UserService userService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (pathInfo == null || pathInfo.equals("/")) {
            // Return all users as JSON
            List<UserDTO> users = userService.getAllUsers();
            response.getWriter().write(gson.toJson(users));
        } else {
            // Get user by ID
            String userId = pathInfo.substring(1);
            Optional<UserDTO> user = userService.getUserById(userId);

            if (user.isPresent()) {
                response.getWriter().write(gson.toJson(user.get()));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"User not found\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new user
            BufferedReader reader = request.getReader();
            User user = gson.fromJson(reader, User.class);

            UserDTO createdUser = userService.createUser(user);

            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdUser));
        } else if (pathInfo.equals("/login")) {
            // Handle login
            BufferedReader reader = request.getReader();
            User credentials = gson.fromJson(reader, User.class);

            Optional<User> user = userService.validateUser(credentials.getUsername(), credentials.getPassword());

            if (user.isPresent()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user.get());

                response.setContentType("application/json");
                UserDTO userDTO = new UserDTO(
                        user.get().getId(),
                        user.get().getUsername(),
                        user.get().getEmail(),
                        user.get().getFullName(),
                        user.get().getPhoneNumber(),
                        user.get().getRole()
                );
                response.getWriter().write(gson.toJson(userDTO));
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"Invalid username or password\"}");
            }
        } else if (pathInfo.equals("/logout")) {
            // Handle logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath());
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String userId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            User user = gson.fromJson(reader, User.class);
            user.setId(userId);

            boolean updated = userService.updateUser(user);

            if (updated) {
                Optional<UserDTO> updatedUser = userService.getUserById(userId);

                if (updatedUser.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedUser.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated user");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String userId = pathInfo.substring(1);

            boolean deleted = userService.deleteUser(userId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
        }
    }
}
