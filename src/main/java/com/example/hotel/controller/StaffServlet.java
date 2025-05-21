package com.example.hotel.controller;

import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff/*")
public class StaffServlet extends HttpServlet {
    private StaffService staffService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
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
            // Get all staff or filter by department
            String department = request.getParameter("department");
            List<StaffDTO> staffList;

            if (department != null && !department.isEmpty()) {
                staffList = staffService.getStaffByDepartment(department);
            } else {
                staffList = staffService.getAllStaff();
            }

            response.getWriter().write(gson.toJson(staffList));
        } else {
            // Get staff by ID
            String staffId = pathInfo.substring(1);
            Optional<StaffDTO> staff = staffService.getStaffById(staffId);

            if (staff.isPresent()) {
                response.getWriter().write(gson.toJson(staff.get()));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Staff not found\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new staff
            BufferedReader reader = request.getReader();
            Staff staff = gson.fromJson(reader, Staff.class);

            StaffDTO createdStaff = staffService.createStaff(staff);

            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(createdStaff));
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String staffId = pathInfo.substring(1);
            BufferedReader reader = request.getReader();
            Staff staff = gson.fromJson(reader, Staff.class);
            staff.setId(staffId);

            boolean updated = staffService.updateStaff(staff);

            if (updated) {
                Optional<StaffDTO> updatedStaff = staffService.getStaffById(staffId);

                if (updatedStaff.isPresent()) {
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(updatedStaff.get()));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve updated staff");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Staff ID is required");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String staffId = pathInfo.substring(1);

            boolean deleted = staffService.deleteStaff(staffId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Staff ID is required");
        }
    }
}

