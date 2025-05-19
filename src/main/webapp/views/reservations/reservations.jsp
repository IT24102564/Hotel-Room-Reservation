<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservation Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Reservation Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">
            Back to Dashboard
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 space-y-4 md:space-y-0">
        <h2 class="text-xl font-semibold text-purple-800">Reservation List</h2>
        <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-4 w-full md:w-auto">
            <div class="relative flex-grow">
                <input type="text" id="searchInput" placeholder="Search reservations..."
                       class="pl-10 pr-4 py-2 w-full border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                <div class="absolute left-3 top-2.5 text-gray-400">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div>
                <select id="statusFilter" class="border border-gray-300 rounded-md py-2 px-4 w-full focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                    <option value="">All Statuses</option>
                    <option value="CONFIRMED">Confirmed</option>
                    <option value="PENDING">Pending</option>
                    <option value="CANCELLED">Cancelled</option>
                    <option value="COMPLETED">Completed</option>
                </select>
            </div>
        </div>
    </div>

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
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Guest</th>
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
        <p class="text-gray-500 text-lg">No reservations found</p>
    </div>

    <!-- Status Update Modal -->
    <div id="statusUpdateModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3 text-center">
                <h3 class="text-lg leading-6 font-medium text-gray-900">Update Reservation Status</h3>
                <div class="mt-2 px-7 py-3">
                    <p class="text-sm text-gray-500 mb-4">
                        Select the new status for this reservation:
                    </p>
                    <select id="newStatusSelect" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm rounded-md">
                        <option value="CONFIRMED">Confirmed</option>
                        <option value="CHECKED_IN">Checked In</option>
                        <option value="CHECKED_OUT">Checked Out</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                <div class="items-center px-4 py-3">
                    <button id="updateStatusBtn" class="px-4 py-2 bg-purple-600 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                        Update Status
                    </button>
                    <button id="cancelStatusUpdateBtn" class="mt-3 px-4 py-2 bg-white text-gray-700 text-base font-medium rounded-md w-full border border-gray-300 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3 text-center">
                <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100">
                    <i class="fas fa-exclamation-triangle text-red-600"></i>
                </div>
                <h3 class="text-lg leading-6 font-medium text-gray-900 mt-2">Delete Reservation</h3>
                <div class="mt-2 px-7 py-3">
                    <p class="text-sm text-gray-500">
                        Are you sure you want to delete this reservation? This action cannot be undone.
                    </p>
                </div>
                <div class="items-center px-4 py-3">
                    <button id="confirmDeleteBtn" class="px-4 py-2 bg-red-600 text-white text-base font-medium rounded-md w-full shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2">
                        Delete
                    </button>
                    <button id="cancelDeleteBtn" class="mt-3 px-4 py-2 bg-white text-gray-700 text-base font-medium rounded-md w-full border border-gray-300 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // Global variables
    let reservations = [];
    let roomsCache = {};
    let usersCache = {};
    let currentReservationId = null;

    // DOM Elements
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const reservationsContainer = document.getElementById('reservationsContainer');
    const reservationsTableBody = document.getElementById('reservationsTableBody');
    const noReservationsMessage = document.getElementById('noReservationsMessage');
    const searchInput = document.getElementById('searchInput');

    // Modal elements
    const statusUpdateModal = document.getElementById('statusUpdateModal');
    const newStatusSelect = document.getElementById('newStatusSelect');
    const updateStatusBtn = document.getElementById('updateStatusBtn');
    const cancelStatusUpdateBtn = document.getElementById('cancelStatusUpdateBtn');
    const deleteConfirmModal = document.getElementById('deleteConfirmModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');

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
    async function fetchUserDetails(userId) {
        // Check if user is already in cache
        if (usersCache[userId]) {
            return usersCache[userId];
        }

        try {
            const response = await fetch(`${pageContext.request.contextPath}/users/`+userId);

            if (!response.ok) {
                throw new Error(`Failed to fetch user details`);
            }

            const userData = await response.json();

            usersCache[userId] = userData;
            return userData;
        } catch (error) {
            console.error('Error fetching user details:', error);
            return null;
        }
    }
    // Fetch all reservations
    async function fetchReservations() {
        showLoading();

        try {
            const response = await fetch(`${pageContext.request.contextPath}/reservations`);

            if (!response.ok) {
                throw new Error(`Failed to fetch reservations: `+response.status);
            }

            reservations = await response.json();

            if (reservations.length === 0) {
                loadingIndicator.classList.add('hidden');
                noReservationsMessage.classList.remove('hidden');
                return;
            }

            await renderReservations(reservations);

            loadingIndicator.classList.add('hidden');
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
            const userDetails= await fetchUserDetails(reservation.userId);

            const roomInfo = roomDetails
                ? roomDetails.roomNumber + " - " + roomDetails.roomType
                : "Room ID: " + reservation.roomId;

            const row = document.createElement('tr');
            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900\">" + reservation.id + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + userDetails?.fullName + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + roomInfo + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + formatDate(reservation.checkInDate) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + formatDate(reservation.checkOutDate) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + getStatusBadge(reservation.status) + "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium\">" +
                "<button class=\"text-purple-600 hover:text-purple-900 mr-3 update-status-btn\" data-id=\"" + reservation.id + "\">" +
                "<i class=\"fas fa-edit\"></i> Status" +
                "</button>" +
                "<button class=\"text-red-600 hover:text-red-900 delete-btn\" data-id=\"" + reservation.id + "\">" +
                "<i class=\"fas fa-trash-alt\"></i> Delete" +
                "</button>" +
                "</td>";

            reservationsTableBody.appendChild(row);
        }

        // Add event listeners to the newly created buttons
        addButtonEventListeners();
    }

    // Add event listeners to action buttons
    function addButtonEventListeners() {
        // Status update buttons
        document.querySelectorAll('.update-status-btn').forEach(button => {
            button.addEventListener('click', function() {
                currentReservationId = this.getAttribute('data-id');

                // Find current reservation status and set it as selected in the dropdown
                const reservation = reservations.find(r => r.id === currentReservationId);
                if (reservation) {
                    newStatusSelect.value = reservation.status;
                }

                statusUpdateModal.classList.remove('hidden');
            });
        });

        // Delete buttons
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                currentReservationId = this.getAttribute('data-id');
                deleteConfirmModal.classList.remove('hidden');
            });
        });
    }

    // Update reservation status
    async function updateReservationStatus(reservationId, newStatus) {
        try {

            const reservationResponse = await fetch("${pageContext.request.contextPath}/reservations/"+reservationId);

            if(reservationResponse){
                if (!reservationResponse.ok) {
                    throw new Error(`Failed to fetch user details`);
                }

                const reservation = await reservationResponse.json();
                const response = await fetch(`${pageContext.request.contextPath}/reservations/`+reservationId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ ...reservation, status: newStatus })
                });

                if (!response.ok) {
                    throw new Error(`Failed to update status`);
                }

                // Refresh reservations list
                await fetchReservations();
            }


            // Close modal
            statusUpdateModal.classList.add('hidden');
        } catch (error) {
            console.error('Error updating reservation status:', error);
            showError(error.message);
        }
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

            // Close modal
            deleteConfirmModal.classList.add('hidden');
        } catch (error) {
            console.error('Error deleting reservation:', error);
            showError(error.message);
        }
    }

    // Filter reservations based on search input
    function filterReservations() {
        const searchTerm = searchInput.value.toLowerCase();

        if (!searchTerm) {
            renderReservations(reservations);
            return;
        }

        const filtered = reservations.filter(reservation =>
            reservation.id.toLowerCase().includes(searchTerm) ||
            reservation.guestName.toLowerCase().includes(searchTerm) ||
            reservation.roomId.toLowerCase().includes(searchTerm) ||
            reservation.status.toLowerCase().includes(searchTerm)
        );

        if (filtered.length === 0) {
            reservationsContainer.classList.add('hidden');
            noReservationsMessage.classList.remove('hidden');
        } else {
            reservationsContainer.classList.remove('hidden');
            noReservationsMessage.classList.add('hidden');
            renderReservations(filtered);
        }
    }

    // Event Listeners
    document.addEventListener('DOMContentLoaded', () => {
        // Fetch reservations on page load
        fetchReservations();

        // Search functionality
        searchInput.addEventListener('input', filterReservations);

        // Status update modal
        updateStatusBtn.addEventListener('click', () => {
            if (currentReservationId) {
                updateReservationStatus(currentReservationId, newStatusSelect.value);
            }
        });

        cancelStatusUpdateBtn.addEventListener('click', () => {
            statusUpdateModal.classList.add('hidden');
        });

        // Delete confirmation modal
        confirmDeleteBtn.addEventListener('click', () => {
            if (currentReservationId) {
                deleteReservation(currentReservationId);
            }
        });

        cancelDeleteBtn.addEventListener('click', () => {
            deleteConfirmModal.classList.add('hidden');
        });
    });
</script>
</body>
</html>