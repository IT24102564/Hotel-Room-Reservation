<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reservations</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
<!-- Navbar -->
<nav class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex">
                <div class="flex-shrink-0 flex items-center">
                    <a href="${pageContext.request.contextPath}/" class="text-xl font-bold text-purple-700">Luxe Hotel</a>
                </div>
            </div>
            <div class="flex items-center">
                <a href="javascript:history.back()" class="text-gray-600 hover:text-purple-700 px-3 py-2 rounded-md text-sm font-medium">
                    <i class="fas fa-arrow-left mr-1"></i> Back
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6">My Reservations</h1>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load reservations.</span>
    </div>

    <!-- Reservations Table -->
    <div id="reservationsContainer" class="hidden overflow-x-auto bg-white shadow-md rounded-lg">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Room</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Check-in</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Check-out</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="reservationsTableBody" class="bg-white divide-y divide-gray-200">
            <!-- Reservations will be loaded here -->
            </tbody>
        </table>
    </div>

    <!-- No Reservations Message -->
    <div id="noReservationsMessage" class="hidden text-center py-12">
        <i class="fas fa-calendar-times text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-500 text-lg">You don't have any reservations yet</p>
    </div>
</main>

<script>
    // Global variables
    let reservations = [];
    let roomsCache = {};
    let userId = new URLSearchParams(window.location.search).get('userId');

    // DOM Elements
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const reservationsContainer = document.getElementById('reservationsContainer');
    const reservationsTableBody = document.getElementById('reservationsTableBody');
    const noReservationsMessage = document.getElementById('noReservationsMessage');

    // Helper function to show loading state
    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        reservationsContainer.classList.add('hidden');
        noReservationsMessage.classList.add('hidden');
        errorMessage.classList.add('hidden');
    }

    // Helper function to show error
    function showError(message) {
        loadingIndicator.classList.add('hidden');
        reservationsContainer.classList.add('hidden');
        noReservationsMessage.classList.add('hidden');
        errorMessage.classList.remove('hidden');
        errorText.textContent = message;
    }

    // Helper function to format date
    function formatDate(dateString) {
        const options = { year: 'numeric', month: 'short', day: 'numeric' };
        return new Date(dateString).toLocaleDateString(undefined, options);
    }

    // Get status badge HTML
    function getStatusBadge(status) {
        const statusClasses = {
            'CONFIRMED': 'bg-blue-100 text-blue-800',
            'CHECKED_IN': 'bg-green-100 text-green-800',
            'CHECKED_OUT': 'bg-gray-100 text-gray-800',
            'CANCELLED': 'bg-red-100 text-red-800',
            'PENDING': 'bg-yellow-100 text-yellow-800'
        };

        const statusDisplay = status.replace('_', ' ').toLowerCase()
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1))
            .join(' ');

        return "<span class=\"px-2 inline-flex text-xs leading-5 font-semibold rounded-full " +
            (statusClasses[status] || 'bg-gray-100 text-gray-800') + "\">" +
            statusDisplay +
            "</span>";
    }

    // Fetch room details by ID
    async function fetchRoomDetails(roomId) {
        // Check if room is already in cache
        if (roomsCache[roomId]) {
            return roomsCache[roomId];
        }

        try {
            const response = await fetch(`${pageContext.request.contextPath}/rooms/`+roomId);

            if (!response.ok) {
                throw new Error(`Failed to fetch room details`);
            }

            const roomData = await response.json();
            // Store in cache for future use
            roomsCache[roomId] = roomData;
            return roomData;
        } catch (error) {
            console.error('Error fetching room details:', error);
            return null;
        }
    }

    // Fetch user reservations
    async function fetchReservations() {
        showLoading();

        try {
            const response = await fetch(`${pageContext.request.contextPath}/reservations?userId=`+userId);

            if (!response.ok) {
                throw new Error(`Failed to fetch reservations: ${response.status}`);
            }

            reservations = await response.json();


            loadingIndicator.classList.add('hidden');

            if (reservations.length === 0) {
                noReservationsMessage.classList.remove('hidden');
                return;
            }

            await renderReservations(reservations);
            reservationsContainer.classList.remove('hidden');
        } catch (error) {
            console.error('Error fetching reservations:', error);
            showError(error.message);
        }
    }

    // Render reservations table
    async function renderReservations(reservationsToRender) {
        reservationsTableBody.innerHTML = '';

        for (const reservation of reservationsToRender) {
            // Fetch room details for each reservation
            const roomDetails = await fetchRoomDetails(reservation.roomId);

            const roomInfo = roomDetails
                ? roomDetails.roomNumber + " - " + roomDetails.roomType
                : "Room ID: " + reservation.roomId;

            const row = document.createElement('tr');

            // Create action buttons based on reservation status
            let actionButtons = '';
            if (reservation.status === 'PENDING') {
                actionButtons =
                    "<a href=\"" + "${pageContext.request.contextPath}" + "/edit-reservation?id=" + reservation.id + "&userId=" + userId + "\" class=\"text-blue-600 hover:text-blue-900 mr-3\">" +
                    "<i class=\"fas fa-edit\"></i> Edit" +
                    "</a>" +
                    "<button class=\"text-red-600 hover:text-red-900 delete-btn\" data-id=\"" + reservation.id + "\">" +
                    "<i class=\"fas fa-trash-alt\"></i> Delete" +
                    "</button>";
            } else {
                actionButtons =
                    "<a href=\"" +"${pageContext.request.contextPath}"+ "/reservation?id=" + reservation.id + "&userId=" + userId + "\" class=\"text-purple-600 hover:text-purple-900\">" +
                    "<i class=\"fas fa-eye\"></i> View" +
                    "</a>";
            }

            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900\">" + reservation.id + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + roomInfo + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + formatDate(reservation.checkInDate) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + formatDate(reservation.checkOutDate) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + getStatusBadge(reservation.status) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium\">" + actionButtons + "</td>";

            reservationsTableBody.appendChild(row);
        }

        // Add event listeners to delete buttons
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const reservationId = this.getAttribute('data-id');
                console.log("Reservation id "+reservationId)
                if (confirm('Are you sure you want to delete this reservation?')) {
                    deleteReservation(reservationId);
                }
            });
        });
    }

    // Delete reservation
    async function deleteReservation(reservationId) {
        try {
            const response = await fetch(`${pageContext.request.contextPath}/reservations/`+reservationId, {
                method: 'DELETE'
            });

            if (!response.ok) {
                throw new Error(`Failed to delete reservation`);
            }

            // Refresh reservations list
            await fetchReservations();

        } catch (error) {
            console.error('Error deleting reservation:', error);
            showError(error.message);
        }
    }

    // Event Listeners
    document.addEventListener('DOMContentLoaded', () => {
        // Check if userId is available
        if (!userId) {
            showError('User ID is required to view reservations');
            return;
        }


        fetchReservations();
    });
</script>
</body>
</html>