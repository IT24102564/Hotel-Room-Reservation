<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Management - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Feedback Management</h1>
        <a href="${pageContext.request.contextPath}/admin-dashboard"
           class="text-sm text-purple-600 hover:text-purple-900">
            <i class="fas fa-arrow-left mr-1"></i> Back to Dashboard
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-purple-800">Customer Feedbacks</h2>
    </div>

    <!-- Loading Spinner -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load feedback data.</span>
    </div>

    <!-- Feedback List -->
    <div id="feedbackContainer" class="hidden">
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>

                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rating</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Comment</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Submission Date</th>
                        </tr>
                    </thead>
                    <tbody id="feedbackTableBody" class="bg-white divide-y divide-gray-200">
                        <!-- Feedback items will be inserted here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- No Feedbacks Message -->
    <div id="noFeedbacksMessage" class="hidden bg-white p-6 rounded-lg shadow-md text-center">
        <i class="fas fa-comment-slash text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-600">No feedbacks available at this time.</p>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loadingIndicator = document.getElementById('loadingIndicator');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const feedbackContainer = document.getElementById('feedbackContainer');
        const feedbackTableBody = document.getElementById('feedbackTableBody');
        const noFeedbacksMessage = document.getElementById('noFeedbacksMessage');
        
        // Sample feedback data (in a real application, this would come from an API)
        const feedbackData = [];



        
        // Function to fetch user details
        async function fetchUserDetails(userId) {
            try {
                const response = await fetch(`${pageContext.request.contextPath}/users/`+userId);
                if (!response.ok) {
                    throw new Error('Failed to fetch user details');
                }
                return await response.json();
            } catch (error) {
                console.error('Error fetching user details:', error);
                return { name: 'Unknown User', email: 'N/A' };
            }
        }
        
        // Function to format date
        function formatDate(dateString) {
            const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
            return new Date(dateString).toLocaleDateString('en-US', options);
        }
        
        // Function to render star rating
        function renderStarRating(rating) {
            let stars = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) {
                    stars += '<i class="fas fa-star text-yellow-400"></i>';
                } else {
                    stars += '<i class="far fa-star text-gray-300"></i>';
                }
            }
            return stars;
        }
        
        // Function to load and display feedbacks
        async function loadFeedbacks() {
            try {
                // In a real application, you would fetch data from an API
                 const response = await fetch('${pageContext.request.contextPath}/feedback');
                 const feedbackData = await response.json();
                

                
                if (feedbackData.length === 0) {
                    noFeedbacksMessage.classList.remove('hidden');
                } else {
                    // Process each feedback
                    for (const feedback of feedbackData) {
                        // Fetch user details for each feedback
                        const user = await fetchUserDetails(feedback.userId);
                        
                        // Create table row
                        const row = document.createElement('tr');
                        row.className = 'hover:bg-gray-50';
                        
                        // Format the date
                        const formattedDate = formatDate(feedback.submissionDate);
                        
                        // Populate row with feedback data
                      row.innerHTML =
                              "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                              "<div class=\"flex items-center\">" +
                              "<div class=\"ml-4\">" +
                              "<div class=\"text-sm font-medium text-gray-900\" title=\"" + (user.fullName || 'Unknown User') + "\">" +
                              (user.fullName || 'Unknown User') +
                              "</div>" +
                              "<div class=\"text-sm text-gray-500\">" + (user.email || 'N/A') + "</div>" +
                              "</div>" +
                              "</div>" +
                              "</td>" +

                              "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                              "<div class=\"flex items-center\">" +
                              renderStarRating(feedback.rating) +
                              "<span class=\"ml-2 text-sm text-gray-600\">(" + feedback.rating + "/5)</span>" +
                              "</div>" +
                              "</td>" +
                              "<td class=\"px-6 py-4\">" +
                              "<div class=\"text-sm text-gray-900\" title=\"" + (feedback.comment || 'No comment provided') + "\">" +
                              (feedback.comment || 'No comment provided') +
                              "</div>" +
                              "</td>" +
                              "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                              formattedDate +
                              "</td>";


                      feedbackTableBody.appendChild(row);
                    }
                    
                    feedbackContainer.classList.remove('hidden');
                }
            } catch (error) {
                console.error('Error loading feedbacks:', error);
                errorText.textContent = 'Failed to load feedback data. Please try again later.';
                errorMessage.classList.remove('hidden');
            } finally {
                loadingIndicator.classList.add('hidden');
            }
        }
        
        // Load feedbacks when the page loads
        loadFeedbacks();
    });
</script>

</body>
</html>
