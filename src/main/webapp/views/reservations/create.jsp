<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Reservation - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Flatpickr for date selection -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        .booked-date {
            background-color: #f87171;
            color: white;
            border: none;
        }
        .selected-range {
            background-color: #818cf8;
            color: white;
        }
    </style>
</head>
<body class="bg-gray-50 text-gray-900 min-h-screen">

<!-- Header -->
<header class="bg-white shadow-sm">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <i class="fas fa-calendar-check text-purple-600"></i>
            <h1 class="text-2xl font-bold text-purple-700">Create New Reservation</h1>
        </div>
        <a href="${pageContext.request.contextPath}"
           class="flex items-center space-x-1 text-purple-600 hover:text-purple-900 transition-colors">
            <i class="fas fa-arrow-left text-sm"></i>
            <span>Back to Home</span>
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="bg-white shadow rounded-lg overflow-hidden p-6">
        <!-- Form -->
        <form id="createReservationForm" class="space-y-6">
            <input type="hidden" id="userId" name="userId" value="${param.userId}">

            <!-- Room Selection Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Room Selection</h2>

                <div>
                    <label for="roomId" class="block text-sm font-medium text-gray-700">Room *</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-door-open text-gray-400"></i>
                        </div>
                        <select id="roomId" name="roomId" required
                                class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                            <option value="">Select a Room</option>
                            <c:forEach items="${availableRooms}" var="room">
                                <option value="${room.id}" data-price="${room.pricePerNight}">${room.roomNumber} - ${room.roomType} ($${room.pricePerNight}/night)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <p class="error-message text-red-500 text-xs mt-1 hidden" id="roomId-error"></p>
                </div>
            </div>

            <!-- Date Selection Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Date Selection</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Check-in Date -->
                    <div>
                        <label for="checkInDate" class="block text-sm font-medium text-gray-700">Check-in Date *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar-day text-gray-400"></i>
                            </div>
                            <input type="text" id="checkInDate" name="checkInDate" readonly
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="Select check-in date">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="checkInDate-error"></p>
                    </div>

                    <!-- Check-out Date -->
                    <div>
                        <label for="checkOutDate" class="block text-sm font-medium text-gray-700">Check-out Date *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar-week text-gray-400"></i>
                            </div>
                            <input type="text" id="checkOutDate" name="checkOutDate" readonly
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="Select check-out date">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="checkOutDate-error"></p>
                    </div>
                </div>

                <!-- Calendar View -->
                <div class="mt-6">
                    <div id="reservationCalendar" class="p-4 border rounded-lg"></div>
                    <p class="text-gray-500 text-xs mt-2">
                        <span class="inline-block w-3 h-3 bg-red-500 rounded-full mr-1"></span> Booked dates
                        <span class="inline-block w-3 h-3 bg-blue-500 rounded-full ml-3 mr-1"></span> Selected dates
                    </p>
                </div>
            </div>

            <!-- Guest Information Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Guest Information</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Number of Guests -->
                    <div>
                        <label for="numberOfGuests" class="block text-sm font-medium text-gray-700">Number of Guests *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-users text-gray-400"></i>
                            </div>
                            <input type="number" id="numberOfGuests" name="numberOfGuests" min="1" max="10"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="e.g. 2">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="numberOfGuests-error"></p>
                    </div>

                    <!-- Total Price -->
                    <div>
                        <label for="totalPrice" class="block text-sm font-medium text-gray-700">Total Price</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <span class="text-gray-500 sm:text-sm">$</span>
                            </div>
                            <input type="text" id="totalPrice" name="totalPrice" readonly
                                   class="pl-7 bg-gray-100 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="Calculated automatically">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Special Requests Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Special Requests</h2>

                <div>
                    <label for="specialRequests" class="block text-sm font-medium text-gray-700">Requests</label>
                    <div class="mt-1">
                        <textarea id="specialRequests" name="specialRequests" rows="3"
                                  class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                  placeholder="Any special requests or notes for your stay"></textarea>
                    </div>
                    <p class="text-gray-500 text-xs mt-1">We'll do our best to accommodate your requests</p>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="pt-5 border-t border-gray-200">
                <div class="flex justify-end">
                    <a href="${pageContext.request.contextPath}/reservations?userId=${param.userId}"
                       class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 mr-3 transition-colors">
                        Cancel
                    </a>
                    <button type="submit" id="submitButton"
                            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-colors">
                        <i class="fas fa-save mr-2"></i>
                        Create Reservation
                    </button>
                </div>
            </div>
        </form>

        <!-- Loading Indicator (Hidden by default) -->
        <div id="loadingIndicator" class="hidden mt-4 flex justify-center">
            <div class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-purple-500"></div>
        </div>

        <!-- Success Message (Hidden by default) -->
        <div id="successMessage" class="hidden mt-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Success!</p>
                    <p class="text-sm">Reservation has been created successfully.</p>
                </div>
            </div>
        </div>

        <!-- Error Message (Hidden by default) -->
        <div id="errorMessage" class="hidden mt-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-exclamation-circle text-red-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Error!</p>
                    <p class="text-sm" id="errorText">There was an error creating the reservation.</p>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Flatpickr for date selection -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('createReservationForm');
        const submitButton = document.getElementById('submitButton');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const roomSelect = document.getElementById('roomId');
        const checkInInput = document.getElementById('checkInDate');
        const checkOutInput = document.getElementById('checkOutDate');
        const totalPriceInput = document.getElementById('totalPrice');
        const calendarElement = document.getElementById('reservationCalendar');

        let bookedDates = [];
        let flatpickrInstance;


        function initDatePicker() {
            flatpickrInstance = flatpickr("#reservationCalendar", {
                inline: true,
                mode: "range",
                minDate: "today",
                disable: bookedDates,
                onReady: function(selectedDates, dateStr, instance) {

                    instance.daysContainer.querySelectorAll('.flatpickr-day').forEach(day => {
                        const date = new Date(day.dateObj);
                        const dateStr = formatDate(date);

                        if (bookedDates.includes(dateStr)) {
                            day.classList.add('booked-date');
                        }
                    });
                },
                onChange: function(selectedDates, dateStr, instance) {
                    if (selectedDates.length === 2) {
                        checkInInput.value = formatDate(selectedDates[0]);
                        checkOutInput.value = formatDate(selectedDates[1]);
                        calculateTotalPrice();
                    }
                }
            });
        }


        function formatDate(date) {
            return date.toISOString().split('T')[0];
        }


        function calculateTotalPrice() {
            const roomOption = roomSelect.options[roomSelect.selectedIndex];
            if (roomOption && roomOption.value && checkInInput.value && checkOutInput.value) {
                const pricePerNight = parseFloat(roomOption.getAttribute('data-price'));
                const checkIn = new Date(checkInInput.value);
                const checkOut = new Date(checkOutInput.value);
                const nights = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24));
                const total = pricePerNight * nights;
                totalPriceInput.value = total.toFixed(2);
            } else {
                totalPriceInput.value = '';
            }
        }


        function fetchBookedDates(roomId) {
            if (!roomId) return;

            fetch(`${pageContext.request.contextPath}/reservations?roomId=`+roomId)
                .then(response => response.json())
                .then(reservations => {
                    bookedDates = [];
                    reservations.forEach(reservation => {
                        if (reservation.status !== 'CANCELLED') {
                            const start = new Date(reservation.checkInDate);
                            const end = new Date(reservation.checkOutDate);


                            for (let dt = new Date(start); dt < end; dt.setDate(dt.getDate() + 1)) {
                                bookedDates.push(formatDate(dt));
                            }
                        }
                    });


                    if (flatpickrInstance) {
                        flatpickrInstance.destroy();
                    }
                    initDatePicker();
                })
                .catch(error => {
                    console.error('Error fetching booked dates:', error);
                });
        }


        roomSelect.addEventListener('change', function() {
            fetchBookedDates(this.value);
            calculateTotalPrice();
        });


        checkInInput.addEventListener('change', calculateTotalPrice);
        checkOutInput.addEventListener('change', calculateTotalPrice);


        form.addEventListener('submit', async function(e) {
            e.preventDefault();


            successMessage.classList.add('hidden');
            errorMessage.classList.add('hidden');


            if (!form.checkValidity()) {

                Array.from(form.elements).forEach(el => {
                    if (!el.checkValidity()) {
                        const errorElement = document.getElementById(`${el.id}-error`);
                        if (errorElement) {
                            errorElement.textContent = el.validationMessage;
                            errorElement.classList.remove('hidden');
                            el.classList.add('border-red-500');
                        }
                    }
                });
                return;
            }


            loadingIndicator.classList.remove('hidden');
            submitButton.disabled = true;

            try {

                const reservationData = {
                    userId: document.getElementById('userId').value,
                    roomId: roomSelect.value,
                    checkInDate: checkInInput.value,
                    checkOutDate: checkOutInput.value,
                    numberOfGuests: parseInt(document.getElementById('numberOfGuests').value),
                    totalPrice: parseFloat(totalPriceInput.value),
                    status: "PENDING",
                    specialRequests: document.getElementById('specialRequests').value
                };


                const response = await fetch(`${pageContext.request.contextPath}/reservations`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(reservationData)
                });

                if (!response.ok) {
                    const errorData = await response.json().catch(() => null);
                    throw new Error(errorData?.message || `Server responded with status: `+response.status);
                }


                successMessage.classList.remove('hidden');


                form.reset();
                if (flatpickrInstance) {
                    flatpickrInstance.clear();
                }
                const userId = localStorage.getItem("userId")

                setTimeout(() => {
                    window.location.href = `${pageContext.request.contextPath}/my-reservations?userId=`+userId;
                }, 2000);

            } catch (error) {
                console.error('Error creating reservation:', error);
                errorText.textContent = error.message || 'There was an error creating the reservation.';
                errorMessage.classList.remove('hidden');
            } finally {

                loadingIndicator.classList.add('hidden');
                submitButton.disabled = false;
            }
        });


        initDatePicker();
    });
</script>

</body>
</html>