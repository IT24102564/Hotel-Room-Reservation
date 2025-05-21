package com.example.hotel.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "StaffViewServlet")
public class StaffViewServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        String view;
        String title;

        switch (action) {
            case "/create-staff":
                title = "Create New Staff";
                view = "/views/staff/create.jsp";
                break;

            case "/edit-staff":
                String staffId = request.getParameter("id");
                request.setAttribute("staffId", staffId);
                title = "Edit Staff Details";
                view = "/views/staff/edit.jsp";
                break;

            case "/staff-details":
                String detailId = request.getParameter("id");
                request.setAttribute("staffId", detailId);
                title = "Staff Details";
                view = "/views/staff/details.jsp";
                break;

            default: // "/staff-list"
                title = "Staff List";
                view = "/views/staff/all.jsp";
                break;
        }

        request.setAttribute("pageTitle", title);

        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error forwarding to JSP: " + view, e);
        }
    }
}
