
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Luxe Hotel Room Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">
            Back to Home
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-purple-800">Room List</h2>
        <button id="createRoomBtn" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-md transition duration-300 flex items-center">
            <i class="fas fa-plus mr-2"></i> Create Room
        </button>
    </div>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12 hidden">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 hidden" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline"></span>
    </div>

    <!-- Rooms Table -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Room Number</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price/Night</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Capacity</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="roomsTableBody" class="bg-white divide-y divide-gray-200">
            <!-- Room data will be populated here by JavaScript -->
            </tbody>
        </table>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Elements
        const loadingIndicator = document.getElementById('loadingIndicator');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const roomsTableBody = document.getElementById('roomsTableBody');
        const createRoomBtn = document.getElementById('createRoomBtn');

        // Show loading indicator
        function showLoading() {
            loadingIndicator.classList.remove('hidden');
            roomsTableBody.innerHTML = '';
        }

        // Hide loading indicator
        function hideLoading() {
            loadingIndicator.classList.add('hidden');
        }

        // Show error message
        function showError(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
        }

        // Hide error message
        function hideError() {
            errorMessage.classList.add('hidden');
        }

        // Format price with currency
        function formatPrice(price) {
            return '$' + parseFloat(price).toFixed(2);
        }

        // Load rooms data
        async function loadRooms() {
            showLoading();
            hideError();

            try {
                const response = await fetch('${pageContext.request.contextPath}/rooms/');

                if (!response.ok) {
                    throw new Error('Failed to load rooms. Status: ' + response.status);
                }

                const data = await response.json();
                displayRooms(data);
            } catch (error) {
                console.error('Error loading rooms:', error);
                showError(error.message || 'Failed to load rooms');
            } finally {
                hideLoading();
            }
        }

        // Display rooms in the table
        function displayRooms(rooms) {
            if (!rooms || rooms.length === 0) {
                roomsTableBody.innerHTML = `
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">
                            No rooms found. Click "Create Room" to add a new room.
                        </td>
                    </tr>
                `;
                return;
            }

            roomsTableBody.innerHTML = '';

            rooms.forEach(room => {
                const row = document.createElement('tr');
                row.className = 'hover:bg-gray-50';

                row.innerHTML =
                    "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                    "<div class=\"text-sm font-medium text-gray-900\">" + room.roomNumber + "</div>" +
                    "</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                    "<div class=\"text-sm text-gray-900\">" + room.roomType + "</div>" +
                    "</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                    "<div class=\"text-sm text-gray-900\">" + formatPrice(room.pricePerNight) + "</div>" +
                    "</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                    "<div class=\"text-sm text-gray-900\">" + room.capacity + " person(s)</div>" +
                    "</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                    "<span class=\"px-2 inline-flex text-xs leading-5 font-semibold rounded-full " +
                    (room.available ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800') +
                    "\">" +
                    (room.available ? 'Available' : 'Booked') +
                    "</span>" +
                    "</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium\">" +
                    "<button class=\"text-indigo-600 hover:text-indigo-900 mr-3\" onclick=\"editRoom('" + room.id + "')\">" +
                    "<i class=\"fas fa-edit\"></i> Edit" +
                    "</button>" +
                    "<button class=\"text-red-600 hover:text-red-900\" onclick=\"deleteRoom('" + room.id + "')\">" +
                    "<i class=\"fas fa-trash-alt\"></i> Delete" +
                    "</button>" +
                    "</td>";
                roomsTableBody.appendChild(row);
            });
        }

        // Edit room function
        window.editRoom = function(roomId) {
            window.location.href = '${pageContext.request.contextPath}/edit-room?id=' + roomId;
        };

        // Delete room function
        window.deleteRoom = async function(roomId) {
            if (!confirm('Are you sure you want to delete this room?')) {
                return;
            }

            showLoading();
            hideError();

            try {
                const response = await fetch('${pageContext.request.contextPath}/rooms/' + roomId, {
                    method: 'DELETE'
                });

                if (!response.ok) {
                    throw new Error('Failed to delete room. Status: ' + response.status);
                }

                // Reload rooms after successful deletion
                loadRooms();
            } catch (error) {
                console.error('Error deleting room:', error);
                showError(error.message || 'Failed to delete room');
                hideLoading();
            }
        };

        // Create room button click handler
        createRoomBtn.addEventListener('click', function() {
            window.location.href = '${pageContext.request.contextPath}/create-room';
        });

        // Load rooms when page loads
        loadRooms();
    });
</script>

</body>
</html>
