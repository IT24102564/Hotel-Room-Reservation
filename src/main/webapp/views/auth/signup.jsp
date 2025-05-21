<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up - LuxeStay</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Lottie Player -->
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, rgba(91, 33, 182, 0.8) 0%, rgba(124, 58, 237, 0.7) 50%, rgba(139, 92, 246, 0.6) 100%);
            overflow: hidden;
            position: relative;
        }
        .signup-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.2) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            z-index: 10;
        }
        .signup-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(91, 33, 182, 0.1), 0 10px 10px -5px rgba(91, 33, 182, 0.04);
        }
        .input-field {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        .input-field:focus {
            border-color: rgba(139, 92, 246, 0.8);
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
        }
        .lottie-bg {
            position: absolute;
            opacity: 0.3;
            z-index: 1;
            animation: float 15s infinite ease-in-out;
        }
        .lottie-bg:nth-child(1) {
            top: 10%;
            left: 5%;
            width: 200px;
            height: 200px;
            animation-delay: 0s;
        }
        .lottie-bg:nth-child(2) {
            top: 60%;
            left: 80%;
            width: 250px;
            height: 250px;
            animation-delay: 3s;
            animation-duration: 18s;
        }
        .lottie-bg:nth-child(3) {
            top: 30%;
            left: 70%;
            width: 150px;
            height: 150px;
            animation-delay: 6s;
            animation-duration: 12s;
        }
        .lottie-bg:nth-child(4) {
            top: 70%;
            left: 20%;
            width: 180px;
            height: 180px;
            animation-delay: 9s;
            animation-duration: 20s;
        }
        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) rotate(0deg);
            }
            25% {
                transform: translate(10px, 10px) rotate(5deg);
            }
            50% {
                transform: translate(20px, -10px) rotate(-5deg);
            }
            75% {
                transform: translate(-10px, 15px) rotate(5deg);
            }
        }
    </style>
    <script
            src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs"
            type="module"
    ></script>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
<!-- Floating Lottie Background Elements -->
<div class="lottie-bg">
    <dotlottie-player
            src="https://lottie.host/1c3e7cf5-6b54-4c18-bdec-f8909da02f41/kloh3F0EgD.lottie"
            background="transparent"
            speed="0.5"
            loop
            autoplay
    ></dotlottie-player>
</div>
<div class="lottie-bg">
    <dotlottie-player
            src="https://lottie.host/1c3e7cf5-6b54-4c18-bdec-f8909da02f41/kloh3F0EgD.lottie"
            background="transparent"
            speed="0.5"
            loop
            autoplay
    ></dotlottie-player>
</div>
<div class="lottie-bg">
    <dotlottie-player
            src="https://lottie.host/1c3e7cf5-6b54-4c18-bdec-f8909da02f41/kloh3F0EgD.lottie"
            background="transparent"
            speed="0.5"
            loop
            autoplay
    ></dotlottie-player>
</div>
<div class="lottie-bg">
    <dotlottie-player
            src="https://lottie.host/1c3e7cf5-6b54-4c18-bdec-f8909da02f41/kloh3F0EgD.lottie"
            background="transparent"
            speed="0.5"
            loop
            autoplay
    ></dotlottie-player>
</div>

<!-- Signup Card -->
<div class="w-full max-w-md signup-card rounded-xl shadow-lg p-8">
    <div class="text-center mb-8">
        <a href="${pageContext.request.contextPath}/" class="flex items-center justify-center mb-4">
            <i class="fas fa-hotel text-white text-3xl mr-2"></i>
            <span class="text-2xl font-bold text-white">LuxeStay</span>
        </a>
        <h2 class="text-2xl font-bold text-white">Create Account</h2>
        <p class="text-purple-100 mt-2">Join LuxeStay today</p>
    </div>

    <form id="signupForm" class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-sm font-medium text-purple-100 mb-2" for="username">
                    Username
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-user text-purple-300"></i>
                    </div>
                    <input
                            type="text"
                            id="username"
                            name="username"
                            class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                            placeholder="Choose a username"
                            required
                    />
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-purple-100 mb-2" for="fullName">
                    Full Name
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-id-card text-purple-300"></i>
                    </div>
                    <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                            placeholder="Your full name"
                            required
                    />
                </div>
            </div>
        </div>

        <div>
            <label class="block text-sm font-medium text-purple-100 mb-2" for="email">
                Email Address
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-envelope text-purple-300"></i>
                </div>
                <input
                        type="email"
                        id="email"
                        name="email"
                        class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                        placeholder="Your email address"
                        required
                />
            </div>
        </div>

        <div>
            <label class="block text-sm font-medium text-purple-100 mb-2" for="phoneNumber">
                Phone Number
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-phone text-purple-300"></i>
                </div>
                <input
                        type="tel"
                        id="phoneNumber"
                        name="phoneNumber"
                        class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                        placeholder="Your phone number"
                        required
                />
            </div>
        </div>

        <div>
            <label class="block text-sm font-medium text-purple-100 mb-2" for="password">
                Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-lock text-purple-300"></i>
                </div>
                <input
                        type="password"
                        id="password"
                        name="password"
                        class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                        placeholder="Create a password"
                        required
                />
            </div>
        </div>

        <div>
            <label class="block text-sm font-medium text-purple-100 mb-2" for="confirmPassword">
                Confirm Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-lock text-purple-300"></i>
                </div>
                <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white placeholder-purple-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
                        placeholder="Confirm your password"
                        required
                />
            </div>
        </div>

        <div class="mt-6">
            <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition duration-300">
                Create Account
            </button>
        </div>
    </form>

    <div class="mt-6">
        <div class="relative">
            <div class="absolute inset-0 flex items-center">
                <div class="w-full border-t border-purple-300/30"></div>
            </div>
            <div class="relative flex justify-center text-sm">
                <span class="px-2 bg-transparent text-purple-100">Or continue with</span>
            </div>
        </div>

        <div class="mt-6 grid grid-cols-3 gap-3">
            <a href="#" class="w-full inline-flex justify-center py-2 px-4 border border-purple-300/50 rounded-md shadow-sm bg-white/10 text-sm font-medium text-white hover:bg-white/20 transition duration-300">
                <i class="fab fa-google text-purple-100"></i>
            </a>
            <a href="#" class="w-full inline-flex justify-center py-2 px-4 border border-purple-300/50 rounded-md shadow-sm bg-white/10 text-sm font-medium text-white hover:bg-white/20 transition duration-300">
                <i class="fab fa-twitter text-purple-100"></i>
            </a>
            <a href="#" class="w-full inline-flex justify-center py-2 px-4 border border-purple-300/50 rounded-md shadow-sm bg-white/10 text-sm font-medium text-white hover:bg-white/20 transition duration-300">
                <i class="fab fa-facebook-f text-purple-100"></i>
            </a>
        </div>
    </div>

    <p class="mt-8 text-center text-sm text-purple-100">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login" class="font-medium text-white hover:text-purple-200 underline">
            Sign in
        </a>
    </p>

    <div id="error" class="mt-4 text-center text-sm text-red-300 hidden"></div>
</div>

<script>
    document.getElementById('signupForm').addEventListener('submit', function(e) {
        e.preventDefault();


        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const errorDiv = document.getElementById('error');

        if (password !== confirmPassword) {
            errorDiv.textContent = "Passwords do not match";
            errorDiv.classList.remove('hidden');
            return;
        }


        const userData = {
            username: document.getElementById('username').value,
            password: password,
            email: document.getElementById('email').value,
            fullName: document.getElementById('fullName').value,
            phoneNumber: document.getElementById('phoneNumber').value,
            role: "customer" // Default role for new signups
        };


        fetch('${pageContext.request.contextPath}/users/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw err; });
                }
                return response.json();
            })
            .then(data => {

                localStorage.setItem('userId', data.id);


                window.location.href = '${pageContext.request.contextPath}/';
            })
            .catch(error => {
                errorDiv.textContent = error.error || "An error occurred during signup. Please try again.";
                errorDiv.classList.remove('hidden');
            });
    });
</script>
</body>
</html>
