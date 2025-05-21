<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Profile - LuxeStay</title>
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
        .profile-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 255, 255, 1) 100%);
        }
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(91, 33, 182, 0.1), 0 10px 10px -5px rgba(91, 33, 182, 0.04);
        }
        .btn-primary {
            background-color: #6d28d9;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #5b21b6;
        }
        .btn-danger {
            background-color: #ef4444;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #dc2626;
        }
        .btn-secondary {
            background-color: #9ca3af;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #6b7280;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-50 via-purple-50 to-blue-50 min-h-screen">
<!-- Navigation -->
<nav class="fixed w-full z-50 backdrop-blur-md bg-white/70 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <a href="${pageContext.request.contextPath}/" class="flex-shrink-0 flex items-center">
                    <i class="fas fa-hotel text-purple-600 text-2xl mr-2"></i>
                    <span class="text-xl font-bold text-purple-900">LuxeStay</span>
                </a>
                <div class="hidden md:ml-6 md:flex md:space-x-8">
                    <a href="${pageContext.request.contextPath}/" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Home
                    </a>
                    <a href="#" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Rooms
                    </a>
                    <a href="#" class="border-transparent text-gray-600 hover:border-purple-300 hover:text-purple-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Amenities
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

<!-- Main Content -->
<div class="pt-24 pb-12">
    <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-extrabold text-purple-900 sm:text-4xl">Your Profile</h1>
            <p class="mt-3 text-xl text-gray-500">Manage your account details</p>
        </div>

        <!-- Loading State -->
        <div id="loadingState" class="flex justify-center items-center py-12">
            <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-purple-600"></div>
        </div>

        <!-- Error State -->
        <div id="errorState" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md mb-6">
            <p id="errorMessage">An error occurred while loading your profile.</p>
        </div>

        <!-- User Profile Card -->
        <div id="userProfile" class="hidden profile-card rounded-xl shadow-lg overflow-hidden">
            <div class="hero-gradient p-6 text-white">
                <div class="flex items-center">
                    <div class="rounded-full bg-white/20 p-3">
                        <i class="fas fa-user-circle text-4xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-2xl font-bold" id="userFullName">Loading...</h2>
                        <p class="text-purple-200" id="userRole">Loading...</p>
                    </div>
                </div>
            </div>

            <div class="p-6 bg-white">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Username</label>
                            <p class="mt-1 text-lg font-medium text-purple-900" id="username">Loading...</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Email</label>
                            <p class="mt-1 text-lg font-medium text-purple-900" id="email">Loading...</p>
                        </div>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Full Name</label>
                            <p class="mt-1 text-lg font-medium text-purple-900" id="fullName">Loading...</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Phone Number</label>
                            <p class="mt-1 text-lg font-medium text-purple-900" id="phoneNumber">Loading...</p>
                        </div>
                    </div>
                </div>

                <div class="mt-8 flex flex-col sm:flex-row sm:space-x-4 space-y-3 sm:space-y-0">
                    <button id="editProfileBtn" class="btn-primary px-6 py-3 rounded-md font-medium flex items-center justify-center">
                        <i class="fas fa-edit mr-2"></i> Edit Profile
                    </button>
                    <button id="deleteAccountBtn" class="btn-danger px-6 py-3 rounded-md font-medium flex items-center justify-center">
                        <i class="fas fa-trash-alt mr-2"></i> Delete Account
                    </button>
                    <button id="logoutBtn" class="btn-secondary px-6 py-3 rounded-md font-medium flex items-center justify-center">
                        <i class="fas fa-sign-out-alt mr-2"></i> Logout
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        const userId = localStorage.getItem('userId');
        const authButtons = document.getElementById('authButtons');

        if (!userId) {

            window.location.href = '${pageContext.request.contextPath}/login';
            return;
        }


        authButtons.innerHTML = `
            <a href="${pageContext.request.contextPath}/user-details" class="ml-3 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                <i class="fas fa-user-circle mr-2"></i> My Profile
            </a>
            <button id="navLogoutBtn" class="ml-3 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-purple-700 bg-purple-100 hover:bg-purple-200">
                <i class="fas fa-sign-out-alt mr-2"></i> Logout
            </button>
        `;


        document.getElementById('navLogoutBtn').addEventListener('click', handleLogout);


        fetchUserData(userId);


        document.getElementById('editProfileBtn').addEventListener('click', function() {
            window.location.href = '${pageContext.request.contextPath}/edit-user';
        });

        document.getElementById('deleteAccountBtn').addEventListener('click', handleDeleteAccount);
        document.getElementById('logoutBtn').addEventListener('click', handleLogout);
    });

    async function fetchUserData(userId) {
        const loadingState = document.getElementById('loadingState');
        const errorState = document.getElementById('errorState');
        const userProfile = document.getElementById('userProfile');

        try {
            const response = await fetch(${pageContext.request.contextPath}/users/+userId);

            if (!response.ok) {
                throw new Error('Failed to fetch user data');
            }

            const data = await response.json();


            document.getElementById('userFullName').textContent = data.fullName;
            document.getElementById('userRole').textContent = data.role;
            document.getElementById('username').textContent = data.username;
            document.getElementById('email').textContent = data.email;
            document.getElementById('fullName').textContent = data.fullName;
            document.getElementById('phoneNumber').textContent = data.phoneNumber;


            loadingState.classList.add('hidden');
            userProfile.classList.remove('hidden');
        } catch (error) {
            console.error('Error fetching user data:', error);

            loadingState.classList.add('hidden');
            errorState.classList.remove('hidden');
            document.getElementById('errorMessage').textContent = error.message || 'An error occurred while loading your profile.';
        }
    }

    function handleDeleteAccount() {
        if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
            const userId = localStorage.getItem('userId');

            fetch(${pageContext.request.contextPath}/users/+userId, {
                method: 'DELETE'
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to delete account');
                    }

                    localStorage.clear();
                    window.location.href = '${pageContext.request.contextPath}/';
                })
                .catch(error => {
                    console.error('Error deleting account:', error);
                    alert('Failed to delete account. Please try again.');
                });
        }
    }

    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {

            localStorage.clear();

            window.location.href = '${pageContext.request.contextPath}/';
        }
    }
</script>
</body>
</html>
