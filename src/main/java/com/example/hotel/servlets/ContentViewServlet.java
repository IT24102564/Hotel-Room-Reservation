package com.example.hotel.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ContentViewServlet")
public class ContentViewServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String action = request.getServletPath();
        String view;
        switch (action){
            case "/create-content":
                view = "/views/content/create.jsp";
                break;
            case "/edit-content":
                view = "/views/content/edit.jsp";
                break;
            case "/content-details":
                view = "/views/content/details.jsp";
                break;
            default:
                view = "/views/content/all.jsp";
        }
        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error forwarding to JSP: " + view, e);
        }
    }
}