package com.example.hotel.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="UserServlet")
public class UserServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        System.out.println(action);
        String view = "";
        switch (action){
            case "/edit-user":
                view = "/views/users/edit-user.jsp";
                break;
            case "/user-details":
                view = "/views/users/user-details.jsp";
                break;
            case "/admin/users":
                view = "/views/users/admin-users.jsp";
                break;
            default:
                view = "/views/users/users.jsp";
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
}