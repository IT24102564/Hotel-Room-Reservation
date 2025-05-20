<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Profile - LuxeStay</title>
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
        .btn-secondary {
            background-color: #9ca3af;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #6b7280;
        }
        .input-field {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(209, 213, 219, 0.8);
            transition: all 0.3s ease;
        }
        .input-field:focus {
            border-color: rgba(139, 92, 246, 0.8);
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
        }
        .error-message {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
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
            <h1 class="text-3xl font-extrabold text-purple-900 sm:text-4xl">Edit Your Profile</h1>
            <p class="mt-3 text-xl text-gray-500">Update your account information</p>
        </div>

        <!-- Loading State -->
        <div id="loadingState" class="flex justify-center items-center py-12">
            <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-purple-600"></div>
        </div>

        <!-- Error State -->
        <div id="errorState" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md mb-6">
            <p id="errorMessage">An error occurred while loading your profile.</p>
        </div>

        <!-- Edit Profile Form -->
        <div id="editProfileForm" class="hidden profile-card rounded-xl shadow-lg overflow-hidden">
            <div class="hero-gradient p-6 text-white">
                <div class="flex items-center">
                    <div class="rounded-full bg-white/20 p-3">
                        <i class="fas fa-user-edit text-4xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-2xl font-bold">Update Your Information</h2>
                        <p class="text-purple-200">Make changes to your profile</p>
                    </div>
                </div>
            </div>

            <div class="p-6 bg-white">
                <form id="userForm" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                            <div class="mt-1 relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-user text-gray-400"></i>
                                </div>
                                <input type="text" id="username" name="username" class="input-field focus:ring-purple-500 focus:border-purple-500 block w-full pl-10 pr-3 py-3 sm:text-sm border-gray-300 rounded-md" placeholder="Your username">
                                <p class="error-message hidden" id="username-error"></p>
                            </div>
                        </div>

                        <div>
                            <label for="fullName" class="block text-sm font-medium text-gray-700">Full Name</label>
                            <div class="mt-1 relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-id-card text-gray-400"></i>
                                </div>
                                <input type="text" id="fullName" name="fullName" class="input-field focus:ring-purple-500 focus:border-purple-500 block w-full pl-10 pr-3 py-3 sm:text-sm border-gray-300 rounded-md" placeholder="Your full name">
                                <p class="error-message hidden" id="fullName-error"></p>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-gray-400"></i>
                            </div>
                            <input type="email" id="email" name="email" class="input-field focus:ring-purple-500 focus:border-purple-500 block w-full pl-10 pr-3 py-3 sm:text-sm border-gray-300 rounded-md" placeholder="Your email address">
                            <p class="error-message hidden" id="email-error"></p>
                        </div>
                    </div>

                    <div>
                        <label for="phoneNumber" class="block text-sm font-medium text-gray-700">Phone Number</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-phone text-gray-400"></i>
                            </div>
                            <input type="tel" id="phoneNumber" name="phoneNumber" class="input-field focus:ring-purple-500 focus:border-purple-500 block w-full pl-10 pr-3 py-3 sm:text-sm border-gray-300 rounded-md" placeholder="Your phone number">
                            <p class="error-message hidden" id="phoneNumber-error"></p>
                        </div>
                    </div>

                    <div class="flex flex-col sm:flex-row sm:space-x-4 space-y-3 sm:space-y-0">
                        <button type="submit" id="saveChangesBtn" class="btn-primary px-6 py-3 rounded-md font-medium flex items-center justify-center">
                            <i class="fas fa-save mr-2"></i> Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/user-details" class="btn-secondary px-6 py-3 rounded-md font-medium flex items-center justify-center">
                            <i class="fas fa-times mr-2"></i> Cancel
                        </a>
                    </div>
                </form>

                <!-- Success Message -->
                <div id="successMessage" class="hidden mt-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-md">
                    <p>Your profile has been updated successfully!</p>
                </div>

                <!-- Form Error Message -->
                <div id="formErrorMessage" class="hidden mt-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md">
                    <p>There was an error updating your profile. Please try again.</p>
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

        document.getElementById('userForm').addEventListener('submit', function(e) {
            e.preventDefault();
            if (validateForm()) {
                updateUserProfile(userId);
            }
        });
    });

    const validationRules = {
        username: {
            pattern: /^[a-zA-Z0-9_]{3,20}$/,
            message: 'Username must be 3-20 characters and can only contain letters, numbers, and underscores.'
        },
        fullName: {
            pattern: /^[a-zA-Z\s]{2,50}$/,
            message: 'Full name must be 2-50 characters and can only contain letters and spaces.'
        },
        email: {
            pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
            message: 'Please enter a valid email address.'
        },
        phoneNumber: {
            pattern: /^[0-9]{10}$/,
            message: 'Phone number must be 10 digits.'
        }
    };

    function validateForm() {
        let isValid = true;

        document.querySelectorAll('.error-message').forEach(el => {
            el.classList.add('hidden');
            el.textContent = '';
        });

        for (const field in validationRules) {
            const input = document.getElementById(field);
            const errorElement = document.getElementById(${field}-error);

            if (!validationRules[field].pattern.test(input.value)) {
                errorElement.textContent = validationRules[field].message;
                errorElement.classList.remove('hidden');
                isValid = false;
            }
        }

        return isValid;
    }

    async function fetchUserData(userId) {
        const loadingState = document.getElementById('loadingState');
        const errorState = document.getElementById('errorState');
        const editProfileForm = document.getElementById('editProfileForm');

        try {
            const response = await fetch(${pageContext.request.contextPath}/users/+userId);

            if (!response.ok) {
                throw new Error('Failed to fetch user data');
            }

            const data = await response.json();

            document.getElementById('username').value = data.username;
            document.getElementById('email').value = data.email;
            document.getElementById('fullName').value = data.fullName;
            document.getElementById('phoneNumber').value = data.phoneNumber;

            loadingState.classList.add('hidden');
            editProfileForm.classList.remove('hidden');
        } catch (error) {
            console.error('Error fetching user data:', error);

            loadingState.classList.add('hidden');
            errorState.classList.remove('hidden');
            document.getElementById('errorMessage').textContent = error.message || 'An error occurred while loading your profile.';
        }
    }

    async function updateUserProfile(userId) {

        document.getElementById('saveChangesBtn').disabled = true;
        document.getElementById('saveChangesBtn').innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Saving...';

        document.getElementById('successMessage').classList.add('hidden');
        document.getElementById('formErrorMessage').classList.add('hidden');

        try {
            const userData = {
                username: document.getElementById('username').value,
                email: document.getElementById('email').value,
                fullName: document.getElementById('fullName').value,
                phoneNumber: document.getElementById('phoneNumber').value
            };

            const response = await fetch(${pageContext.request.contextPath}/users/+userId, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(userData)
            });

            if (!response.ok) {
                throw new Error('Failed to update profile');
            }

            document.getElementById('successMessage').classList.remove('hidden');

            document.getElementById('saveChangesBtn').disabled = false;
            document.getElementById('saveChangesBtn').innerHTML = '<i class="fas fa-save mr-2"></i> Save Changes';

            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/user-details';
            }, 2000);

        } catch (error) {
            console.error('Error updating profile:', error);

            document.getElementById('formErrorMessage').classList.remove('hidden');

            document.getElementById('saveChangesBtn').disabled = false;
            document.getElementById('saveChangesBtn').innerHTML = '<i class="fas fa-save mr-2"></i> Save Changes';
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
