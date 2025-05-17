package com.example.hotel.controller;

import com.google.gson.Gson;
import com.example.hotel.dto.RoomDTO;
import com.example.hotel.model.Room;
import com.example.hotel.service.RoomService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rooms/*")
public class RoomServlet extends HttpServlet {
    private RoomService roomService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        roomService = new RoomService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all rooms or filter by availability
            String availableParam = request.getParameter("available");
            List<RoomDTO> rooms;

            if ("true".equals(availableParam)) {
                rooms = roomService.getAvailableRooms();
            } else {
                rooms = roomService.getAllRooms();
            }

            response.getWriter().write(gson.toJson(rooms));
        } else {
            // Get single room by ID
            String roomId = pathInfo.substring(1);
            Optional<RoomDTO> room = roomService.getRoomById(roomId);

            if (room.isPresent()) {
                response.getWriter().write(gson.toJson(room.get()));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Room not found\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new room
            BufferedReader reader = request.getReader();
            Room room = gson.fromJson(reader, Room.class);

            RoomDTO createdRoom = roomService.createRoom(room);

            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdRoom));
        } else if (pathInfo.equals("/refresh")) {
            // Refresh room tree
            roomService.refreshRoomTree();
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String roomId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            Room room = gson.fromJson(reader, Room.class);
            room.setId(roomId);

            boolean updated = roomService.updateRoom(room);

            if (updated) {
                Optional<RoomDTO> updatedRoom = roomService.getRoomById(roomId);

                if (updatedRoom.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedRoom.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated room");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Room not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Room ID is required");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String roomId = pathInfo.substring(1);

            boolean deleted = roomService.deleteRoom(roomId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Room not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Room ID is required");
        }
    }
}