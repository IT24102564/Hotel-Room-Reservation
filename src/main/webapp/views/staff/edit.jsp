<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Staff - Luxe Hotel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

<header class="bg-white shadow-md">
    <div class="max-w-7xl mx-auto py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-purple-700">Edit Staff</h1>
        <a href="${pageContext.request.contextPath}/staff-list"
           class="text-sm text-purple-600 hover:text-purple-900">
            <i class="fas fa-arrow-left mr-1"></i> Back to Staff List
        </a>
    </div>
</header>

<main class="max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="bg-white shadow-md rounded-lg p-6">
        <form id="editStaffForm" class="space-y-6">

            <input type="hidden" id="staffId" name="staffId">

            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Personal Information</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700">Full Name *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" id="name" name="name"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="John Doe">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="name-error"></p>
                    </div>

                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email Address *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-gray-400"></i>
                            </div>
                            <input type="email" id="email" name="email"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="john.doe@example.com">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="email-error"></p>
                    </div>

                    <div>
                        <label for="phoneNumber" class="block text-sm font-medium text-gray-700">Phone Number *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-phone text-gray-400"></i>
                            </div>
                            <input type="text" id="phoneNumber" name="phoneNumber"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="(123) 456-7890">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="phoneNumber-error"></p>
                    </div>

                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-home text-gray-400"></i>
                            </div>
                            <input type="text" id="address" name="address"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="123 Main St, City, State">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="address-error"></p>
                    </div>
                </div>
            </div>

            <div class="border-b border-gray-200 pb-4 mb-4">
                <h2 class="text-lg font-medium text-gray-900 mb-4">Employment Information</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <div>
                        <label for="position" class="block text-sm font-medium text-gray-700">Position *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-briefcase text-gray-400"></i>
                            </div>
                            <select id="position" name="position"
                                    class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                                <option value="">Select Position</option>
                                <option value="MANAGER">Manager</option>
                                <option value="RECEPTIONIST">Receptionist</option>
                                <option value="HOUSEKEEPER">Housekeeper</option>
                                <option value="CHEF">Chef</option>
                                <option value="WAITER">Waiter</option>
                                <option value="SECURITY">Security</option>
                                <option value="MAINTENANCE">Maintenance</option>
                            </select>
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="position-error"></p>
                    </div>

                    <div>
                        <label for="department" class="block text-sm font-medium text-gray-700">Department *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-building text-gray-400"></i>
                            </div>
                            <select id="department" name="department"
                                    class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                                <option value="">Select Department</option>
                                <option value="MANAGEMENT">Management</option>
                                <option value="FRONT_DESK">Front Desk</option>
                                <option value="HOUSEKEEPING">Housekeeping</option>
                                <option value="FOOD_SERVICE">Food Service</option>
                                <option value="SECURITY">Security</option>
                                <option value="MAINTENANCE">Maintenance</option>
                            </select>
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="department-error"></p>
                    </div>

                    <div>
                        <label for="salary" class="block text-sm font-medium text-gray-700">Salary (Annual) *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <span class="text-gray-500 sm:text-sm">$</span>
                            </div>
                            <input type="number" id="salary" name="salary" step="0.01" min="0"
                                   class="pl-7 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                   placeholder="e.g. 45000">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="salary-error"></p>
                    </div>

                    <div>
                        <label for="hireDate" class="block text-sm font-medium text-gray-700">Hire Date *</label>
                        <div class="mt-1 relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar text-gray-400"></i>
                            </div>
                            <input type="date" id="hireDate" name="hireDate"
                                   class="pl-10 focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
                        </div>
                        <p class="error-message text-red-500 text-xs mt-1 hidden" id="hireDate-error"></p>
                    </div>
                </div>
            </div>

            <div>
                <h2 class="text-lg font-medium text-gray-900 mb-4">Additional Information</h2>

                <div>
                    <label for="notes" class="block text-sm font-medium text-gray-700">Notes</label>
                    <div class="mt-1">
                        <textarea id="notes" name="notes" rows="3"
                                  class="focus:ring-purple-500 focus:border-purple-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                                  placeholder="Additional information about the staff member"></textarea>
                    </div>
                    <p class="text-gray-500 text-xs mt-1">Optional notes about the staff member</p>
                </div>
            </div>

            <div class="pt-5 border-t border-gray-200">
                <div class="flex justify-end">
                    <a href="${pageContext.request.contextPath}/staff-list"
                       class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 mr-3 transition-colors">
                        Cancel
                    </a>
                    <button type="submit" id="submitButton"
                            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-colors">
                        <i class="fas fa-save mr-2"></i>
                        Update Staff
                    </button>
                </div>
            </div>
        </form>

        <div id="loadingIndicator" class="hidden mt-4 flex justify-center">
            <div class="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-purple-500"></div>
        </div>

        <div id="successMessage" class="hidden mt-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <div class="flex">
                <div class="py-1"><i class="fas fa-check-circle text-green-500 mr-3"></i></div>
                <div>
                    <p class="font-bold">Success!</p>
                    <p class="text-sm">Staff information has been updated successfully.</p>
                </div>
            </div>
        </div>

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
    document.addEventListener('DOMContentLoaded', function () {
        console.log('DOM fully loaded');


        const form = document.getElementById('editStaffForm');
        const submitButton = document.getElementById('submitButton');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');


        const urlParams = new URLSearchParams(window.location.search);
        const staffId = urlParams.get('id');


        document.getElementById('staffId').value = staffId;


        loadingIndicator.classList.remove('hidden');

        fetchStaffData(staffId);


        const validationRules = {
            name: {
                pattern: /^[A-Za-z\s]{2,50}$/,
                message: 'Name must be 2-50 characters and contain only letters and spaces.'
            },
            email: {
                pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
                message: 'Please enter a valid email address.'
            },
            phoneNumber: {
                pattern: /^[\d\s\(\)\-\+]{10,15}$/,
                message: 'Phone number must be 10-15 digits, can include spaces, parentheses, and hyphens.'
            },
            position: {
                pattern: /.+/,
                message: 'Please select a position.'
            },
            department: {
                pattern: /.+/,
                message: 'Please select a department.'
            },
            salary: {
                pattern: /^[0-9]+(\.[0-9]{1,2})?$/,
                message: 'Salary must be a valid number with up to 2 decimal places.'
            },
            hireDate: {
                pattern: /^\d{4}-\d{2}-\d{2}$/,
                message: 'Please select a valid hire date.'
            }
        };


        async function fetchStaffData(id) {
            try {
                var response = await fetch("/hotel_war_exploded/staff/" + id);

                if (!response.ok) {
                    throw new Error("Failed to fetch staff data");
                }

                var staffData = await response.json();


                document.getElementById('name').value = staffData.name;
                document.getElementById('email').value = staffData.email;
                document.getElementById('phoneNumber').value = staffData.phoneNumber;
                document.getElementById('address').value = staffData.address || '';
                document.getElementById('position').value = staffData.position;
                document.getElementById('department').value = staffData.department;
                document.getElementById('salary').value = staffData.salary;
                document.getElementById('hireDate').value = staffData.hireDate;
                document.getElementById('notes').value = staffData.notes || '';

            } catch (error) {
                console.error('Error fetching staff data:', error);
                errorText.textContent = "Failed to load staff data. Please try again later.";
                errorMessage.classList.remove("hidden");
            } finally {
                loadingIndicator.classList.add("hidden");
            }
        }


        function showError(fieldId, message) {
            var errorElement = document.getElementById(fieldId + "-error");

            if (errorElement) {
                errorElement.textContent = message;
                errorElement.classList.remove("hidden");
                document.getElementById(fieldId).classList.add("border-red-500");
            }
        }


        function hideError(fieldId) {
            var errorElement = document.getElementById(fieldId + "-error");

            if (errorElement) {
                errorElement.classList.add("hidden");
                document.getElementById(fieldId).classList.remove("border-red-500");
            }
        }


        function validateForm() {
            var isValid = true;


            document.querySelectorAll('.error-message').forEach(function (el) {
                el.classList.add('hidden');
            }
            for (var field in validationRules) {
                var input = document.getElementById(field);
                if (input && !validationRules[field].pattern.test(input.value)) {
                    showError(field, validationRules[field].message);
                    isValid = false;
                } else if (input) {
                    hideError(field);
                }
            }

            return isValid;
        }


        form.addEventListener('submit', async function (e) {
            e.preventDefault();
            console.log('Form submission initiated');


            successMessage.classList.add("hidden");
            errorMessage.classList.add("hidden");


            if (!validateForm()) {
                console.log('Form validation failed');
                return;
            }

            console.log('Form validation passed');


            loadingIndicator.classList.remove("hidden");
            submitButton.disabled = true;

            try {

                var staffData = {
                    id: document.getElementById('staffId').value,
                    name: document.getElementById('name').value.trim(),
                    email: document.getElementById('email').value.trim(),
                    phoneNumber: document.getElementById('phoneNumber').value.trim(),
                    address: document.getElementById('address').value.trim(),
                    position: document.getElementById('position').value,
                    department: document.getElementById('department').value,
                    salary: parseFloat(document.getElementById('salary').value),
                    hireDate: document.getElementById('hireDate').value,
                    notes: document.getElementById('notes').value.trim()
                };

                console.log('Sending data to server:', staffData);


                var response = await fetch("/hotel_war_exploded/staff/" + staffData.id, {
                    method: "PUT",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(staffData)
                });

                console.log('Response status:', response.status);

                if (!response.ok) {
                    var errorData = await response.json().catch(function () { return null; });
                    console.error('Error response data:', errorData);
                    throw new Error((errorData && errorData.message) || "Server responded with status: " + response.status);
                }


                successMessage.classList.remove("hidden");

                console.log('Staff updated successfully! Redirecting in 2 seconds...');


                setTimeout(function () {
                    window.location.href = '/hotel_war_exploded/staff-list';
                }, 2000);

            } catch (error) {
                console.error('Error updating staff:', error);
                errorText.textContent = error.message || 'There was an error updating the staff member.';
                errorMessage.classList.remove("hidden");
            } finally {
                loadingIndicator.classList.add("hidden");
                submitButton.disabled = false;
            }
        });

        for (var field in validationRules) {
            var input = document.getElementById(field);
            if (input) {
                input.addEventListener('input', function () {
                    if (validationRules[field].pattern.test(input.value)) {
                        hideError(field);
                    }
                });
            }
        }


        var phoneInput = document.getElementById('phoneNumber');
        if (phoneInput) {
            phoneInput.addEventListener('input', function (e) {

                var start = this.selectionStart;
                var end = this.selectionEnd;


                var value = this.value.replace(/\D/g, '');
                var formattedValue = '';

                if (value.length > 0) {
                    if (value.length <= 3) {
                        formattedValue = "(" + value;
                    } else if (value.length <= 6) {
                        formattedValue = "(" + value.substring(0, 3) + ") " + value.substring(3);
                    } else {
                        formattedValue = "(" + value.substring(0, 3) + ") " + value.substring(3, 6) + "-" + value.substring(6, 10);
                    }
                }

                if (this.value !== formattedValue) {
                    this.value = formattedValue;


                    var addedChars = formattedValue.length - value.length;
                    this.setSelectionRange(start + addedChars, end + addedChars);
                }
            });
        }
    });
</script>

</body>
</html>