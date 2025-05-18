package com.example.hotel.servlets;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RoomsServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        String jspPage;
        String pageTitle;

        switch (path) {
            case "/create-room":
                pageTitle = "Create New Room";
                jspPage = "/views/rooms/create-room.jsp";
                break;

            case "/edit-room":
                // You might fetch room details from a service here using roomId from query param
                String roomId = request.getParameter("id");
                request.setAttribute("roomId", roomId);
                pageTitle = "Edit Room Details";
                jspPage = "/views/rooms/edit-room.jsp";
                break;

            case "/room-details":
                String detailId = request.getParameter("id");
                request.setAttribute("roomId", detailId);
                pageTitle = "Room Details";
                jspPage = "/views/rooms/room-details.jsp";
                break;

            case "/rooms-list":
                pageTitle = "Hotel Rooms";
                jspPage = "/views/rooms/rooms.jsp";
                break;

            case "/admin/rooms":
                pageTitle = "Manage Hotel Rooms";
                jspPage = "/views/rooms/rooms-admin.jsp";
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }

        request.setAttribute("pageTitle", pageTitle);

        try {
            getServletContext()
                    .getRequestDispatcher(jspPage)
                    .forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error forwarding to JSP: " + jspPage, e);
        }
    }
}