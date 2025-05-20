<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Details - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script>
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Luxe Hotel</h1>
        <a href="${pageContext.request.contextPath}/" class="text-sm text-purple-600 hover:text-purple-900">
            Home
        </a>
    </div>
</header>

<main class="max-w-6xl mx-auto py-10 px-4 sm:px-6 lg:px-8">
    <!-- Loading Spinner -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load room details.</span>
    </div>

    <!-- Room Details -->
    <div id="roomDetailsContainer" class="hidden">
        <div class="bg-white shadow overflow-hidden sm:rounded-lg">
            <div class="relative">
                <img id="roomImage" src="" alt="Room Image" class="w-full h-80 object-cover object-center">
                <div id="roomTypeBadge" class="absolute top-4 right-4 bg-purple-600 text-white px-3 py-1 rounded-full text-sm font-semibold">
                    SUITE
                </div>
            </div>
            <div class="px-4 py-5 sm:px-6">
                <h2 id="roomTitle" class="text-2xl font-bold text-gray-900">Room 205</h2>
            </div>
            <div class="border-t border-gray-200">
                <dl>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">Room Number</dt>
                        <dd id="roomNumber" class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">205</dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">Price Per Night</dt>
                        <dd id="pricePerNight" class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">$200.00</dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">Capacity</dt>
                        <dd id="capacity" class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">2 persons</dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">Availability</dt>
                        <dd id="availability" class="mt-1 text-sm sm:mt-0 sm:col-span-2">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                Available
                            </span>
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">Amenities</dt>
                        <dd id="amenities" class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">Wi-Fi, AC, Mini Bar, Coffee Maker</dd>
                    </div>
                </dl>
            </div>
        </div>

        <div class="mt-6 text-center">
            <a href="${pageContext.request.contextPath}/rooms-list"
               class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700">
                Back to Rooms
            </a>
            <a id="reserveLink" href="#"
               class="ml-4 inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700">
                Make a Reservation
            </a>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const roomId = new URLSearchParams(window.location.search).get("id");

        const loadingIndicator = document.getElementById('loadingIndicator');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const roomDetailsContainer = document.getElementById('roomDetailsContainer');

        const roomImage = document.getElementById('roomImage');
        const roomTypeBadge = document.getElementById('roomTypeBadge');
        const roomTitle = document.getElementById('roomTitle');
        const roomNumber = document.getElementById('roomNumber');
        const pricePerNight = document.getElementById('pricePerNight');
        const capacity = document.getElementById('capacity');
        const availability = document.getElementById('availability');
        const amenities = document.getElementById('amenities');
        const reserveLink = document.getElementById('reserveLink');

        
        function formatPrice(price) {
            return '$' + parseFloat(price).toFixed(2);
        }


        function showLoading() {
            loadingIndicator.classList.remove('hidden');
            roomDetailsContainer.classList.add('hidden');
            errorMessage.classList.add('hidden');
        }


        function showError(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
            loadingIndicator.classList.add('hidden');
        }


        function getRoomTypeBadgeColor(roomType) {
            const colors = {
                'STANDARD': 'bg-blue-600',
                'DELUXE': 'bg-purple-600',
                'SUITE': 'bg-green-600',
                'EXECUTIVE': 'bg-indigo-600',
                'PRESIDENTIAL': 'bg-pink-600'
            };
            roomTypeBadge.className = 'absolute top-4 right-4 text-white px-3 py-1 rounded-full text-sm font-semibold ' + (colors[roomType] || 'bg-gray-600');
        }


        async function loadRoomDetails() {
            if (!roomId) {
                showError("Room ID is missing from the URL.");
                return;
            }

            showLoading();

            try {
                const response = await fetch('${pageContext.request.contextPath}/rooms/' + roomId);

                if (!response.ok) {
                    throw new Error('Failed to load room details. Status: ' + response.status);
                }

                const room = await response.json();


                if (room.imageUrl) {
                    roomImage.src = room.imageUrl;
                } else {
                    roomImage.src = "https://via.placeholder.com/800x400?text=No+Image";
                }

                roomTypeBadge.textContent = room.roomType;
                getRoomTypeBadgeColor(room.roomType);

                roomTitle.textContent = 'Room ' + room.roomNumber;
                roomNumber.textContent = room.roomNumber;
                pricePerNight.textContent = formatPrice(room.pricePerNight);
                capacity.textContent = room.capacity + ' person(s)';
                amenities.textContent = room.amenities || 'N/A';


                if (room.available) {
                    availability.innerHTML = '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Available</span>';
                } else {
                    availability.innerHTML = '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">Booked</span>';
                }

                const userId = localStorage.getItem("userId")


                reserveLink.href = "${pageContext.request.contextPath}/create-reserve?roomId=" + roomId + "&userId="+userId;

                roomDetailsContainer.classList.remove('hidden');

            } catch (error) {
                console.error('Error fetching room details:', error);
                showError(error.message || 'Failed to load room details.');
            } finally {
                hideLoading();
            }
        }


        function hideLoading() {
            loadingIndicator.classList.add('hidden');
        }


        loadRoomDetails();
    });
</script>

</body>
</html>