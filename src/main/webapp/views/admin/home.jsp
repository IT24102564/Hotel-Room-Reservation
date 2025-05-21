<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Luxe Hotel Admin</h1>
        <a href="${pageContext.request.contextPath}/users/logout"
           class="text-sm text-purple-600 hover:text-purple-900">
            Logout
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <h2 class="text-xl font-semibold mb-6 text-purple-800">Admin Dashboard</h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Room Management -->
        <a href="${pageContext.request.contextPath}/admin/rooms" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-bed text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">Room Management</h3>
                    <p class="text-sm text-gray-500">Manage hotel rooms and availability</p>
                </div>
            </div>
        </a>

        <!-- Content Management -->
        <a href="${pageContext.request.contextPath}/content-list" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-pen-nib text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">Content Management</h3>
                    <p class="text-sm text-gray-500">Edit website content and banners</p>
                </div>
            </div>
        </a>

        <!-- Reservation Management -->
        <a href="${pageContext.request.contextPath}/admin-reservations" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-calendar-check text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">Reservation Management</h3>
                    <p class="text-sm text-gray-500">View and manage bookings</p>
                </div>
            </div>
        </a>

        <!-- Staff Management -->
        <a href="${pageContext.request.contextPath}/staff-list" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-user-tie text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">Staff Management</h3>
                    <p class="text-sm text-gray-500">Manage staff information and roles</p>
                </div>
            </div>
        </a>

        <!-- Feedback Management -->
        <a href="${pageContext.request.contextPath}/admin-feedback" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-comment-dots text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">Feedback Management</h3>
                    <p class="text-sm text-gray-500">Review guest feedbacks and reviews</p>
                </div>
            </div>
        </a>

        <!-- User Management -->
        <a href="${pageContext.request.contextPath}/admin/users" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition transform hover:-translate-y-1 border-l-4 border-purple-500">
            <div class="flex items-center">
                <i class="fas fa-users text-purple-600 text-2xl mr-4"></i>
                <div>
                    <h3 class="text-lg font-medium text-gray-800">User Management</h3>
                    <p class="text-sm text-gray-500">Create, view and delete users</p>
                </div>
            </div>
        </a>
    </div>
</main>

</body>
</html>