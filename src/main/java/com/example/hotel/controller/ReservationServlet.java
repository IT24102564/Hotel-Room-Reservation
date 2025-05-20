package com.example.hotel.controller;

import com.google.gson.Gson;
import com.example.hotel.dto.ReservationDTO;
import com.example.hotel.model.Reservation;
import com.example.hotel.service.ReservationService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reservations/*")
public class ReservationServlet extends HttpServlet {
    private ReservationService reservationService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all reservations or filter by userId
                String userId = request.getParameter("userId");
                System.out.println("User Id"+userId);
                List<ReservationDTO> reservations;

                if (userId != null && !userId.isEmpty()) {
                    reservations = reservationService.getReservationsByUserId(userId);
                } else {
                    reservations = reservationService.getAllReservations();
                }

                response.getWriter().write(gson.toJson(reservations));
            } else {
                // Get reservation by ID
                String reservationId = pathInfo.substring(1);
                Optional<ReservationDTO> reservation = reservationService.getReservationById(reservationId);

                if (reservation.isPresent()) {
                    response.getWriter().write(gson.toJson(reservation.get()));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"error\":\"Reservation not found\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new reservation
            BufferedReader reader = request.getReader();
            Reservation reservation = gson.fromJson(reader, Reservation.class);

            ReservationDTO createdReservation = reservationService.createReservation(reservation);

            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdReservation));
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String reservationId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            Reservation reservation = gson.fromJson(reader, Reservation.class);
            reservation.setId(reservationId);

            boolean updated = reservationService.updateReservation(reservation);

            if (updated) {
                Optional<ReservationDTO> updatedReservation = reservationService.getReservationById(reservationId);

                if (updatedReservation.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedReservation.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated reservation");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String reservationId = pathInfo.substring(1);

            boolean deleted = reservationService.deleteReservation(reservationId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required");
        }
    }
}