package com.example.hotel.util;

import com.example.hotel.model.Reservation;
import java.util.List;

public class QuickSort {

    public static void sort(List<Reservation> reservations) {
        if (reservations == null || reservations.size() <= 1) {
            return;
        }
        quickSort(reservations, 0, reservations.size() - 1);
    }

    private static void quickSort(List<Reservation> reservations, int low, int high) {
        if (low < high) {
            int pi = partition(reservations, low, high);

            // Recursively sort elements before and after partition
            quickSort(reservations, low, pi - 1);
            quickSort(reservations, pi + 1, high);
        }
    }

    private static int partition(List<Reservation> reservations, int low, int high) {
        // Choosing the rightmost element as pivot
        Reservation pivot = reservations.get(high);

        // Index of smaller element
        int i = (low - 1);

        for (int j = low; j < high; j++) {
            // If current element is smaller than the pivot
            if (reservations.get(j).compareTo(pivot) < 0) {
                i++;
                swap(reservations, i, j);
            }
        }

        swap(reservations, i + 1, high);

        return i + 1;
    }

    private static void swap(List<Reservation> reservations, int i, int j) {
        Reservation temp = reservations.get(i);
        reservations.set(i, reservations.get(j));
        reservations.set(j, temp);
    }
}