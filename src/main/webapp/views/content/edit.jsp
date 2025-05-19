<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Content - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Edit Content</h1>
        <a href="${pageContext.request.contextPath}/content-list"
           class="text-sm text-purple-600 hover:text-purple-900">
            <i class="fas fa-arrow-left mr-1"></i> Back to Content List
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="bg-white shadow-md rounded-lg p-6">
        <!-- Loading Indicator (Initial) -->
        <div id="initialLoadingIndicator" class="flex justify-center items-center py-12">
            <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
            <span class="ml-3 text-gray-600">Loading content data...</span>
        </div>

        <!-- Initial Error Message -->
        <div id="initialErrorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6 text-center" role="alert">
            <strong class="font-bold">Error!</strong>
            <span class="block sm:inline">Failed to load content data. Please try again later.</span>
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/content-list"
                   class="inline-block bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                    Return to Content List
                </a>
            </div>
        </div>

        <!-- Form (Hidden initially) -->
        <form id="editContentForm" class="space-y-6 hidden">
            <input type="hidden" id="contentId" name="contentId">

            <!-- Basic Information Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Basic Information</h2>

                <div class="grid grid-cols-1 gap-6">
                    <!-- Title -->
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700">Title *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <input type="text" id="title" name="title"
                                   class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="Enter content title">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="title-error"></p>
                    </div>

                    <!-- Description -->
                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700">Description *</label>
                        <div class="mt-1">
                            <textarea id="description" name="description" rows="3"
                                      class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                      placeholder="Enter content description"></textarea>
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="description-error"></p>
                    </div>

                    <!-- Content Type -->
                    <div>
                        <label for="type" class="block text-sm font-medium text-gray-700">Content Type *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <select id="type" name="type"
                                    class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                                <option value="">Select Content Type</option>
                                <option value="banner">Banner</option>
                                <option value="promotion">Promotion</option>
                                <option value="announcement">Announcement</option>
                                <option value="event">Event</option>
                            </select>
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="type-error"></p>
                    </div>
                </div>
            </div>

            <!-- Media Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Media</h2>

                <div>
                    <label for="imageUrl" class="block text-sm font-medium text-gray-700">Image URL</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-image text-gray-400"></i>
                        </div>
                        <input type="url" id="imageUrl" name="imageUrl"
                               class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                               placeholder="https://example.com/image.jpg">
                    </div>
                    <p class="text-gray-500 text-xs mt-1">Enter a URL for the content image (optional)</p>
                    <p class="error-message text-red-500 text-xs mt-1 hidden" id="imageUrl-error"></p>

                    <!-- Image Preview -->
                    <div id="imagePreview" class="hidden mt-3">
                        <p class="text-sm text-gray-600 mb-2">Current Image:</p>
                        <img id="previewImage" src="" alt="Content Image" class="max-w-full h-auto max-h-48 rounded-md border border-gray-300">
                    </div>
                </div>
            </div>

            <!-- Schedule Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Schedule</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Start Date -->
                    <div>
                        <label for="startDate" class="block text-sm font-medium text-gray-700">Start Date *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar text-gray-400"></i>
                            </div>
                            <input type="date" id="startDate" name="startDate"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="startDate-error"></p>
                    </div>

                    <!-- End Date -->
                    <div>
                        <label for="endDate" class="block text-sm font-medium text-gray-700">End Date *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar text-gray-400"></i>
                            </div>
                            <input type="date" id="endDate" name="endDate"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="endDate-error"></p>
                    </div>
                </div>
            </div>

            <!-- Status Section -->
            <div>
                <h2 class="text-lg font-medium text-gray-900 mb-4">Status</h2>

                <div class="flex items-center">
                    <div class="flex items-center h-5">
                        <input id="active" name="active" type="checkbox"
                               class="focus:ring-purple-500 h-4 w-4 text-purple-600 border-gray-300 rounded">
                    </div>
                    <div class="ml-3 text-sm">
                        <label for="active" class="font-medium text-gray-700">Active</label>
                        <p class="text-gray-500">Content will be visible on the website</p>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="pt-5 border-t border-gray-200">
                <div class="flex justify-end">
                    <a href="${pageContext.request.contextPath}/content-list"
                       class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 mr-3 transition-colors">
                        Cancel
                    </a>
                    <button type="submit" id="submitButton"
                            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-colors">
                        <i class="fas fa-save mr-2"></i>
                        Update Content
                    </button>
                </div>
            </div>
        </form>

        <!-- Loading Indicator (For form submission) -->
        <div id="loadingIndicator" class="hidden mt-4 flex justify-center">
            <div class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-purple-500"></div>
        </div>

        <!-- Success Message -->
        <div id="successMessage" class="hidden mt-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Success!</p>
                    <p class="text-sm">Content has been updated successfully.</p>
                </div>
            </div>
        </div>

        <!-- Error Message -->
        <div id="errorMessage" class="hidden mt-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-exclamation-circle text-red-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Error!</p>
                    <p class="text-sm" id="errorText">Something went wrong. Please try again.</p>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Get content ID from URL
        const urlParams = new URLSearchParams(window.location.search);
        const contentId = urlParams.get('id');

        if (!contentId) {
            showInitialError('No content ID provided. Please select a content item to edit.');
            return;
        }


        const editContentForm = document.getElementById('editContentForm');
        const submitButton = document.getElementById('submitButton');
        const initialLoadingIndicator = document.getElementById('initialLoadingIndicator');
        const initialErrorMessage = document.getElementById('initialErrorMessage');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const imagePreview = document.getElementById('imagePreview');
        const previewImage = document.getElementById('previewImage');


        const validationRules = {
            title: {
                pattern: /^.{3,100}$/,
                message: 'Title must be between 3 and 100 characters.'
            },
            description: {
                pattern: /^.{10,500}$/,
                message: 'Description must be between 10 and 500 characters.'
            },
            type: {
                pattern: /^(banner|promotion|announcement|event)$/,
                message: 'Please select a valid content type.'
            },
            imageUrl: {
                pattern: /^(https?:\/\/.*\.(jpeg|jpg|gif|png))?$/,
                message: 'Please enter a valid image URL or leave it empty.',
                optional: true
            },
            startDate: {
                pattern: /^\d{4}-\d{2}-\d{2}$/,
                message: 'Please select a valid start date.'
            },
            endDate: {
                pattern: /^\d{4}-\d{2}-\d{2}$/,
                message: 'Please select a valid end date.'
            }
        };


        fetchContentData(contentId);


        function showError(fieldId, message) {
            const errorElement = document.getElementById(fieldId+-error);
            if (errorElement) {
                errorElement.textContent = message;
                errorElement.classList.remove('hidden');
                document.getElementById(fieldId).classList.add('border-red-500');
            }
        }


        function hideError(fieldId) {
            const errorElement = document.getElementById(fieldId+-error);
            if (errorElement) {
                errorElement.classList.add('hidden');
                document.getElementById(fieldId).classList.remove('border-red-500');
            }
        }


        function hideAllErrors() {
            document.querySelectorAll('.error-message').forEach(el => el.classList.add('hidden'));
            document.querySelectorAll('input, select, textarea').forEach(el => el.classList.remove('border-red-500'));
            errorMessage.classList.add('hidden');
        }


        function showInitialError(message) {
            const errorSpan = initialErrorMessage.querySelector('span');
            errorSpan.textContent = message;
            initialLoadingIndicator.classList.add('hidden');
            initialErrorMessage.classList.remove('hidden');
        }


        function showLoading() {
            submitButton.disabled = true;
            loadingIndicator.classList.remove('hidden');
        }


        function hideLoading() {
            submitButton.disabled = false;
            loadingIndicator.classList.add('hidden');
        }


        function showSuccess() {
            successMessage.classList.remove('hidden');

            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/content-list';
            }, 2000);
        }


        function showErrorMessage(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
        }


        function validateDates() {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);

            if (endDate < startDate) {
                showError('endDate', 'End date must be after start date.');
                return false;
            }

            hideError('endDate');
            return true;
        }


        function formatDateForInput(dateString) {
            if (!dateString) return '';
            const date = new Date(dateString);
            return date.toISOString().split('T')[0];
        }


        async function fetchContentData(id) {
            try {
                const response = await fetch(${pageContext.request.contextPath}/content/+id);

                if (!response.ok) {
                    throw new Error('Failed to fetch content data');
                }

                const content = await response.json();
                populateForm(content);

                initialLoadingIndicator.classList.add('hidden');
                editContentForm.classList.remove('hidden');

            } catch (error) {
                console.error('Error fetching content data:', error);
                showInitialError('Failed to load content data. Please try again later.');
            }
        }


        function populateForm(content) {
            document.getElementById('contentId').value = content.id;
            document.getElementById('title').value = content.title || '';
            document.getElementById('description').value = content.description || '';
            document.getElementById('type').value = content.type || '';
            document.getElementById('imageUrl').value = content.imageUrl || '';
            document.getElementById('startDate').value = formatDateForInput(content.startDate);
            document.getElementById('endDate').value = formatDateForInput(content.endDate);
            document.getElementById('active').checked = content.active;


            if (content.imageUrl) {
                previewImage.src = content.imageUrl;
                imagePreview.classList.remove('hidden');
            }
        }


        editContentForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            hideAllErrors();


            let isValid = true;

            for (const field in validationRules) {
                const input = document.getElementById(field);
                if (!input) continue;

                const value = input.value.trim();
                const rule = validationRules[field];


                if (rule.optional && value === '') {
                    continue;
                }

                if (!rule.pattern.test(value)) {
                    showError(field, rule.message);
                    isValid = false;
                } else {
                    hideError(field);
                }
            }


            if (!validateDates()) {
                isValid = false;
            }

            if (!isValid) {
                return;
            }

            showLoading();

            try {

                const formData = {
                    id: document.getElementById('contentId').value,
                    title: document.getElementById('title').value.trim(),
                    description: document.getElementById('description').value.trim(),
                    type: document.getElementById('type').value,
                    imageUrl: document.getElementById('imageUrl').value.trim() || null,
                    startDate: document.getElementById('startDate').value,
                    endDate: document.getElementById('endDate').value,
                    active: document.getElementById('active').checked
                };


                const response = await fetch(${pageContext.request.contextPath}/content/+formData.id, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                });

                if (!response.ok) {
                    const errorData = await response.json();
                    throw new Error(errorData.message || 'Failed to update content');
                }


                showSuccess();

            } catch (error) {
                console.error('Error updating content:', error);
                showErrorMessage(error.message || 'Failed to update content');
                hideLoading();
            }
        });


        const imageUrlInput = document.getElementById('imageUrl');
        imageUrlInput.addEventListener('blur', function() {
            const value = this.value.trim();

            if (value && !validationRules.imageUrl.pattern.test(value)) {
                showError('imageUrl', validationRules.imageUrl.message);
            } else {
                hideError('imageUrl');


                if (value) {
                    previewImage.src = value;
                    imagePreview.classList.remove('hidden');
                } else {
                    imagePreview.classList.add('hidden');
                }
            }
        });


        document.getElementById('startDate').addEventListener('change', validateDates);
        document.getElementById('endDate').addEventListener('change', validateDates);
    });
</script>

</body>
</html>
