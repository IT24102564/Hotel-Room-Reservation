package com.example.hotel.util;

import com.example.hotel.model.Room;
import java.util.ArrayList;
import java.util.List;

public class BinarySearchTree {
    private Node root;
    
    private class Node {
        private Room room;
        private Node left;
        private Node right;
        
        public Node(Room room) {
            this.room = room;
            this.left = null;
            this.right = null;
        }
    }
    
    public BinarySearchTree() {
        this.root = null;
    }
    
    public void insert(Room room) {
        root = insertRec(root, room);
    }
    
    private Node insertRec(Node root, Room room) {
        if (root == null) {
            root = new Node(room);
            return root;
        }
        
        if (room.getRoomNumber().compareTo(root.room.getRoomNumber()) < 0) {
            root.left = insertRec(root.left, room);
        } else if (room.getRoomNumber().compareTo(root.room.getRoomNumber()) > 0) {
            root.right = insertRec(root.right, room);
        }
        
        return root;
    }
    
    public Room search(String roomNumber) {
        return searchRec(root, roomNumber);
    }
    
    private Room searchRec(Node root, String roomNumber) {
        if (root == null || root.room.getRoomNumber().equals(roomNumber)) {
            return (root != null) ? root.room : null;
        }
        
        if (roomNumber.compareTo(root.room.getRoomNumber()) < 0) {
            return searchRec(root.left, roomNumber);
        }
        
        return searchRec(root.right, roomNumber);
    }
    
    public List<Room> getAllAvailableRooms() {
        List<Room> availableRooms = new ArrayList<>();
        inOrderTraversal(root, availableRooms, true);
        return availableRooms;
    }
    
    public List<Room> getAllRooms() {
        List<Room> allRooms = new ArrayList<>();
        inOrderTraversal(root, allRooms, false);
        return allRooms;
    }
    
    private void inOrderTraversal(Node node, List<Room> rooms, boolean checkAvailability) {
        if (node != null) {
            inOrderTraversal(node.left, rooms, checkAvailability);
            
            if (!checkAvailability || node.room.isAvailable()) {
                rooms.add(node.room);
            }
            
            inOrderTraversal(node.right, rooms, checkAvailability);
        }
    }
    
    public boolean delete(String roomNumber) {
        if (search(roomNumber) == null) {
            return false;
        }
        
        root = deleteRec(root, roomNumber);
        return true;
    }
    
    private Node deleteRec(Node root, String roomNumber) {
        if (root == null) {
            return root;
        }
        
        if (roomNumber.compareTo(root.room.getRoomNumber()) < 0) {
            root.left = deleteRec(root.left, roomNumber);
        } else if (roomNumber.compareTo(root.room.getRoomNumber()) > 0) {
            root.right = deleteRec(root.right, roomNumber);
        } else {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }
            
            // Node with two children
            root.room = minValue(root.right);
            
            // Delete the inorder successor
            root.right = deleteRec(root.right, root.room.getRoomNumber());
        }
        
        return root;
    }
    
    private Room minValue(Node root) {
        Room minv = root.room;
        while (root.left != null) {
            minv = root.left.room;
            root = root.left;
        }
        return minv;
    }
    
    public void update(Room room) {
        delete(room.getRoomNumber());
        insert(room);
    }
}