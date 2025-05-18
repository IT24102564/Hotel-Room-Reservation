package com.example.hotel.service;

import com.example.hotel.dto.RoomDTO;
import com.example.hotel.model.Room;
import com.example.hotel.util.BinarySearchTree;
import com.example.hotel.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class RoomService {
    private static final String FILE_NAME = "rooms.txt";
    private BinarySearchTree roomTree;

    public RoomService() {
        loadRoomsIntoTree();
    }

    private void loadRoomsIntoTree() {
        roomTree = new BinarySearchTree();
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            Room room = parseRoom(line);
            if (room != null) {
                roomTree.insert(room);
            }
        }
    }

    private Room parseRoom(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 8) {
            return new Room(
                    parts[0],
                    parts[1],
                    parts[2],
                    Double.parseDouble(parts[3]),
                    Integer.parseInt(parts[4]),
                    Boolean.parseBoolean(parts[5]),
                    parts[6],
                    parts[7]
            );
        }
        return null;
    }

    public List<RoomDTO> getAllRooms() {
        List<Room> rooms = roomTree.getAllRooms();
        List<RoomDTO> roomDTOs = new ArrayList<>();

        for (Room room : rooms) {
            roomDTOs.add(convertToDTO(room));
        }

        return roomDTOs;
    }

    public List<RoomDTO> getAvailableRooms() {
        List<Room> rooms = roomTree.getAllAvailableRooms();
        List<RoomDTO> roomDTOs = new ArrayList<>();

        for (Room room : rooms) {
            roomDTOs.add(convertToDTO(room));
        }

        return roomDTOs;
    }

    public Optional<RoomDTO> getRoomById(String id) {
        List<Room> rooms = roomTree.getAllRooms();

        for (Room room : rooms) {
            if (room.getId().equals(id)) {
                return Optional.of(convertToDTO(room));
            }
        }

        return Optional.empty();
    }

    public RoomDTO createRoom(Room room) {
        room.setId(FileHandler.generateId());
        roomTree.insert(room);
        FileHandler.appendToFile(FILE_NAME, room.toString());

        return convertToDTO(room);
    }

    public boolean updateRoom(Room room) {
        roomTree.update(room);
        return FileHandler.updateLineInFile(FILE_NAME, room.getId(), room.toString());
    }

    public boolean deleteRoom(String id) {
        List<Room> rooms = roomTree.getAllRooms();

        for (Room room : rooms) {
            if (room.getId().equals(id)) {
                roomTree.delete(room.getRoomNumber());
                return FileHandler.deleteLineFromFile(FILE_NAME, id);
            }
        }

        return false;
    }

    public void refreshRoomTree() {
        loadRoomsIntoTree();
    }

    private RoomDTO convertToDTO(Room room) {
        return new RoomDTO(
                room.getId(),
                room.getRoomNumber(),
                room.getRoomType(),
                room.getPricePerNight(),
                room.getCapacity(),
                room.isAvailable(),
                room.getAmenities(),
                room.getImageUrl()
        );
    }
}