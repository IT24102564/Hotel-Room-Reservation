<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Room - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 text-gray-900 min-h-screen">

<!-- Header -->
<header class="bg-white shadow-sm">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <i class="fas fa-hotel text-purple-600"></i>
            <h1 class="text-2xl font-bold text-purple-700">Edit Room</h1>
        </div>
        <a href="${pageContext.request.contextPath}/admin/rooms"
           class="flex items-center space-x-1 text-purple-600 hover:text-purple-900 transition-colors">
            <i class="fas fa-arrow-left text-sm"></i>
            <span>Back to Room List</span>
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <!-- Loading Indicator (Shown by default until data loads) -->
    <div id="loadingIndicator" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
    </div>

    <!-- Error Message (Hidden by default) -->
    <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Error!</strong>
        <span class="block sm:inline" id="errorText">Failed to load room details.</span>
    </div>

    <div id="formContainer" class="bg-white shadow rounded-lg overflow-hidden p-6 hidden">
        <!-- Form -->
        <form id="editRoomForm" class="space-y-6">
            <!-- Hidden Room ID field -->
            <input type="hidden" id="roomId" name="roomId">

            <!-- Room Details Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Room Details</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Room Number -->
                    <div>
                        <label for="roomNumber" class="block text-sm font-medium text-gray-700">Room Number *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-door-closed text-gray-400"></i>
                            </div>
                            <input type="text" id="roomNumber" name="roomNumber"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="e.g. 101">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="roomNumber-error"></p>
                    </div>

                    <!-- Room Type -->
                    <div>
                        <label for="roomType" class="block text-sm font-medium text-gray-700">Room Type *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-bed text-gray-400"></i>
                            </div>
                            <select id="roomType" name="roomType"
                                    class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                                <option value="">Select Room Type</option>
                                <option value="STANDARD">Standard</option>
                                <option value="DELUXE">Deluxe</option>
                                <option value="SUITE">Suite</option>
                                <option value="EXECUTIVE">Executive</option>
                                <option value="PRESIDENTIAL">Presidential</option>
                            </select>
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="roomType-error"></p>
                    </div>
                </div>
            </div>

            <!-- Pricing & Capacity Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Pricing & Capacity</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Price Per Night -->
                    <div>
                        <label for="pricePerNight" class="block text-sm font-medium text-gray-700">Price Per Night *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <span class="text-gray-500 sm:text-sm">$</span>
                            </div>
                            <input type="number" id="pricePerNight" name="pricePerNight" step="0.01" min="0"
                                   class="pl-7 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="e.g. 199.99">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="pricePerNight-error"></p>
                    </div>

                    <!-- Capacity -->
                    <div>
                        <label for="capacity" class="block text-sm font-medium text-gray-700">Capacity (persons) *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="number" id="capacity" name="capacity" min="1" max="10"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="e.g. 2">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="capacity-error"></p>
                    </div>
                </div>
            </div>

            <!-- Amenities Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Room Features</h2>

                <!-- Description -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                    <div class="mt-1">
                        <textarea id="description" name="description" rows="3"
                                  class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                  placeholder="Describe the room features and amenities"></textarea>
                    </div>
                    <p class="text-gray-500 text-xs mt-1">Add details about room size, view, and special amenities.</p>
                    <p class="error-message text-red-500 text-xs mt-1 hidden" id="description-error"></p>
                </div>

                <!-- Amenities Field -->
                <div class="mt-4">
                    <label for="amenities" class="block text-sm font-medium text-gray-700">Amenities</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-concierge-bell text-gray-400"></i>
                        </div>
                        <input type="text" id="amenities" name="amenities"
                               class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                               placeholder="e.g. AC, Wi-Fi, TV, Mini Bar">
                    </div>
                    <p class="text-gray-500 text-xs mt-1">Comma-separated list of room amenities</p>
                </div>
            </div>

            <!-- Image Section -->
            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Room Image</h2>

                <!-- Image URL -->
                <div>
                    <label for="imageUrl" class="block text-sm font-medium text-gray-700">Image URL</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-image text-gray-400"></i>
                        </div>
                        <input type="text" id="imageUrl" name="imageUrl"
                               class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                               placeholder="e.g. https://example.com/room-image.jpg">
                    </div>
                    <p class="text-gray-500 text-xs mt-1">Enter a valid URL for the room image</p>
                    <p class="error-message text-red-500 text-xs mt-1 hidden" id="imageUrl-error"></p>
                </div>
            </div>

            <!-- Availability -->
            <div class="flex items-start">
                <div class="flex items-center h-5">
                    <input id="available" name="available" type="checkbox" checked
                           class="focus:ring-purple-500 h-4 w-4 text-purple-600 border-gray-300 rounded">
                </div>
                <div class="ml-3 text-sm">
                    <label for="available" class="font-medium text-gray-700">Available for booking</label>
                    <p class="text-gray-500">Uncheck if the room is currently unavailable</p>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="pt-5 border-t border-gray-200">
                <div class="flex justify-end">
                    <a href="${pageContext.request.contextPath}/admin/rooms"
                       class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 mr-3 transition-colors">
                        Cancel
                    </a>
                    <button type="submit" id="submitButton"
                            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-colors">
                        <i class="fas fa-save mr-2"></i>
                        Update Room
                    </button>
                </div>
            </div>
        </form>

        <!-- Loading Indicator for Form Submission (Hidden by default) -->
        <div id="submitLoadingIndicator" class="hidden mt-4 flex justify-center">
            <div class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-purple-500"></div>
        </div>

        <!-- Success Message (Hidden by default) -->
        <div id="successMessage" class="hidden mt-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Success!</p>
                    <p class="text-sm">Room has been updated successfully.</p>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        const urlParams = new URLSearchParams(window.location.search);
        const roomId = urlParams.get('id');

        if (!roomId) {
            showError("Room ID is missing. Please go back and try again.");
            return;
        }


        document.getElementById('roomId').value = roomId;


        const editRoomForm = document.getElementById('editRoomForm');
        const submitButton = document.getElementById('submitButton');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const submitLoadingIndicator = document.getElementById('submitLoadingIndicator');
        const formContainer = document.getElementById('formContainer');
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');


        const validationRules = {
            roomNumber: {
                pattern: /^[A-Z0-9-]{1,10}$/,
                message: 'Room number must be 1-10 characters (letters, numbers, or hyphens).'
            },
            roomType: {
                pattern: /.+/,
                message: 'Please select a room type.'
            },
            pricePerNight: {
                pattern: /^[0-9]+(\.[0-9]{1,2})?$/,
                message: 'Price must be a valid number with up to 2 decimal places.'
            },
            capacity: {
                pattern: /^[1-9][0-9]?$/,
                message: 'Capacity must be a number between 1 and 10.'
            },
            description: {
                pattern: /^.{0,500}$/,
                message: 'Description must be less than 500 characters.'
            },
            imageUrl: {
                pattern: /^(https?:\/\/.*)?$/,
                message: 'Image URL must be a valid URL starting with http:// or https:// or be empty.'
            }
        };


        function showError(fieldId, message) {
            if (typeof fieldId === 'string' && typeof message === 'string') {
                // Field error
                const errorElement = document.getElementById(`${fieldId}-error`);
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.classList.remove('hidden');
                    document.getElementById(fieldId).classList.add('border-red-500');
                }
            } else if (typeof fieldId === 'string' && !message) {
                // General error
                document.getElementById('errorText').textContent = fieldId;
                errorMessage.classList.remove('hidden');
                loadingIndicator.classList.add('hidden');
            }
        }


        function hideError(fieldId) {
            const errorElement = document.getElementById(`${fieldId}-error`);
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


        function showLoading() {
            loadingIndicator.classList.remove('hidden');
        }


        function hideLoading() {
            loadingIndicator.classList.add('hidden');
        }


        function showForm() {
            formContainer.classList.remove('hidden');
        }


        function showSubmitLoading() {
            submitButton.disabled = true;
            submitLoadingIndicator.classList.remove('hidden');
        }


        function hideSubmitLoading() {
            submitButton.disabled = false;
            submitLoadingIndicator.classList.add('hidden');
        }


        function formatPrice(price) {
            return '$' + parseFloat(price).toFixed(2);
        }


        async function fetchRoomData() {
            showLoading();
            hideAllErrors();

            try {
                const response = await fetch(`${pageContext.request.contextPath}/rooms/`+roomId);

                if (!response.ok) {
                    throw new Error( "Failed to fetch room data. Status:"+response.status);
                }

                const roomData = await response.json();
                populateForm(roomData);
                hideLoading();
                showForm();
            } catch (error) {
                console.error('Error fetching room data:', error);
                showError(error.message || 'Failed to load room data');
                hideLoading();
            }
        }


        function populateForm(roomData) {
            document.getElementById('roomNumber').value = roomData.roomNumber || '';
            document.getElementById('roomType').value = roomData.roomType || '';
            document.getElementById('pricePerNight').value = roomData.pricePerNight || '';
            document.getElementById('capacity').value = roomData.capacity || '';
            document.getElementById('description').value = roomData.description || '';
            document.getElementById('amenities').value = roomData.amenities || '';
            document.getElementById('imageUrl').value = roomData.imageUrl || '';
            document.getElementById('available').checked = roomData.available !== false;
        }


        editRoomForm.addEventListener('submit', async function(e) {
            e.preventDefault();

            hideAllErrors();


            let isValid = true;

            for (const field in validationRules) {
                const input = document.getElementById(field);
                if (!input) continue;

                const value = input.value.trim();
                const rule = validationRules[field];

                if (!rule.pattern.test(value)) {
                    showError(field, rule.message);
                    isValid = false;
                } else {
                    hideError(field);
                }
            }

            if (!isValid) {
                return;
            }

            showSubmitLoading();

            try {

                const formData = {
                    id: roomId,
                    roomNumber: document.getElementById('roomNumber').value.trim(),
                    roomType: document.getElementById('roomType').value,
                    pricePerNight: parseFloat(document.getElementById('pricePerNight').value),
                    capacity: parseInt(document.getElementById('capacity').value),
                    description: document.getElementById('description').value.trim(),
                    amenities: document.getElementById('amenities').value.trim(),
                    imageUrl: document.getElementById('imageUrl').value.trim(),
                    available: document.getElementById('available').checked
                };


                const response = await fetch(`${pageContext.request.contextPath}/rooms/`+roomId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                });

                if (!response.ok) {
                    throw new Error(`Failed to update room. Status: ${response.status}`);
                }


                successMessage.classList.remove('hidden');


                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/admin/rooms';
                }, 2000);

            } catch (error) {
                console.error('Error updating room:', error);
                showError(error.message || 'Failed to update room');
                hideSubmitLoading();
            }
        });


        const roomNumberInput = document.getElementById('roomNumber');
        if (roomNumberInput) {
            roomNumberInput.addEventListener('input', function() {
                this.value = this.value.toUpperCase();
            });
        }


        fetchRoomData();
    });
</script>

</body>
</html>
