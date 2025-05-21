<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LuxeStay - Premium Hotel Booking</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lottie Player -->
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module">
    </script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .hero-gradient {
            background: linear-gradient(135deg, rgba(91, 33, 182, 0.8) 0%, rgba(124, 58, 237, 0.7) 50%, rgba(139, 92, 246, 0.6) 100%);
        }
        .card-gradient {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.2) 100%);
            backdrop-filter: blur(10px);
        }
        .feature-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(91, 33, 182, 0.1), 0 10px 10px -5px rgba(91, 33, 182, 0.04);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-50 min-h-screen">
<!-- Navigation -->
<nav class="fixed w-full z-50 backdrop-blur-md bg-white/70 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <a href="#" class="flex-shrink-0 flex items-center">
                    <i class="fas fa-hotel text-purple-600 text-2xl mr-2"></i>
                    <span class="text-xl font-bold text-purple-900">LuxeStay</span>
                </a>
                <div class="hidden md:ml-6 md:flex md:space-x-8">
                    <a href="/" class="border-purple-500 text-purple-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Home
                    </a>
                    <a href="${pageContext.request.contextPath}/rooms-list" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Rooms
                    </a>
                    <a id="myReservationsLink" href="${pageContext.request.contextPath}/my-reservations" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        My Reservations
                    </a>
                    <a href="#" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Contact
                    </a>
                </div>
            </div>
            <div class="flex items-center" id="authButtons">
                <!-- Will be populated by JavaScript -->
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="relative bg-indigo-800 overflow-hidden">
    <div class="max-w-7xl mx-auto">
        <div class="relative z-10 pb-8 sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32">
            <div class="hero-gradient absolute inset-0 z-0"></div>
            <main class="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
                <div class="sm:text-center lg:text-left relative z-10 pt-16">
                    <h1 class="text-4xl tracking-tight font-extrabold text-white sm:text-5xl md:text-6xl">
                        <span class="block xl:inline">Experience Luxury</span>
                        <span class="block text-purple-300 xl:inline">Like Never Before</span>
                    </h1>
                    <p class="mt-3 text-base text-purple-100 sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
                        Indulge in our premium accommodations with breathtaking views, world-class amenities, and exceptional service tailored to exceed your expectations.
                    </p>
                    <div class="mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start">
                        <div class="rounded-md shadow">
                            <a href="${pageContext.request.contextPath}/rooms-list" class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-purple-800 bg-white hover:bg-purple-50 md:py-4 md:text-lg md:px-10">
                                Book Now
                            </a>
                        </div>
                        <div class="mt-3 sm:mt-0 sm:ml-3">
                            <a href="${pageContext.request.contextPath}/rooms-list" class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 md:py-4 md:text-lg md:px-10">
                                View Rooms
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <div class="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
        <div class="h-56 sm:h-72 md:h-96 lg:w-full lg:h-full">
            <dotlottie-player
                    src="https://lottie.host/1c3e7cf5-6b54-4c18-bdec-f8909da02f41/kloh3F0EgD.lottie"
                    background="transparent"
                    speed="1"
                    style="width: 100%; height: 100%;"
                    loop
                    autoplay
            ></dotlottie-player>
        </div>
    </div>
</div>

<!-- Featured Rooms -->
<jsp:include page="/views/rooms/featured-rooms.jsp"/>

<!-- Features -->
<section class="py-12 bg-gradient-to-b from-white to-purple-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-extrabold text-purple-900 sm:text-4xl">Why Choose LuxeStay</h2>
            <p class="mt-4 max-w-3xl mx-auto text-xl text-gray-500">
                Experience the perfect blend of comfort, luxury, and exceptional service
            </p>
        </div>
        <div class="mt-10">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <div class="bg-white p-6 rounded-xl shadow-md feature-card">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-concierge-bell text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-purple-900 mb-2">24/7 Service</h3>
                    <p class="text-gray-600">Our dedicated staff is available round the clock to cater to your needs.</p>
                </div>

                <div class="bg-white p-6 rounded-xl shadow-md feature-card">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-wifi text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-purple-900 mb-2">Free High-Speed WiFi</h3>
                    <p class="text-gray-600">Stay connected with complimentary high-speed internet throughout the property.</p>
                </div>

                <div class="bg-white p-6 rounded-xl shadow-md feature-card">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-utensils text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-purple-900 mb-2">Gourmet Dining</h3>
                    <p class="text-gray-600">Savor exquisite culinary creations from our award-winning chefs.</p>
                </div>

                <div class="bg-white p-6 rounded-xl shadow-md feature-card">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-spa text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-purple-900 mb-2">Luxury Spa</h3>
                    <p class="text-gray-600">Rejuvenate your body and mind with our range of spa treatments.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials -->
<jsp:include page="/views/feedbacks/feedbacks.jsp"/>

<!-- Call to Action -->
<section class="py-12 sm:py-16 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-gradient-to-r from-purple-600 to-indigo-600 rounded-2xl shadow-xl overflow-hidden">
            <div class="px-6 py-12 sm:px-12 sm:py-16 lg:flex lg:items-center lg:justify-between">
                <div>
                    <h2 class="text-3xl font-extrabold tracking-tight text-white sm:text-4xl">
                        <span class="block">Ready for an unforgettable stay?</span>
                        <span class="block text-indigo-200">Book your room today and save 15%.</span>
                    </h2>
                    <p class="mt-4 max-w-3xl text-lg text-indigo-100">
                        Use promo code WELCOME15 for an exclusive discount on your first booking.
                    </p>
                </div>
                <div class="mt-8 flex lg:mt-0 lg:flex-shrink-0">
                    <div class="inline-flex rounded-md shadow">
                        <a href="${pageContext.request.contextPath}/rooms-list" class="inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-indigo-50">
                            Book Now
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="views/content/client-side-content.jsp"/>
<!-- Footer -->
<footer class="bg-purple-900 text-white">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <div class="flex items-center">
                    <i class="fas fa-hotel text-purple-300 text-2xl mr-2"></i>
                    <span class="text-xl font-bold text-white">LuxeStay</span>
                </div>
                <p class="mt-4 text-purple-300">
                    Redefining luxury hospitality with exceptional service and unforgettable experiences.
                </p>
                <div class="mt-6 flex space-x-4">
                    <a href="#" class="text-purple-300 hover:text-white"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-purple-300 hover:text-white"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-purple-300 hover:text-white"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-purple-300 hover:text-white"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <div>
                <h3 class="text-lg font-semibold text-white mb-4">Quick Links</h3>
                <ul class="space-y-2 text-purple-300">
                    <li><a href="#" class="hover:text-white">Home</a></li>
                    <li><a href="#" class="hover:text-white">About Us</a></li>
                    <li><a href="#" class="hover:text-white">Rooms & Suites</a></li>
                    <li><a href="#" class="hover:text-white">Facilities</a></li>
                    <li><a href="#" class="hover:text-white">Special Offers</a></li>
                </ul>
            </div>

            <div>
                <h3 class="text-lg font-semibold text-white mb-4">Contact</h3>
                <ul class="space-y-2 text-purple-300">
                    <li class="flex items-start">
                        <i class="fas fa-map-marker-alt mt-1 mr-2"></i>
                        <span>123 Luxury Avenue, Paradise City, PC 12345</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-phone-alt mr-2"></i>
                        <span>+1 (555) 123-4567</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-envelope mr-2"></i>
                        <span>info@luxestay.com</span>
                    </li>
                </ul>
            </div>

            <div>
                <h3 class="text-lg font-semibold text-white mb-4">Newsletter</h3>
                <p class="text-purple-300 mb-4">
                    Subscribe to receive special offers and updates.
                </p>
                <form class="mt-2">
                    <div class="flex">
                        <input type="email" placeholder="Your email" class="px-4 py-2 w-full rounded-l-md focus:outline-none focus:ring-2 focus:ring-purple-500">
                        <button type="submit" class="bg-purple-600 px-4 py-2 rounded-r-md hover:bg-purple-500 transition duration-300">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <div class="mt-12 pt-8 border-t border-purple-800 text-center text-purple-300">
            <p>&copy; 2025 LuxeStay. All rights reserved.</p>
        </div>
    </div>
</footer>



<!-- JavaScript for Auth Logic -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const authButtonsContainer = document.getElementById('authButtons');
        const userId = localStorage.getItem('userId');

        if (userId) {
            const myReservationsLink = document.querySelector('#myReservationsLink');
            if (myReservationsLink) {
                const userId = localStorage.getItem('userId');
                if (userId) {
                    myReservationsLink.href = ${pageContext.request.contextPath}/my-reservations?userId=+userId;
                }
            }

            const profileButton = document.createElement('button');
            profileButton.className = 'bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg flex items-center';
            profileButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                </svg>
                Profile
            `;
            profileButton.addEventListener('click', function() {
                window.location.href = "${pageContext.request.contextPath}/user-details"
            });
            authButtonsContainer.appendChild(profileButton);
        } else {

            const loginButton = document.createElement('button');

            loginButton.className = 'bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg flex items-center';
            loginButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M3 3a1 1 0 011-1h12a1 1 0 011 1v3a1 1 0 01-.293.707L12 11.414V15a1 1 0 01-.293.707l-2 2A1 1 0 018 17v-5.586L3.293 6.707A1 1 0 013 6V3z" clip-rule="evenodd" />
                </svg>
                Login
            `;
            loginButton.addEventListener('click', function() {
                window.location.href = "${pageContext.request.contextPath}/login"
            });
            authButtonsContainer.appendChild(loginButton);
        }
    });
</script>
