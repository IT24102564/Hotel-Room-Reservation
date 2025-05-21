<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Content Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Content Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">
            Back to Dashboard
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-purple-800">Content List</h2>
        <div class="flex space-x-4">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search content..."
                       class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                <div class="absolute left-3 top-2.5 text-gray-400">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div>
                <select id="typeFilter" class="border border-gray-300 rounded-md py-2 px-4 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                    <option value="">All Types</option>
                    <option value="banner">Banner</option>
                    <option value="promotion">Promotion</option>
                    <option value="announcement">Announcement</option>
                    <option value="event">Event</option>
                </select>
            </div>
            <div>
                <select id="statusFilter" class="border border-gray-300 rounded-md py-2 px-4 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                    <option value="">All Status</option>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
            </div>
            <a href="${pageContext.request.contextPath}/create-content"
               class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-md transition duration-300 flex items-center">
                <i class="fas fa-plus mr-2"></i> Create Content
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
        <span id="errorText" class="block sm:inline">Failed to load content data.</span>
    </div>

    <!-- Content Table -->
    <div id="contentTableContainer" class="hidden bg-white shadow-md rounded-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Start Date</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">End Date</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="contentTableBody" class="bg-white divide-y divide-gray-200">
            <!-- Content rows will be inserted here by JavaScript -->
            </tbody>
        </table>
    </div>

    <!-- No Results Message -->
    <div id="noResultsMessage" class="hidden text-center py-12">
        <i class="fas fa-search text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-500 text-xl">No content items found matching your search.</p>
    </div>
</main>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white rounded-lg shadow-xl p-6 max-w-md w-full">
        <div class="text-center">
            <i class="fas fa-exclamation-triangle text-yellow-500 text-5xl mb-4"></i>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Confirm Deletion</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this content item? This action cannot be undone.</p>
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
    let allContent = [];
    let contentToDelete = null;

    // DOM elements
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const contentTableContainer = document.getElementById('contentTableContainer');
    const contentTableBody = document.getElementById('contentTableBody');
    const searchInput = document.getElementById('searchInput');
    const typeFilter = document.getElementById('typeFilter');
    const statusFilter = document.getElementById('statusFilter');
    const noResultsMessage = document.getElementById('noResultsMessage');
    const deleteModal = document.getElementById('deleteModal');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

    // Fetch all content data when page loads
    document.addEventListener('DOMContentLoaded', fetchContentData);

    // Add event listeners
    searchInput.addEventListener('input', filterContent);
    typeFilter.addEventListener('change', filterContent);
    statusFilter.addEventListener('change', filterContent);
    cancelDeleteBtn.addEventListener('click', hideDeleteModal);
    confirmDeleteBtn.addEventListener('click', deleteContent);


    function fetchContentData() {
        showLoading();

        fetch('${pageContext.request.contextPath}/content/')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch content data');
                }
                return response.json();
            })
            .then(data => {
                allContent = data;
                renderContentTable(allContent);
                hideLoading();
            })
            .catch(error => {
                console.error('Error fetching content data:', error);
                showError('Failed to load content data. Please try again later.');
                hideLoading();
            });
    }


    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        const options = { year: 'numeric', month: 'short', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('en-US', options);
    }


    function truncateDescription(description) {
        if (!description) return '';
        return description.length > 10 ? description.substring(0, 10) + '...' : description;
    }


    function getStatusBadge(active) {
        return active ?
            '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Active</span>' :
            '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Inactive</span>';
    }


    function renderContentTable(contentList) {
        contentTableBody.innerHTML = '';

        if (contentList.length === 0) {
            contentTableContainer.classList.add('hidden');
            noResultsMessage.classList.remove('hidden');
            return;
        }

        contentTableContainer.classList.remove('hidden');
        noResultsMessage.classList.add('hidden');

        contentList.forEach(content => {
            const row = document.createElement('tr');
            row.className = 'hover:bg-gray-50';
            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm font-medium text-gray-900\">" + content.title + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + truncateDescription(content.description) + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + content.type + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + formatDate(content.startDate) + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-500\">" + formatDate(content.endDate) + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                getStatusBadge(content.active) +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\">" +
                "<div class=\"flex space-x-2\">" +
                "<a href=\"" + "${pageContext.request.contextPath}" + "/content-details?id=" + content.id + "\" " +
                "class=\"text-indigo-600 hover:text-indigo-900\" title=\"View Details\">" +
                "<i class=\"fas fa-eye\"></i>" +
                "</a>" +
                "<a href=\"" + "${pageContext.request.contextPath}" + "/edit-content?id=" + content.id + "\" " +
                "class=\"text-blue-600 hover:text-blue-900\" title=\"Edit Content\">" +
                "<i class=\"fas fa-edit\"></i>" +
                "</a>" +
                "<button class=\"text-red-600 hover:text-red-900 delete-btn\" data-id=\"" + content.id + "\" title=\"Delete Content\">" +
                "<i class=\"fas fa-trash-alt\"></i>" +
                "</button>" +
                "</div>" +
                "</td>";

            contentTableBody.appendChild(row);
        });


        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const contentId = this.getAttribute('data-id');
                showDeleteModal(contentId);
            });
        });
    }


    function filterContent() {
        const searchTerm = searchInput.value.toLowerCase();
        const typeValue = typeFilter.value.toLowerCase();
        const statusValue = statusFilter.value;

        const filteredContent = allContent.filter(content => {

            const matchesSearch =
                content.title.toLowerCase().includes(searchTerm) ||
                content.description.toLowerCase().includes(searchTerm) ||
                content.type.toLowerCase().includes(searchTerm);


            const matchesType = typeValue === '' || content.type.toLowerCase() === typeValue;


            const matchesStatus = statusValue === '' ||
                (statusValue === 'true' && content.active) ||
                (statusValue === 'false' && !content.active);

            return matchesSearch && matchesType && matchesStatus;
        });

        renderContentTable(filteredContent);
    }


    function showDeleteModal(contentId) {
        contentToDelete = contentId;
        deleteModal.classList.remove('hidden');
    }


    function hideDeleteModal() {
        deleteModal.classList.add('hidden');

    }


    function deleteContent() {
        if (!contentToDelete) return;

        showLoading();
        hideDeleteModal();

        fetch(${pageContext.request.contextPath}/content/+contentToDelete, {
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to delete content');
                }
                // Refresh content data after successful deletion
                fetchContentData();
            })
            .catch(error => {
                console.error('Error deleting content:', error);
                showError('Failed to delete content. Please try again later.');
                hideLoading();
            });
    }

    // Show loading indicator
    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        contentTableContainer.classList.add('hidden');
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