<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Guest Feedback - Luna Luxury Hotel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-player/1.5.7/lottie-player.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
</head>
<body class="bg-gray-100">
<section class="py-12 sm:py-16 lg:py-20 bg-purple-900 relative overflow-hidden">
  <div class="absolute inset-0 opacity-10">
    <lottie-player src="https://assets1.lottiefiles.com/packages/lf20_zprb9vzj.json" background="transparent" speed="0.5" style="width: 100%; height: 100%;" loop autoplay></lottie-player>
  </div>
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
    <div class="text-center mb-12">
      <h2 class="text-3xl font-extrabold text-white sm:text-4xl">What Our Guests Say</h2>
      <p class="mt-4 max-w-3xl mx-auto text-xl text-purple-200">
        Don't just take our word for it
      </p>
    </div>

    <!-- Add feedback button -->
    <div class="text-center mb-8">
      <button id="add-feedback-btn" class="bg-white text-purple-900 hover:bg-purple-100 font-bold py-2 px-6 rounded-full shadow-lg transition duration-300 flex items-center mx-auto">
        <i class="fas fa-plus mr-2"></i> Share Your Experience
      </button>
    </div>

    <!-- Feedback grid - will be populated dynamically -->
    <div id="feedback-grid" class="mt-10 grid grid-cols-1 md:grid-cols-3 gap-8">
      <!-- Feedback items will be inserted here dynamically -->
      <div class="text-center text-white col-span-3">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-white"></div>
        <p class="mt-2">Loading feedback...</p>
      </div>
    </div>
  </div>
</section>

<!-- Create Feedback Modal -->
<div id="create-feedback-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
  <div class="bg-white rounded-xl shadow-2xl p-8 max-w-md w-full mx-4">
    <div class="flex justify-between items-center mb-6">
      <h3 class="text-2xl font-bold text-purple-900">Share Your Experience</h3>
      <button class="modal-close text-gray-500 hover:text-gray-700">
        <i class="fas fa-times text-xl"></i>
      </button>
    </div>

    <form id="create-feedback-form">
      <div class="mb-4">

        <input type="hidden" id="create-reservation-id" value="123" placeholder="Your reservation ID"
               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" required>
      </div>

      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2">
          Rating
        </label>
        <div class="flex space-x-2" id="create-rating">
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="1"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="2"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="3"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="4"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="5"></i>
        </div>
        <input type="hidden" id="create-rating-value" value="0" required>
      </div>

      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2">
          Your Comments
        </label>
        <textarea id="create-comment" rows="4" placeholder="Tell us about your stay..."
                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" required></textarea>
      </div>

      <div class="flex justify-end">
        <button type="button" class="modal-close bg-gray-200 text-gray-700 py-2 px-4 rounded-md hover:bg-gray-300 mr-2">
          Cancel
        </button>
        <button type="submit" class="bg-purple-600 text-white py-2 px-4 rounded-md hover:bg-purple-700">
          Submit Feedback
        </button>
      </div>
    </form>
  </div>
</div>

<!-- Edit Feedback Modal -->
<div id="edit-feedback-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
  <div class="bg-white rounded-xl shadow-2xl p-8 max-w-md w-full mx-4">
    <div class="flex justify-between items-center mb-6">
      <h3 class="text-2xl font-bold text-purple-900">Edit Your Feedback</h3>
      <button class="modal-close text-gray-500 hover:text-gray-700">
        <i class="fas fa-times text-xl"></i>
      </button>
    </div>

    <form id="edit-feedback-form">
      <input type="hidden" id="edit-feedback-id">

      <div class="mb-4">

        <input type="hidden" value="123" id="edit-reservation-id" placeholder="Your reservation ID"
               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" required>
      </div>

      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2">
          Rating
        </label>
        <div class="flex space-x-2" id="edit-rating">
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="1"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="2"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="3"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="4"></i>
          <i class="far fa-star text-2xl cursor-pointer hover:text-yellow-400 text-gray-300" data-rating="5"></i>
        </div>
        <input type="hidden" id="edit-rating-value" value="0" required>
      </div>

      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2">
          Your Comments
        </label>
        <textarea id="edit-comment" rows="4" placeholder="Tell us about your stay..."
                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-500" required></textarea>
      </div>

      <div class="flex justify-end">
        <button type="button" class="modal-close bg-gray-200 text-gray-700 py-2 px-4 rounded-md hover:bg-gray-300 mr-2">
          Cancel
        </button>
        <button type="submit" class="bg-purple-600 text-white py-2 px-4 rounded-md hover:bg-purple-700">
          Update Feedback
        </button>
      </div>
    </form>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="delete-confirm-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
  <div class="bg-white rounded-xl shadow-2xl p-8 max-w-md w-full mx-4">
    <div class="flex justify-between items-center mb-6">
      <h3 class="text-2xl font-bold text-red-600">Delete Feedback</h3>
      <button class="modal-close text-gray-500 hover:text-gray-700">
        <i class="fas fa-times text-xl"></i>
      </button>
    </div>

    <p class="text-gray-700 mb-6">Are you sure you want to delete this feedback? This action cannot be undone.</p>

    <div class="flex justify-end">
      <button type="button" class="modal-close bg-gray-200 text-gray-700 py-2 px-4 rounded-md hover:bg-gray-300 mr-2">
        Cancel
      </button>
      <button id="confirm-delete-btn" data-id="" class="bg-red-600 text-white py-2 px-4 rounded-md hover:bg-red-700">
        Delete
      </button>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const currentUserId = localStorage.getItem('userId');
    if (!currentUserId) {
      console.warn('No user ID found in localStorage');
    }

    // DOM elements
    const feedbackGrid = document.getElementById('feedback-grid');
    const addFeedbackBtn = document.getElementById('add-feedback-btn');

    // Modals
    const createModal = document.getElementById('create-feedback-modal');
    const editModal = document.getElementById('edit-feedback-modal');
    const deleteModal = document.getElementById('delete-confirm-modal');

    // Form elements
    const createForm = document.getElementById('create-feedback-form');
    const editForm = document.getElementById('edit-feedback-form');

    // Add event listeners
    addFeedbackBtn.addEventListener('click', () => openModal(createModal));

    // Close modal buttons
    document.querySelectorAll('.modal-close').forEach(button => {
      button.addEventListener('click', () => {
        closeModal(createModal);
        closeModal(editModal);
        closeModal(deleteModal);
      });
    });

    // Star rating functionality for create form
    const createStars = document.querySelectorAll('#create-rating i');
    const createRatingInput = document.getElementById('create-rating-value');

    createStars.forEach(star => {
      star.addEventListener('click', () => {
        const rating = star.getAttribute('data-rating');
        createRatingInput.value = rating;

        // Update stars visual
        createStars.forEach(s => {
          const sRating = s.getAttribute('data-rating');
          if (sRating <= rating) {
            s.classList.remove('far');
            s.classList.add('fas');
            s.classList.add('text-yellow-400');
          } else {
            s.classList.add('far');
            s.classList.remove('fas');
            s.classList.remove('text-yellow-400');
          }
        });
      });
    });

    // Star rating functionality for edit form
    const editStars = document.querySelectorAll('#edit-rating i');
    const editRatingInput = document.getElementById('edit-rating-value');

    editStars.forEach(star => {
      star.addEventListener('click', () => {
        const rating = star.getAttribute('data-rating');
        editRatingInput.value = rating;

        // Update stars visual
        editStars.forEach(s => {
          const sRating = s.getAttribute('data-rating');
          if (sRating <= rating) {
            s.classList.remove('far');
            s.classList.add('fas');
            s.classList.add('text-yellow-400');
          } else {
            s.classList.add('far');
            s.classList.remove('fas');
            s.classList.remove('text-yellow-400');
          }
        });
      });
    });

    // Form submissions
    createForm.addEventListener('submit', function(e) {
      e.preventDefault();

      const reservationId = document.getElementById('create-reservation-id').value;
      const rating = parseInt(createRatingInput.value);
      const comment = document.getElementById('create-comment').value;

      if (!reservationId || rating === 0 || !comment) {
        alert('Please fill in all fields and provide a rating');
        return;
      }

      const feedbackData = {
        userId: currentUserId,
        reservationId: reservationId,
        rating: rating,
        comment: comment,
        submissionDate: new Date().toISOString()
      };

      createFeedback(feedbackData);
    });

    editForm.addEventListener('submit', function(e) {
      e.preventDefault();

      const feedbackId = document.getElementById('edit-feedback-id').value;
      const reservationId = document.getElementById('edit-reservation-id').value;
      const rating = parseInt(editRatingInput.value);
      const comment = document.getElementById('edit-comment').value;

      if (!reservationId || rating === 0 || !comment) {
        alert('Please fill in all fields and provide a rating');
        return;
      }

      const feedbackData = {
        id: feedbackId,
        userId: currentUserId,
        reservationId: reservationId,
        rating: rating,
        comment: comment
      };

      updateFeedback(feedbackData);
    });

    // Delete confirmation button
    document.getElementById('confirm-delete-btn').addEventListener('click', function() {
      const feedbackId = this.getAttribute('data-id');
      deleteFeedback(feedbackId);
    });

    // Fetch all feedback on page load
    fetchFeedback();

    // CRUD Functions
    function fetchFeedback() {
      fetch('${pageContext.request.contextPath}/feedback')
              .then(response => {
                if (!response.ok) {
                  throw new Error('Failed to fetch feedback');
                }
                return response.json();
              })
              .then(feedbackList => {
                displayFeedback(feedbackList);
              })
              .catch(error => {
                console.error('Error fetching feedback:', error);
                feedbackGrid.innerHTML = `
                        <div class="col-span-3 text-center text-white">
                            <p>Failed to load feedback. Please try again later.</p>
                        </div>
                    `;
              });
    }

    function createFeedback(feedbackData) {
      fetch('${pageContext.request.contextPath}/feedback', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(feedbackData)
      })
              .then(response => {
                if (!response.ok) {
                  throw new Error('Failed to create feedback');
                }
                return response.json();
              })
              .then(createdFeedback => {
                closeModal(createModal);
                resetCreateForm();
                fetchFeedback(); // Refresh the list
              })
              .catch(error => {
                console.error('Error creating feedback:', error);
                alert('Failed to submit feedback. Please try again.');
              });
    }

    function updateFeedback(feedbackData) {
      fetch(`${pageContext.request.contextPath}/feedback/`+feedbackData.id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(feedbackData)
      })
              .then(response => {
                if (!response.ok) {
                  throw new Error('Failed to update feedback');
                }
                return response.json();
              })
              .then(updatedFeedback => {
                closeModal(editModal);
                fetchFeedback(); // Refresh the list
              })
              .catch(error => {
                console.error('Error updating feedback:', error);
                alert('Failed to update feedback. Please try again.');
              });
    }

    function deleteFeedback(feedbackId) {
      fetch(`${pageContext.request.contextPath}/feedback/`+feedbackId, {
        method: 'DELETE'
      })
              .then(response => {
                if (!response.ok) {
                  throw new Error('Failed to delete feedback');
                }
                closeModal(deleteModal);
                fetchFeedback(); // Refresh the list
              })
              .catch(error => {
                console.error('Error deleting feedback:', error);
                alert('Failed to delete feedback. Please try again.');
              });
    }

    function displayFeedback(feedbackList) {
      if (!feedbackList || feedbackList.length === 0) {
        feedbackGrid.innerHTML = `
                    <div class="col-span-3 text-center text-white">
                        <p>No feedback available yet. Be the first to share your experience!</p>
                    </div>
                `;
        return;
      }

      feedbackGrid.innerHTML = '';

      feedbackList.forEach(feedback => {
        const card = document.createElement('div');
        card.className = 'bg-white p-6 rounded-xl shadow-lg relative';

        // Check if current user is the author
        const isAuthor = currentUserId && feedback.userId === currentUserId;

        // Star rating HTML
        let starsHtml = '';
        for (let i = 1; i <= 5; i++) {
          if (i <= feedback.rating) {
            starsHtml += '<i class="fas fa-star"></i>';
          } else {
            starsHtml += '<i class="far fa-star"></i>';
          }
        }

        // Action buttons for author
        let actionsHtml = '';
        if (isAuthor) {
          actionsHtml =
                  "<div class=\"absolute top-4 right-4 flex space-x-2\">" +
                  "<button class=\"edit-feedback-btn text-blue-600 hover:text-blue-800\" data-id=\"" + feedback.id + "\">" +
                  "<i class=\"fas fa-edit\"></i>" +
                  "</button>" +
                  "<button class=\"delete-feedback-btn text-red-600 hover:text-red-800\" data-id=\"" + feedback.id + "\">" +
                  "<i class=\"fas fa-trash\"></i>" +
                  "</button>" +
                  "</div>";
        }

        const formattedDate = moment(feedback.submissionDate).format('MMM D, YYYY');

        card.innerHTML =
                actionsHtml +
                "<div class=\"flex items-center mb-4\">" +
                "<div class=\"text-yellow-400 flex\">" +
                starsHtml +
                "</div>" +
                "</div>" +
                "<p class=\"text-gray-600 mb-6\">" +
                feedback.comment +
                "</p>" +
                "<div class=\"flex items-center\">" +
                "<div class=\"w-10 h-10 bg-purple-200 rounded-full flex items-center justify-center\">" +
                "<i class=\"fas fa-user text-purple-700\"></i>" +
                "</div>" +
                "<div class=\"ml-3\">" +
                "<h4 class=\"text-sm font-semibold text-purple-900\">Guest #" + feedback.userId.substring(0, 8) + "</h4>" +
                "<p class=\"text-xs text-gray-500\">" + formattedDate + "</p>" +
                "</div>" +
                "</div>";

        feedbackGrid.appendChild(card);
      });

      // Add event listeners to edit and delete buttons
      document.querySelectorAll('.edit-feedback-btn').forEach(button => {
        button.addEventListener('click', function() {
          const feedbackId = this.getAttribute('data-id');
          openEditModal(feedbackId);
        });
      });

      document.querySelectorAll('.delete-feedback-btn').forEach(button => {
        button.addEventListener('click', function() {
          const feedbackId = this.getAttribute('data-id');
          openDeleteModal(feedbackId);
        });
      });
    }

    function openEditModal(feedbackId) {
      // Fetch the feedback data
      fetch(`${pageContext.request.contextPath}/feedback/`+feedbackId)
              .then(response => {
                if (!response.ok) {
                  throw new Error('Failed to fetch feedback details');
                }
                return response.json();
              })
              .then(feedback => {
                // Populate the form
                document.getElementById('edit-feedback-id').value = feedback.id;
                document.getElementById('edit-reservation-id').value = feedback.reservationId;
                document.getElementById('edit-rating-value').value = feedback.rating;
                document.getElementById('edit-comment').value = feedback.comment;

                // Update the stars visual
                editStars.forEach(s => {
                  const sRating = parseInt(s.getAttribute('data-rating'));
                  if (sRating <= feedback.rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                    s.classList.add('text-yellow-400');
                  } else {
                    s.classList.add('far');
                    s.classList.remove('fas');
                    s.classList.remove('text-yellow-400');
                  }
                });

                // Open the modal
                openModal(editModal);
              })
              .catch(error => {
                console.error('Error fetching feedback details:', error);
                alert('Failed to load feedback details. Please try again.');
              });
    }

    function openDeleteModal(feedbackId) {
      document.getElementById('confirm-delete-btn').setAttribute('data-id', feedbackId);
      openModal(deleteModal);
    }

    function resetCreateForm() {
      createForm.reset();
      createRatingInput.value = '0';

      // Reset stars visual
      createStars.forEach(s => {
        s.classList.add('far');
        s.classList.remove('fas');
        s.classList.remove('text-yellow-400');
      });
    }

    // Modal utils
    function openModal(modal) {
      modal.classList.remove('hidden');
      // Prevent body scrolling
      document.body.style.overflow = 'hidden';
    }

    function closeModal(modal) {
      modal.classList.add('hidden');
      // Restore body scrolling
      document.body.style.overflow = 'auto';
    }
  });
</script>
</body>
</html>