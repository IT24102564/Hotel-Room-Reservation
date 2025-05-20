package com.example.hotel.service;

import com.example.hotel.dto.StaffDTO;
import com.example.hotel.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class StaffService {
    private static final String FILE_NAME = "staff.txt";

    public List<StaffDTO> getAllStaff() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<StaffDTO> staffList = new ArrayList<>();

        for (String line : lines) {
            Staff staff = parseStaff(line);
            if (staff != null) {
                staffList.add(convertToDTO(staff));
            }
        }

        return staffList;
    }

    public Optional<StaffDTO> getStaffById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            Staff staff = parseStaff(line);
            if (staff != null && staff.getId().equals(id)) {
                return Optional.of(convertToDTO(staff));
            }
        }

        return Optional.empty();
    }

    public List<StaffDTO> getStaffByDepartment(String department) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<StaffDTO> staffList = new ArrayList<>();

        for (String line : lines) {
            Staff staff = parseStaff(line);
            if (staff != null && staff.getDepartment().equalsIgnoreCase(department)) {
                staffList.add(convertToDTO(staff));
            }
        }

        return staffList;
    }

    public StaffDTO createStaff(Staff staff) {
        staff.setId(FileHandler.generateId());
        FileHandler.appendToFile(FILE_NAME, staff.toString());

        return convertToDTO(staff);
    }

    public boolean updateStaff(Staff staff) {
        return FileHandler.updateLineInFile(FILE_NAME, staff.getId(), staff.toString());
    }

    public boolean deleteStaff(String id) {
        return FileHandler.deleteLineFromFile(FILE_NAME, id);
    }

    private Staff parseStaff(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new Staff(
                    parts[0],
                    parts[1],
                    parts[2],
                    parts[3],
                    parts[4],
                    parts[5],
                    Double.parseDouble(parts[6]),
                    parts[7]
            );
        }
        return null;
    }

    private StaffDTO convertToDTO(Staff staff) {
        return new StaffDTO(
                staff.getId(),
                staff.getName(),
                staff.getPosition(),
                staff.getEmail(),
                staff.getPhoneNumber(),
                staff.getDepartment(),
                staff.getSalary(),
                staff.getHireDate()
        );
    }
}
