<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="py-12 sm:py-16 lg:py-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="text-center mb-12">
        <h2 class="text-3xl font-extrabold text-purple-900 sm:text-4xl">Featured Rooms</h2>
        <p class="mt-4 max-w-3xl mx-auto text-xl text-gray-500">
            Choose from our selection of premium accommodations
        </p>
    </div>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load featured rooms.</span>
    </div>

    <!-- Featured Rooms Container -->
    <div id="featuredRoomsContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 hidden">
        <!-- Room cards will be dynamically inserted here -->
    </div>

    <div class="text-center mt-10">
        <a href="${pageContext.request.contextPath}/rooms-list" class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700">
            View All Rooms
            <i class="fas fa-arrow-right ml-2"></i>
        </a>
    </div>
</section>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loadingIndicator = document.getElementById('loadingIndicator');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const featuredRoomsContainer = document.getElementById('featuredRoomsContainer');


        function showLoading() {
            loadingIndicator.classList.remove('hidden');
            featuredRoomsContainer.classList.add('hidden');
            errorMessage.classList.add('hidden');
        }


        function hideLoading() {
            loadingIndicator.classList.add('hidden');
        }


        function showError(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
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


        function getRoomAnimation(roomType, index) {
            const animations = [
                "https://assets9.lottiefiles.com/packages/lf20_ukfgwhzj.json",
                "https://assets9.lottiefiles.com/packages/lf20_5tkzkblw.json",
                "https://assets5.lottiefiles.com/packages/lf20_le8lharj.json"
            ];

            return animations[index % 3];
        }


        function getBackgroundColor(roomType, index) {
            const colors = [
                "bg-purple-200",
                "bg-blue-200",
                "bg-pink-200"
            ];

            return colors[index % 3];
        }


        function formatPrice(price) {
            return '$' + parseFloat(price).toFixed(2);
        }


        function createRoomCard(room, index) {
            const badgeColor = getRoomTypeBadgeColor(room.roomType);
            const bgColor = getBackgroundColor(room.roomType, index);
            const animation = getRoomAnimation(room.roomType, index);

            const roomCard = document.createElement('div');
            roomCard.className = 'bg-white rounded-xl overflow-hidden shadow-lg feature-card';


            const hasValidImage = room.imageUrl && room.imageUrl.trim() !== "" &&
                !room.imageUrl.includes('`') &&
                (room.imageUrl.startsWith('http://') || room.imageUrl.startsWith('https://'));


            var innerHTMLContent = "";

            innerHTMLContent += '<div class="relative">';

            if (hasValidImage) {
                innerHTMLContent += '<img src="' + room.imageUrl.trim() + '" alt="' + room.roomType + ' Room" class="h-64 w-full object-cover">';
            } else {
                innerHTMLContent += '<div class="h-64 ' + bgColor + ' flex items-center justify-center">';
                innerHTMLContent += '<lottie-player src="' + animation + '" background="transparent" speed="1" style="width: 100%; height: 100%;" loop autoplay></lottie-player>';
                innerHTMLContent += '</div>';
            }

            innerHTMLContent += '<div class="absolute top-4 right-4 ' + badgeColor + ' text-white px-3 py-1 rounded-full text-sm font-semibold">';
            innerHTMLContent += room.roomType;
            innerHTMLContent += '</div>';
            innerHTMLContent += '</div>';
            innerHTMLContent += '<div class="p-6">';
            innerHTMLContent += '<h3 class="text-xl font-bold text-purple-900 mb-2">Room ' + room.roomNumber + '</h3>';
            innerHTMLContent += '<p class="text-gray-600 mb-4">' + (room.amenities || 'Comfortable room with modern amenities.') + '</p>';
            innerHTMLContent += '<div class="flex justify-between items-center">';
            innerHTMLContent += '<p class="text-2xl font-bold text-purple-600">' + formatPrice(room.pricePerNight) + '<span class="text-sm text-gray-500">/night</span></p>';
            innerHTMLContent += '<a href="${pageContext.request.contextPath}/room-details?id=' + room.id + '" class="bg-purple-100 hover:bg-purple-200 text-purple-800 font-semibold py-2 px-4 rounded-md transition duration-300">';
            innerHTMLContent += 'View Details';
            innerHTMLContent += '</a>';
            innerHTMLContent += '</div>';
            innerHTMLContent += '</div>';

            roomCard.innerHTML = innerHTMLContent;

            return roomCard;
        }


        async function loadFeaturedRooms() {
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


                const featuredRooms = rooms.slice(0, 3);


                featuredRoomsContainer.innerHTML = '';


                featuredRooms.forEach((room, index) => {
                    const roomCard = createRoomCard(room, index);
                    featuredRoomsContainer.appendChild(roomCard);
                });


                featuredRoomsContainer.classList.remove('hidden');

            } catch (error) {
                console.error('Error loading featured rooms:', error);
                showError(error.message || 'Failed to load featured rooms');
            } finally {
                hideLoading();
            }
        }


        loadFeaturedRooms();
    });
</script>