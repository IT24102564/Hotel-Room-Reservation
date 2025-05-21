<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rooms - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script>
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">

        <a href="${pageContext.request.contextPath}/">
            <h1 class="text-2xl font-bold text-purple-700">Luxe Hotel</h1>
        </a>
    </div>
</header>

<main class="max-w-7xl mx-auto py-10 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-8">
        <h2 class="text-3xl font-extrabold text-purple-900">All Rooms</h2>
    </div>

    <!-- Loading Spinner -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load rooms.</span>
    </div>

    <!-- Room List Grid -->
    <div id="roomListContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 hidden">
        <!-- Room Cards will be inserted here -->
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const loadingIndicator = document.getElementById('loadingIndicator');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const roomListContainer = document.getElementById('roomListContainer');


        function showLoading() {
            loadingIndicator.classList.remove('hidden');
            roomListContainer.classList.add('hidden');
            errorMessage.classList.add('hidden');
        }


        function hideLoading() {
            loadingIndicator.classList.add('hidden');
        }


        function showError(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
        }


        function formatPrice(price) {
            return '$' + parseFloat(price).toFixed(2);
        }


        function getRoomTypeBadgeColor(roomType) {
            const colors = {
                'STANDARD': 'bg-blue-600',
                'DELUXE': 'bg-purple-600',
                'SUITE': 'bg-green-600',
                'EXECUTIVE': 'bg-indigo-600',
                'PRESIDENTIAL': 'bg-pink-600'
            };
            return colors[roomType] || 'bg-gray-600';
        }


        function getBackgroundColor(roomType, index) {
            const colors = [
                "bg-purple-200",
                "bg-blue-200",
                "bg-pink-200"
            ];
            return colors[index % 3];
        }

        function getRoomAnimation(index) {
            const animations = [
                "https://assets9.lottiefiles.com/packages/lf20_ukfgwhzj.json",
                "https://assets9.lottiefiles.com/packages/lf20_5tkzkblw.json",
                "https://assets5.lottiefiles.com/packages/lf20_le8lharj.json"
            ];
            return animations[index % 3];
        }

        /
        function createRoomCard(room, index) {
            const badgeColor = getRoomTypeBadgeColor(room.roomType);
            const bgColor = getBackgroundColor(room.roomType, index);
            const animationUrl = getRoomAnimation(index);

            const hasValidImage = room.imageUrl && room.imageUrl.trim() !== "" &&
                !room.imageUrl.includes('`') &&
                (room.imageUrl.startsWith('http://') || room.imageUrl.startsWith('https://'));

            const card = document.createElement('div');
            card.className = 'bg-white rounded-xl overflow-hidden shadow-lg feature-card';

            let htmlContent = '';

            htmlContent += '<div class="relative">';
            if (hasValidImage) {
                htmlContent += '<img src="' + room.imageUrl.trim() + '" alt="' + room.roomType + ' Room" class="h-64 w-full object-cover">';
            } else {
                htmlContent += '<div class="h-64 ' + bgColor + ' flex items-center justify-center">';
                htmlContent += '<lottie-player src="' + animationUrl + '" background="transparent" speed="1" style="width: 100%; height: 100%;" loop autoplay></lottie-player>';
                htmlContent += '</div>';
            }
            htmlContent += '<div class="absolute top-4 right-4 ' + badgeColor + ' text-white px-3 py-1 rounded-full text-sm font-semibold">' + room.roomType + '</div>';
            htmlContent += '</div>';

            htmlContent += '<div class="p-6">';
            htmlContent += '<h3 class="text-xl font-bold text-purple-900 mb-2">Room ' + room.roomNumber + '</h3>';
            htmlContent += '<p class="text-gray-600 mb-4">' + (room.amenities || 'Comfortable room with modern amenities.') + '</p>';
            htmlContent += '<div class="flex justify-between items-center">';
            htmlContent += '<p class="text-2xl font-bold text-purple-600">' + formatPrice(room.pricePerNight) + '<span class="text-sm text-gray-500">/night</span></p>';
            htmlContent += '<a href="${pageContext.request.contextPath}/room-details?id=' + room.id + '" class="bg-purple-100 hover:bg-purple-200 text-purple-800 font-semibold py-2 px-4 rounded-md transition duration-300">';
            htmlContent += 'View Details';
            htmlContent += '</a>';
            htmlContent += '</div>';
            htmlContent += '</div>';

            card.innerHTML = htmlContent;
            return card;
        }


        async function loadRooms() {
            showLoading();

            try {
                const response = await fetch('${pageContext.request.contextPath}/rooms/');
                if (!response.ok) {
                    throw new Error('Failed to load rooms. Status: ' + response.status);
                }

                const rooms = await response.json();
                if (!rooms || rooms.length === 0) {
                    throw new Error('No rooms available.');
                }


                roomListContainer.innerHTML = '';


                rooms.forEach((room, index) => {
                    const roomCard = createRoomCard(room, index);
                    roomListContainer.appendChild(roomCard);
                });

                roomListContainer.classList.remove('hidden');
            } catch (error) {
                console.error('Error fetching rooms:', error);
                showError(error.message || 'An unexpected error occurred.');
            } finally {
                hideLoading();
            }
        }

        loadRooms();
    });
</script>

</body>
</html>