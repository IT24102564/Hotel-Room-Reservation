package com.example.hotel.servlets;

import com.example.hotel.dto.ReservationDTO;
import com.example.hotel.dto.RoomDTO;
import com.example.hotel.service.ReservationService;
import com.example.hotel.service.RoomService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "ReservationViewServlet", value = {
        "/reservations",
        "/create-reserve",
        "/edit-reservation",
        "/reservation",
        "/my-reservations"
})
public class ReservationViewServlet extends HttpServlet {
    private final ReservationService reservationService = new ReservationService();
    private  final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();


        String jspPage;
        String pageTitle;

        switch (path) {
            case "/create-reserve":
                List<RoomDTO> availableRooms = roomService.getAllRooms();
                request.setAttribute("availableRooms", availableRooms);
                System.out.println("There are "+availableRooms.size());
                pageTitle = "Create Reservation";
                jspPage = "/views/reservations/create.jsp";
                break;

            case "/edit-reservation":
                pageTitle = "Edit Reservation";
                jspPage = "/views/reservations/edit.jsp";
                String editId = request.getParameter("id");

                if (editId != null && !editId.isEmpty()) {
                    String userId = request.getParameter("userId");

                    if (userId == null || userId.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
                        return;
                    }
                    Optional<ReservationDTO> reservationOpt = reservationService.getReservationById(editId);
                    if (reservationOpt.isPresent() && reservationOpt.get().getUserId().equals(userId)) {
                        request.setAttribute("reservation", reservationOpt.get());
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found or doesn't belong to user");
                        return;
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required");
                    return;
                }
                break;

            case "/reservation":
                pageTitle = "Reservation Details";
                jspPage = "/views/reservations/reservation.jsp";
                String viewId = request.getParameter("id");
                if (viewId != null && !viewId.isEmpty()) {
                    String userId = request.getParameter("userId");

                    if (userId == null || userId.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
                        return;
                    }
                    Optional<ReservationDTO> reservationOpt = reservationService.getReservationById(viewId);
                    if (reservationOpt.isPresent() && reservationOpt.get().getUserId().equals(userId)) {
                        request.setAttribute("reservation", reservationOpt.get());
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found or doesn't belong to user");
                        return;
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required");
                    return;
                }
                break;

            case "/my-reservations":
                pageTitle = "My Reservations";
                jspPage = "/views/reservations/my-reservations.jsp";
                String userId = request.getParameter("userId");

                if (userId == null || userId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
                    return;
                }
                List<ReservationDTO> userReservations = reservationService.getReservationsByUserId(userId);
                request.setAttribute("myReservations", userReservations);
                break;

            default:
                pageTitle = "All Reservations";
                jspPage = "/views/reservations/reservations.jsp";
                List<ReservationDTO> allReservations = reservationService.getAllReservations();
                request.setAttribute("reservations", allReservations);
        }

        request.setAttribute("pageTitle", pageTitle);


        try {
            request.getRequestDispatcher(jspPage).forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error forwarding to JSP: " + jspPage, e);
        }
    }
}
