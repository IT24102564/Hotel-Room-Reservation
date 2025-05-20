package com.example.hotel.service;

import com.example.hotel.dto.UserDTO;
import com.example.hotel.model.User;
import com.example.hotel.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserService {
    private static final String FILE_NAME = "users.txt";

    public List<UserDTO> getAllUsers() {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);
        List<UserDTO> users = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 7) {
                UserDTO user = new UserDTO(
                        parts[0],
                        parts[1],
                        parts[3],
                        parts[4],
                        parts[5],
                        parts[6]
                );
                users.add(user);
            }
        }

        return users;
    }

    public Optional<UserDTO> getUserById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 7 && parts[0].equals(id)) {
                UserDTO user = new UserDTO(
                        parts[0],
                        parts[1],
                        parts[3],
                        parts[4],
                        parts[5],
                        parts[6]
                );
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }

    public Optional<User> validateUser(String username, String password) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 7 && parts[1].equals(username) && parts[2].equals(password)) {
                User user = new User(
                        parts[0],
                        parts[1],
                        parts[2],
                        parts[3],
                        parts[4],
                        parts[5],
                        parts[6]
                );
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }

    public UserDTO createUser(User user) {
        user.setId(FileHandler.generateId());
        FileHandler.appendToFile(FILE_NAME, user.toString());

        return new UserDTO(
                user.getId(),
                user.getUsername(),
                user.getEmail(),
                user.getFullName(),
                user.getPhoneNumber(),
                user.getRole()
        );
    }
    private Optional<User> getUserEntityById(String id) {
        List<String> lines = FileHandler.readFromFile(FILE_NAME);

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 7 && parts[0].equals(id)) {
                User user = new User(
                        parts[0], // id
                        parts[1], // username
                        parts[2], // password
                        parts[3], // email
                        parts[4], // fullName
                        parts[5], // phoneNumber
                        parts[6]  // role
                );
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }







    public boolean updateUser(User user) {

        Optional<User> existingUserOpt = this.getUserEntityById(user.getId());

        if (existingUserOpt.isPresent()) {
            User existingUser = existingUserOpt.get();


            user.setPassword(existingUser.getPassword());
            user.setRole(existingUser.getRole());


            return FileHandler.updateLineInFile(FILE_NAME, user.getId(), user.toString());
        }

        return false;
    }

    public boolean deleteUser(String id) {
        return FileHandler.deleteLineFromFile(FILE_NAME, id);
    }
}
