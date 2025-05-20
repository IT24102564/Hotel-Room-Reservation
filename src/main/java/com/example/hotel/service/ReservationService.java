package com.example.hotel.service;

import com.example.hotel.dto.ReservationDTO;
import com.example.hotel.model.Reservation;
import com.example.hotel.model.Room;
import com.example.hotel.util.FileHandler;
import com.example.hotel.util.QuickSort;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ReservationService {
    private static final String FILE_NAME = "reservations.txt";
    private RoomService roomService;

    public ReservationService() {
        this.roomService = new RoomService();
    }

    public List<ReservationDTO> getAllReservations() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<Reservation> reservations = new ArrayList<>();

        for (String line : lines) {
            Reservation reservation = parseReservation(line);
            if (reservation != null) {
                reservations.add(reservation);
            }
        }

        // Sort reservations by check-in date
        QuickSort.sort(reservations);

        // Convert to DTOs
        List<ReservationDTO> reservationDTOs = new ArrayList<>();
        for (Reservation reservation : reservations) {
            reservationDTOs.add(convertToDTO(reservation));
        }

        return reservationDTOs;
    }

    public List<ReservationDTO> getReservationsByUserId(String userId) {
        List<ReservationDTO> allReservations = getAllReservations();
        List<ReservationDTO> userReservations = new ArrayList<>();

        for (ReservationDTO reservation : allReservations) {
            if (reservation.getUserId().equals(userId)) {
                userReservations.add(reservation);
            }
        }

        return userReservations;
    }

    public Optional<ReservationDTO> getReservationById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            Reservation reservation = parseReservation(line);
            if (reservation != null && reservation.getId().equals(id)) {
                return Optional.of(convertToDTO(reservation));
            }
        }

        return Optional.empty();
    }

    public ReservationDTO createReservation(Reservation reservation) {
        reservation.setId(FileHandler.generateId());

        // Update room availability
        roomService.getRoomById(reservation.getRoomId()).ifPresent(roomDTO -> {
            Room room = new Room(
                    roomDTO.getId(),
                    roomDTO.getRoomNumber(),
                    roomDTO.getRoomType(),
                    roomDTO.getPricePerNight(),
                    roomDTO.getCapacity(),
                    false, // Set to unavailable
                    roomDTO.getAmenities(),
                    roomDTO.getImageUrl()
            );
            roomService.updateRoom(room);
        });

        FileHandler.appendToFile(FILE_NAME, reservation.toString());

        return convertToDTO(reservation);
    }

    public boolean updateReservation(Reservation reservation) {
        return FileHandler.updateLineInFile(FILE_NAME, reservation.getId(), reservation.toString());
    }

    public boolean deleteReservation(String id) {
        Optional<ReservationDTO> reservationOpt = getReservationById(id);

        if (reservationOpt.isPresent()) {
            ReservationDTO reservationDTO = reservationOpt.get();

            // Update room availability if reservation is deleted
            roomService.getRoomById(reservationDTO.getRoomId()).ifPresent(roomDTO -> {
                Room room = new Room(
                        roomDTO.getId(),
                        roomDTO.getRoomNumber(),
                        roomDTO.getRoomType(),
                        roomDTO.getPricePerNight(),
                        roomDTO.getCapacity(),
                        true,
                        roomDTO.getAmenities(),
                        roomDTO.getImageUrl()
                );
                roomService.updateRoom(room);
            });

            return FileHandler.deleteLineFromFile(FILE_NAME, id);
        }

        return false;
    }

    private Reservation parseReservation(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 9) {
            return new Reservation(
                    parts[0],
                    parts[1],
                    parts[2],
                    parts[3],
                    parts[4],
                    Integer.parseInt(parts[5]),
                    Double.parseDouble(parts[6]),
                    parts[7],
                    parts[8]
            );
        }
        return null;
    }

    private ReservationDTO convertToDTO(Reservation reservation) {
        return new ReservationDTO(
                reservation.getId(),
                reservation.getUserId(),
                reservation.getRoomId(),
                reservation.getCheckInDate(),
                reservation.getCheckOutDate(),
                reservation.getNumberOfGuests(),
                reservation.getTotalPrice(),
                reservation.getStatus(),
                reservation.getSpecialRequests()
        );
    }
}
