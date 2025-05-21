package com.example.hotel.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class FileHandler {
    private static final String DATA_DIR = "data";

    static {
        File dataDir = new File(DATA_DIR);
        if (!dataDir.exists()) {
            dataDir.mkdir();
        }
    }

    public static synchronized String generateId() {
        return UUID.randomUUID().toString();
    }

    public static synchronized <T> void writeToFile(String fileName, List<T> items) {
        String filePath = DATA_DIR + "/" + fileName;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (T item : items) {
                writer.write(item.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static synchronized List<String> readFromFile(String fileName) {
        String filePath = DATA_DIR + "/" + fileName;
        List<String> lines = new ArrayList<>();

        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return lines;
    }

    public static synchronized boolean appendToFile(String fileName, String line) {
        String filePath = DATA_DIR + "/" + fileName;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(line);
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static synchronized boolean updateLineInFile(String fileName, String id, String newLine) {
        String filePath = DATA_DIR + "/" + fileName;
        List<String> lines = readFromFile(fileName);
        boolean found = false;

        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.startsWith(id + ",")) {
                lines.set(i, newLine);
                found = true;
                break;
            }
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (String line : lines) {
                    writer.write(line);
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        return false;
    }

    public static synchronized boolean deleteLineFromFile(String fileName, String id) {
        String filePath = DATA_DIR + "/" + fileName;
        List<String> lines = readFromFile(fileName);
        boolean found = false;

        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.startsWith(id + ",")) {
                lines.remove(i);
                found = true;
                break;
            }
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (String line : lines) {
                    writer.write(line);
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        return false;
    }
}