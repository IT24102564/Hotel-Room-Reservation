<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">User Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">
            Back to Dashboard
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-purple-800">User List</h2>
        <div class="flex space-x-4">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search users..."
                       class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                <div class="absolute left-3 top-2.5 text-gray-400">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div>
                <select id="roleFilter" class="border border-gray-300 rounded-md py-2 px-4 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                    <option value="">All Roles</option>
                    <option value="admin">Admin</option>
                    <option value="customer">Customer</option>
                    <option value="staff">Staff</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load user data.</span>
    </div>

    <!-- Users Table -->
    <div id="usersTableContainer" class="hidden bg-white shadow-md rounded-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Username</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Full Name</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone Number</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="usersTableBody" class="bg-white divide-y divide-gray-200">
            <!-- User rows will be inserted here by JavaScript -->
            </tbody>
        </table>
    </div>

    <!-- No Results Message -->
    <div id="noResultsMessage" class="hidden text-center py-12">
        <i class="fas fa-search text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-500 text-xl">No users found matching your search.</p>
    </div>
</main>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white rounded-lg shadow-xl p-6 max-w-md w-full">
        <div class="text-center">
            <i class="fas fa-exclamation-triangle text-yellow-500 text-5xl mb-4"></i>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Confirm Deletion</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this user? This action cannot be undone.</p>
            <p id="deleteUserInfo" class="text-sm font-medium text-gray-800 bg-gray-100 p-3 rounded mb-6"></p>
        </div>
        <div class="flex justify-center space-x-4">
            <button id="cancelDeleteBtn" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-md transition duration-300">
                Cancel
            </button>
            <button id="confirmDeleteBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-md transition duration-300">
                Delete
            </button>
        </div>
    </div>
</div>

<script>

    let allUsers = [];
    let userToDelete = null;


    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const usersTableContainer = document.getElementById('usersTableContainer');
    const usersTableBody = document.getElementById('usersTableBody');
    const searchInput = document.getElementById('searchInput');
    const roleFilter = document.getElementById('roleFilter');
    const noResultsMessage = document.getElementById('noResultsMessage');
    const deleteModal = document.getElementById('deleteModal');
    const deleteUserInfo = document.getElementById('deleteUserInfo');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');


    document.addEventListener('DOMContentLoaded', fetchUsersData);

    searchInput.addEventListener('input', filterUsers);
    roleFilter.addEventListener('change', filterUsers);
    cancelDeleteBtn.addEventListener('click', hideDeleteModal);
    confirmDeleteBtn.addEventListener('click', deleteUser);


    function fetchUsersData() {
        showLoading();

        setTimeout(() => {

            renderUsersTable(allUsers);
            hideLoading();
        }, 500);



        fetch('${pageContext.request.contextPath}/users/')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch users data');
                }
                return response.json();
            })
            .then(data => {
                allUsers = data;
                renderUsersTable(allUsers);
                hideLoading();
            })
            .catch(error => {
                console.error('Error fetching users data:', error);
                showError('Failed to load users data. Please try again later.');
                hideLoading();
            });

    }


    function getRoleBadge(role) {
        if (!role || role === 'null') {
            return '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Not Assigned</span>';
        }

        const badges = {
            admin: '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-purple-100 text-purple-800">Admin</span>',
            customer: '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">Customer</span>',
            staff: '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Staff</span>'
        };

        return badges[role.toLowerCase()] || '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Unknown</span>';
    }


    function renderUsersTable(usersList) {
        usersTableBody.innerHTML = '';

        if (usersList.length === 0) {
            usersTableContainer.classList.add('hidden');
            noResultsMessage.classList.remove('hidden');
            return;
        }

        usersTableContainer.classList.remove('hidden');
        noResultsMessage.classList.add('hidden');

        usersList.forEach(user => {
            const row = document.createElement('tr');
            row.className = 'hover:bg-gray-50';

            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm font-medium text-gray-900\">" + user.username + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-900\">" + user.fullName + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + user.email + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + user.phoneNumber + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                getRoleBadge(user.role) +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\">" +
                "<button class=\"text-red-600 hover:text-red-900 delete-btn\" " +
                "data-id=\"" + user.id + "\" " +
                "data-username=\"" + user.username + "\" " +
                "title=\"Delete User\">" +
                "<i class=\"fas fa-trash-alt\"></i>" +
                "</button>" +
                "</td>";


            usersTableBody.appendChild(row);
        });


        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const userId = this.getAttribute('data-id');
                const username = this.getAttribute('data-username');
                showDeleteModal(userId, username);
            });
        });
    }


    function filterUsers() {
        const searchTerm = searchInput.value.toLowerCase();
        const roleValue = roleFilter.value.toLowerCase();

        const filteredUsers = allUsers.filter(user => {

            const matchesSearch =
                user.username.toLowerCase().includes(searchTerm) ||
                user.fullName.toLowerCase().includes(searchTerm) ||
                user.email.toLowerCase().includes(searchTerm) ||
                user.phoneNumber.toLowerCase().includes(searchTerm);

            let userRole = user.role;
            if (userRole === 'null' || !userRole) {
                userRole = '';
            }

            const matchesRole = roleValue === '' || userRole.toLowerCase() === roleValue;

            return matchesSearch && matchesRole;
        });

        renderUsersTable(filteredUsers);
    }


    function showDeleteModal(userId, username) {
        userToDelete = userId;
        deleteUserInfo.textContent = `Username: `+username;
        deleteModal.classList.remove('hidden');
    }


    function hideDeleteModal() {
        deleteModal.classList.add('hidden');

    }


    function deleteUser() {
        if (!userToDelete) return;

        showLoading();
        hideDeleteModal();

        fetch(${pageContext.request.contextPath}/users/+userToDelete, {
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to delete user');
                }

                return fetchUsersData();
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                showError('Failed to delete user. Please try again later.');
                hideLoading();
            });

        setTimeout(() => {

            renderUsersTable(allUsers);
            hideLoading();
        }, 500);
    }


    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        usersTableContainer.classList.add('hidden');
        errorMessage.classList.add('hidden');
        noResultsMessage.classList.add('hidden');
    }


    function hideLoading() {
        loadingIndicator.classList.add('hidden');
    }


    function showError(message) {
        errorText.textContent = message;
        errorMessage.classList.remove('hidden');
    }
</script>

</body>
</html>