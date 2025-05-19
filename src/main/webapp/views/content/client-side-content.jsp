<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxe Hotel - Promotions & News</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
<!-- Header/Navigation -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex">
                <div class="flex-shrink-0 flex items-center">
                    <a href="<%= request.getContextPath() %>/" class="text-xl font-bold text-purple-700">Luxe Hotel</a>
                </div>
            </div>
            <div class="flex items-center">
                <a href="<%= request.getContextPath() %>/" class="text-gray-600 hover:text-purple-700 px-3 py-2 rounded-md text-sm font-medium">
                    <i class="fas fa-home mr-1"></i> Home
                </a>
            </div>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">Latest Promotions & News</h1>

    <!-- Loading Indicator -->
    <div id="loadingIndicator" class="flex justify-center items-center">

    </div>

    <!-- Error Message -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
        <strong class="font-bold">Error!</strong>
        <span id="errorText" class="block sm:inline">Failed to load content.</span>
    </div>

    <!-- Content Grid -->
    <div id="contentGrid" class="hidden grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Content cards will be dynamically inserted here -->
    </div>

    <!-- No Content Message -->
    <div id="noContentMessage" class="hidden text-center py-12">
        <i class="fas fa-newspaper text-gray-400 text-5xl mb-4"></i>
        <p class="text-gray-500 text-lg">No promotions or news available at this time.</p>
    </div>
</main>

<!-- Content Detail Modal -->
<div id="contentModal" class="hidden fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg max-w-3xl w-full max-h-[90vh] overflow-y-auto">
        <div class="p-6">
            <div class="flex justify-between items-start mb-4">
                <h2 id="modalTitle" class="text-2xl font-bold text-gray-800"></h2>
                <button id="closeModal" class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>
            <div class="mb-6">
                <img id="modalImage" src="" alt="Content image" class="w-full h-64 object-cover rounded-lg mb-4">
                <div class="flex items-center text-sm text-gray-500 mb-2">
                    <i class="far fa-calendar-alt mr-2"></i>
                    <span id="modalDates"></span>
                </div>
                <div class="flex items-center text-sm text-gray-500 mb-4">
                    <i class="far fa-bookmark mr-2"></i>
                    <span id="modalType" class="capitalize"></span>
                </div>
                <p id="modalDescription" class="text-gray-700"></p>
            </div>
        </div>
    </div>
</div>

<script>

    const contextPath = "<%= request.getContextPath() %>";


    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const contentGrid = document.getElementById('contentGrid');
    const noContentMessage = document.getElementById('noContentMessage');
    const contentModal = document.getElementById('contentModal');
    const closeModal = document.getElementById('closeModal');


    const modalTitle = document.getElementById('modalTitle');
    const modalImage = document.getElementById('modalImage');
    const modalDates = document.getElementById('modalDates');
    const modalType = document.getElementById('modalType');
    const modalDescription = document.getElementById('modalDescription');


    function formatDate(dateString) {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(dateString).toLocaleDateString(undefined, options);
    }


    function showLoading() {
        loadingIndicator.classList.remove('hidden');
        contentGrid.classList.add('hidden');
        noContentMessage.classList.add('hidden');
        errorMessage.classList.add('hidden');
    }


    function showError(message) {
        loadingIndicator.classList.add('hidden');
        contentGrid.classList.add('hidden');
        noContentMessage.classList.add('hidden');
        errorMessage.classList.remove('hidden');
        errorText.textContent = message;
    }


    function openContentModal(content) {
        modalTitle.textContent = content.title;
        modalImage.src = content.imageUrl ? content.imageUrl.trim() : '';
        modalImage.alt = content.title;
        modalDates.textContent = formatDate(content.startDate) + " - " + formatDate(content.endDate);
        modalType.textContent = content.type;
        modalDescription.textContent = content.description;


        contentModal.classList.remove('hidden');


        document.body.style.overflow = 'hidden';
    }


    function closeContentModal() {
        contentModal.classList.add('hidden');


        document.body.style.overflow = 'auto';
    }


    async function fetchContent() {
        showLoading();

        try {

            const response = await fetch(contextPath + "/content");

            if (!response.ok) {
                throw new Error(Failed to fetch content: ${response.status} ${response.statusText});
            }

            const contentData = await response.json();
            console.log("Content data received:", contentData);


            loadingIndicator.classList.add('hidden');

            if (!contentData || contentData.length === 0) {
                noContentMessage.classList.remove('hidden');
                return;
            }


            renderContentCards(contentData);


            contentGrid.classList.remove('hidden');
        } catch (error) {
            console.error('Error fetching content:', error);
            showError(error.message);
        }
    }


    function renderContentCards(contentItems) {
        contentGrid.innerHTML = '';

        let activeItemsCount = 0;

        contentItems.forEach(item => {

            if (item.active !== false) {
                activeItemsCount++;
                const card = document.createElement('div');
                card.className = 'bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300';


                const imageUrl = item.imageUrl;

                card.innerHTML =
                    "<img src=\"" + imageUrl + "\" alt=\"" + item.title + "\" class=\"w-full h-48 object-cover\">" +
                    "<div class=\"p-4\">" +
                    "<div class=\"flex justify-between items-start mb-2\">" +
                    "<h3 class=\"text-lg font-semibold text-gray-800\">" + item.title + "</h3>" +
                    "<span class=\"px-2 py-1 text-xs rounded-full " +
                    (item.type === 'promotion' ? "bg-purple-100 text-purple-800" : "bg-blue-100 text-blue-800") +
                    " capitalize\">" + item.type + "</span>" +
                    "</div>" +
                    "<p class=\"text-gray-600 text-sm mb-3 line-clamp-2\">" + item.description + "</p>" +
                    "<div class=\"flex justify-between items-center text-xs text-gray-500\">" +
                    "<span>" + formatDate(item.startDate) + " - " + formatDate(item.endDate) + "</span>" +
                    "<button class=\"view-details-btn text-purple-600 hover:text-purple-800 font-medium\">" +
                    "View Details" +
                    "</button>" +
                    "</div>" +
                    "</div>";



                card.querySelector('.view-details-btn').addEventListener('click', () => {
                    openContentModal(item);
                });

                contentGrid.appendChild(card);
            }
        });


        if (activeItemsCount === 0) {
            noContentMessage.classList.remove('hidden');
        }
    }


    document.addEventListener('DOMContentLoaded', () => {

        fetchContent();


        closeModal.addEventListener('click', closeContentModal);


        contentModal.addEventListener('click', (event) => {
            if (event.target === contentModal) {
                closeContentModal();
            }
        });


        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && !contentModal.classList.contains('hidden')) {
                closeContentModal();
            }
        });
    });


</script>
</body>
</html>
