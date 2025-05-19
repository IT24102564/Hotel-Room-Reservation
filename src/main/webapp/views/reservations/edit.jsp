<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Reservation - Luxe Hotel</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Flatpickr for date picking -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
    <div class="max-w-3xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Edit Your Reservation</h1>

        <!-- Loading Indicator -->
        <div id="loadingIndicator" class="flex justify-center items-center py-12">
            <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
        </div>

        <!-- Error Message -->
        <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6" role="alert">
            <strong class="font-bold">Error!</strong>
            <span id="errorText" class="block sm:inline">Failed to load reservation details.</span>
        </div>

        <!-- Success Message -->
        <div id="successMessage" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-6" role="alert">
            <strong class="font-bold">Success!</strong>
            <span class="block sm:inline">Your reservation has been updated successfully.</span>
        </div>

        <!-- Reservation Form -->
        <form id="reservationForm" class="hidden bg-white shadow-md rounded-lg p-6">
            <input type="hidden" id="reservationId" name="reservationId">
            <input type="hidden" id="userId" name="userId">
            <input type="hidden" id="roomId" name="roomId">

            <!-- Room Details Section -->
            <div id="roomDetails" class="mb-6 p-4 bg-gray-50 rounded-md">
                <h3 class="text-lg font-semibold text-gray-800 mb-2">Room Details</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="text-sm text-gray-600">Room Number</p>
                        <p id="roomNumber" class="font-medium text-gray-900">Loading...</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Room Type</p>
                        <p id="roomType" class="font-medium text-gray-900">Loading...</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Price per Night</p>
                        <p id="roomPrice" class="font-medium text-gray-900">Loading...</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Max Occupancy</p>
                        <p id="roomCapacity" class="font-medium text-gray-900">Loading...</p>
                    </div>
                </div>
            </div>

            <!-- Dates Section -->
            <div class="mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Reservation Dates</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="checkInDate" class="block text-sm font-medium text-gray-700 mb-1">Check-in Date</label>
                        <input type="text" id="checkInDate" name="checkInDate" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" placeholder="Select check-in date" required>
                    </div>
                    <div>
                        <label for="checkOutDate" class="block text-sm font-medium text-gray-700 mb-1">Check-out Date</label>
                        <input type="text" id="checkOutDate" name="checkOutDate" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" placeholder="Select check-out date" required>
                    </div>
                </div>
            </div>

            <!-- Guest Details Section -->
            <div class="mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Guest Details</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="numberOfGuests" class="block text-sm font-medium text-gray-700 mb-1">Number of Guests</label>
                        <input type="number" id="numberOfGuests" name="numberOfGuests" min="1" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" required>
                    </div>
                </div>
            </div>

            <!-- Special Requests -->
            <div class="mb-6">
                <label for="specialRequests" class="block text-sm font-medium text-gray-700 mb-1">Special Requests (Optional)</label>
                <textarea id="specialRequests" name="specialRequests" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" placeholder="Any special requests or preferences?"></textarea>
            </div>

            <!-- Price Summary -->
            <div class="mb-6 p-4 bg-gray-50 rounded-md">
                <h3 class="text-lg font-semibold text-gray-800 mb-2">Price Summary</h3>
                <div class="flex justify-between mb-2">
                    <span class="text-gray-600">Room Rate:</span>
                    <span id="roomRateDisplay" class="font-medium">$0.00</span>
                </div>
                <div class="flex justify-between mb-2">
                    <span class="text-gray-600">Number of Nights:</span>
                    <span id="numberOfNightsDisplay" class="font-medium">0</span>
                </div>
                <div class="flex justify-between mb-2">
                    <span class="text-gray-600">Subtotal:</span>
                    <span id="subtotalDisplay" class="font-medium">$0.00</span>
                </div>
                <div class="flex justify-between mb-2">
                    <span class="text-gray-600">Tax (10%):</span>
                    <span id="taxDisplay" class="font-medium">$0.00</span>
                </div>
                <div class="flex justify-between font-bold text-lg">
                    <span>Total:</span>
                    <span id="totalDisplay">$0.00</span>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end">
                <button type="submit" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-6 rounded-md transition duration-300 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                    Update Reservation
                </button>
            </div>
        </form>
    </div>
</main>

<script>
    // Global variables
    let roomData = null;
    let reservationData = null;
    const reservationId = new URLSearchParams(window.location.search).get('id');
    const userId = new URLSearchParams(window.location.search).get('userId');

    // DOM Elements
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const successMessage = document.getElementById('successMessage');
    const reservationForm = document.getElementById('reservationForm');

    // Room details elements
    const roomNumberElement = document.getElementById('roomNumber');
    const roomTypeElement = document.getElementById('roomType');
    const roomPriceElement = document.getElementById('roomPrice');
    const roomCapacityElement = document.getElementById('roomCapacity');

    // Form elements
    const reservationIdInput = document.getElementById('reservationId');
    const userIdInput = document.getElementById('userId');
    const roomIdInput = document.getElementById('roomId');
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const numberOfGuestsInput = document.getElementById('numberOfGuests');
    const specialRequestsInput = document.getElementById('specialRequests');

    // Price summary elements
    const roomRateDisplay = document.getElementById('roomRateDisplay');
    const numberOfNightsDisplay = document.getElementById('numberOfNightsDisplay');
    const subtotalDisplay = document.getElementById('subtotalDisplay');
    const taxDisplay = document.getElementById('taxDisplay');
    const totalDisplay = document.getElementById('totalDisplay');

    // Helper function to show loading state
    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        reservationForm.classList.add('hidden');
        errorMessage.classList.add('hidden');
        successMessage.classList.add('hidden');
    }

    // Helper function to show error
    function showError(message) {
        loadingIndicator.classList.add('hidden');
        reservationForm.classList.add('hidden');
        errorMessage.classList.remove('hidden');
        errorText.textContent = message;
    }

    // Helper function to format currency
    function formatCurrency(amount) {
        return '$' + parseFloat(amount).toFixed(2);
    }

    // Helper function to calculate number of nights between two dates
    function calculateNights(checkIn, checkOut) {
        const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
        const checkInDate = new Date(checkIn);
        const checkOutDate = new Date(checkOut);

        // Round down to handle daylight saving time issues
        return Math.round(Math.abs((checkOutDate - checkInDate) / oneDay));
    }

    // Update price summary based on selected dates
    function updatePriceSummary() {
        if (!roomData || !checkInDateInput.value || !checkOutDateInput.value) {
            return;
        }

        const nights = calculateNights(checkInDateInput.value, checkOutDateInput.value);
        const roomRate = parseFloat(roomData.pricePerNight);
        const subtotal = roomRate * nights;
        const tax = subtotal * 0.1; // 10% tax
        const total = subtotal + tax;

        roomRateDisplay.textContent = formatCurrency(roomRate);
        numberOfNightsDisplay.textContent = nights.toString();
        subtotalDisplay.textContent = formatCurrency(subtotal);
        taxDisplay.textContent = formatCurrency(tax);
        totalDisplay.textContent = formatCurrency(total);
    }

    // Fetch reservation details
    async function fetchReservationDetails() {
        showLoading();

        try {
            const response = await fetch(`${pageContext.request.contextPath}/reservations/`+reservationId);

            if (!response.ok) {
                throw new Error(`Failed to fetch reservation details`);
            }

            reservationData = await response.json();

            // Fetch room details
            await fetchRoomDetails(reservationData.roomId);

            // Populate form with reservation data
            populateForm();

            // Initialize date pickers
            initDatePickers();

            // Show the form
            loadingIndicator.classList.add('hidden');
            reservationForm.classList.remove('hidden');
        } catch (error) {
            console.error('Error fetching reservation details:', error);
            showError(error.message);
        }
    }

    // Fetch room details
    async function fetchRoomDetails(roomId) {
        try {
            const response = await fetch(`${pageContext.request.contextPath}/rooms/`+roomId);

            if (!response.ok) {
                throw new Error(`Failed to fetch room details`);
            }

            roomData = await response.json();

            // Update room details display
            roomNumberElement.textContent = roomData.roomNumber;
            roomTypeElement.textContent = roomData.roomType;
            roomPriceElement.textContent = formatCurrency(roomData.pricePerNight) + ' per night';
            roomCapacityElement.textContent = roomData.capacity + ' guests';

        } catch (error) {
            console.error('Error fetching room details:', error);
            throw error;
        }
    }

    // Populate form with reservation data
    function populateForm() {
        reservationIdInput.value = reservationData.id;
        userIdInput.value = userId;
        roomIdInput.value = reservationData.roomId;

        checkInDateInput.value = reservationData.checkInDate;
        checkOutDateInput.value = reservationData.checkOutDate;


        numberOfGuestsInput.value = reservationData.numberOfGuests;
        specialRequestsInput.value = reservationData.specialRequests || '';

        // Update price summary
        updatePriceSummary();
    }

    // Initialize date pickers
    function initDatePickers() {
        // Configure check-in date picker
        const checkInPicker = flatpickr(checkInDateInput, {
            minDate: "today",
            dateFormat: "Y-m-d",
            onChange: function(selectedDates, dateStr) {
                // Update check-out date picker min date
                checkOutPicker.set('minDate', dateStr);

                // If check-out date is before check-in date, reset it
                if (checkOutDateInput.value && new Date(checkOutDateInput.value) <= new Date(dateStr)) {
                    checkOutDateInput.value = '';
                }

                updatePriceSummary();
            }
        });

        // Configure check-out date picker
        const checkOutPicker = flatpickr(checkOutDateInput, {
            minDate: checkInDateInput.value || "today",
            dateFormat: "Y-m-d",
            onChange: function() {
                updatePriceSummary();
            }
        });
    }

    // Update reservation
    async function updateReservation(formData) {
        try {
            const response = await fetch(`${pageContext.request.contextPath}/reservations/`+reservationId, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });

            if (!response.ok) {
                throw new Error(`Failed to update reservation`);
            }

            // Show success message
            reservationForm.classList.add('hidden');
            successMessage.classList.remove('hidden');

            // Redirect to my-reservations page after 2 seconds
            setTimeout(() => {
                window.location.href = `${pageContext.request.contextPath}/my-reservations?userId=`+userId;
            }, 2000);

        } catch (error) {
            console.error('Error updating reservation:', error);
            showError(error.message);
        }
    }

    // Event Listeners
    document.addEventListener('DOMContentLoaded', () => {
        // Check if reservationId and userId are available
        if (!reservationId || !userId) {
            showError('Reservation ID and User ID are required to edit a reservation');
            return;
        }

        // Fetch reservation details on page load
        fetchReservationDetails();

        // Form submission
        reservationForm.addEventListener('submit', function(event) {
            event.preventDefault();

            // Calculate total price
            const nights = calculateNights(checkInDateInput.value, checkOutDateInput.value);
            const roomRate = parseFloat(roomData.pricePerNight);
            const subtotal = roomRate * nights;
            const tax = subtotal * 0.1; // 10% tax
            const total = subtotal + tax;

            // Create reservation data object
            const formData = {
                id: reservationIdInput.value,
                userId: userIdInput.value,
                roomId: roomIdInput.value,
                checkInDate: checkInDateInput.value,
                checkOutDate: checkOutDateInput.value,
                numberOfGuests: parseInt(numberOfGuestsInput.value),
                specialRequests: specialRequestsInput.value,
                totalPrice: total,
                status: 'PENDING' // Keep status as PENDING for edits
            };

            // Update reservation
            updateReservation(formData);
        });

        // Update price summary when number of guests changes
        numberOfGuestsInput.addEventListener('change', function() {
            // Validate against room capacity
            if (roomData && parseInt(this.value) > roomData.capacity) {
                alert(`Maximum occupancy for this room is`+ roomData.capacity +`guests.`);
                this.value = 10;
            }
        });
    });
</script>
</body>
</html>
