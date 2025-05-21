<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Luxe Hotel Staff Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">

            Back to Home
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-purple-800">Staff List</h2>
        <div class="flex space-x-4">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search staff..."
                       class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                <div class="absolute left-3 top-2.5 text-gray-400">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/create-staff"
               class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-md transition duration-300 flex items-center">
                <i class="fas fa-plus mr-2"></i> Create Staff
            </a>
        </div>
    </div>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load staff data.</span>
    </div>

    <!-- Staff Table -->
    <div id="staffTableContainer" class="hidden bg-white shadow-md rounded-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Position</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Department</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Salary</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Hire Date</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="staffTableBody" class="bg-white divide-y divide-gray-200">
            <!-- Staff rows will be inserted here by JavaScript -->
            </tbody>
        </table>
    </div>

    <!-- No Results Message -->
    <div id="noResultsMessage" class="hidden text-center py-12">
        <i class="fas fa-search text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-500 text-xl">No staff members found matching your search.</p>
    </div>
</main>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white rounded-lg shadow-xl p-6 max-w-md w-full">
        <div class="text-center">
            <i class="fas fa-exclamation-triangle text-yellow-500 text-5xl mb-4"></i>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Confirm Deletion</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this staff member? This action cannot be undone.</p>
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
    // Global variables
    let allStaff = [];
    let staffToDelete = null;

    // DOM elements
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const staffTableContainer = document.getElementById('staffTableContainer');
    const staffTableBody = document.getElementById('staffTableBody');
    const searchInput = document.getElementById('searchInput');
    const noResultsMessage = document.getElementById('noResultsMessage');
    const deleteModal = document.getElementById('deleteModal');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

    // Fetch all staff data when page loads
    document.addEventListener('DOMContentLoaded', fetchStaffData);

    // Add event listeners
    searchInput.addEventListener('input', filterStaff);
    cancelDeleteBtn.addEventListener('click', hideDeleteModal);
    confirmDeleteBtn.addEventListener('click', deleteStaff);

    // Fetch staff data from the server
    function fetchStaffData() {
        showLoading();

        fetch('${pageContext.request.contextPath}/staff/')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch staff data');
                }
                return response.json();
            })
            .then(data => {
                allStaff = data;
                console.table(allStaff)
                renderStaffTable(allStaff);
                hideLoading();
            })
            .catch(error => {
                console.error('Error fetching staff data:', error);
                showError('Failed to load staff data. Please try again later.');
                hideLoading();
            });
    }

    // Render staff table with provided data
    function renderStaffTable(staffList) {
        staffTableBody.innerHTML = '';

        if (staffList.length === 0) {
            staffTableContainer.classList.add('hidden');
            noResultsMessage.classList.remove('hidden');
            return;
        }

        staffTableContainer.classList.remove('hidden');
        noResultsMessage.classList.add('hidden');

        staffList.forEach(staff => {
            const row = document.createElement('tr');
            row.className = 'hover:bg-gray-50';

            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm font-medium text-gray-900\">" + staff.name + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + staff.position + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + staff.department + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + staff.email + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + staff.phoneNumber + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">$" + staff.salary.toFixed(2) + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + staff.hireDate + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\">" +
                "<div class=\"flex space-x-2\">" +
                "<a href=\"" + "${pageContext.request.contextPath}" + "/edit-staff?id=" + staff.id + "\" " +
                "class=\"text-indigo-600 hover:text-indigo-900\">" +
                "<i class=\"fas fa-edit\"></i>" +
                "</a>" +
                "<button class=\"text-red-600 hover:text-red-900 delete-btn\" data-id=\"" + staff.id + "\">" +
                "<i class=\"fas fa-trash-alt\"></i>" +
                "</button>" +
                "</div>" +
                "</td>";

            staffTableBody.appendChild(row);
        });

        // Add event listeners to delete buttons
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const staffId = this.getAttribute('data-id');
                showDeleteModal(staffId);
            });
        });
    }

    // Filter staff based on search input
    function filterStaff() {
        const searchTerm = searchInput.value.toLowerCase();

        if (searchTerm === '') {
            renderStaffTable(allStaff);
            return;
        }

        const filteredStaff = allStaff.filter(staff => {
            return (
                staff.name.toLowerCase().includes(searchTerm) ||
                staff.position.toLowerCase().includes(searchTerm) ||
                staff.department.toLowerCase().includes(searchTerm) ||
                staff.email.toLowerCase().includes(searchTerm) ||
                staff.phoneNumber.toLowerCase().includes(searchTerm)
            );
        });

        renderStaffTable(filteredStaff);
    }

    // Show delete confirmation modal
    function showDeleteModal(staffId) {
        staffToDelete = staffId;
        deleteModal.classList.remove('hidden');
    }

    // Hide delete confirmation modal
    function hideDeleteModal() {
        deleteModal.classList.add('hidden');
        //staffToDelete = null;
    }

    // Delete staff member
    function deleteStaff() {
        if (!staffToDelete) return;

        showLoading();
        hideDeleteModal();

        fetch(${pageContext.request.contextPath}/staff/+staffToDelete, {
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to delete staff member');
                }
                // Refresh staff data after successful deletion
                fetchStaffData();
            })
            .catch(error => {
                console.error('Error deleting staff:', error);
                showError('Failed to delete staff member. Please try again later.');
                hideLoading();
            });
    }

    // Show loading indicator
    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        staffTableContainer.classList.add('hidden');
        errorMessage.classList.add('hidden');
        noResultsMessage.classList.add('hidden');
    }

    // Hide loading indicator
    function hideLoading() {
        loadingIndicator.classList.add('hidden');
    }

    // Show error message
    function showError(message) {
        errorText.textContent = message;
        errorMessage.classList.remove('hidden');
    }
</script>

</body>
</html>