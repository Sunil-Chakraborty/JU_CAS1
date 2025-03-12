<script>
        document.addEventListener('DOMContentLoaded', function () {
            // Function to get CSRF token
            function getCookie(name) {
                let cookieValue = null;
                if (document.cookie && document.cookie !== '') {
                    const cookies = document.cookie.split(';');
                    for (let i = 0; i < cookies.length; i++) {
                        const cookie = cookies[i].trim();
                        if (cookie.substring(0, name.length + 1) === (name + '=')) {
                            cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                            break;
                        }
                    }
                }
                return cookieValue;
            }
            const csrftoken = getCookie('csrftoken');

            // Function to check if the user has already voted
            function hasVoted() {
                return localStorage.getItem('voted') !== null;
            }

            // Function to set the vote timestamp
            function setVoteTimestamp() {
                localStorage.setItem('voted', new Date().toISOString());
            }

            // Form submission handler
            document.getElementById('feedback-form').addEventListener('submit', function (event) {
                if (hasVoted()) {
                    alert('You have already submitted feedback.');
                    event.preventDefault(); // Prevent form submission
                } else {
                    setVoteTimestamp();
					alert("Thanks for submission");
                }
            });

            // Function to clear local storage and session
            window.clearLocalStorage = function () {
                localStorage.clear();
                fetch('/vote/clear-session/', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRFToken': csrftoken  // Include the CSRF token for the request
                    },
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text(); // Use .text() instead of .json()
                })
                .then(data => {
                    if (data === "Session cleared") {
                        alert("Local storage and session cleared!");
                    } else {
                        alert("Failed to clear session.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("An error occurred while clearing the session.");
                });
            }
			
			// Timer code
            const timerElement = document.getElementById('timer');
            let timeLeft = 2 * 60; // 10 minutes in seconds

            function updateTimer() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                timerElement.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    document.getElementById('feedback-form').querySelectorAll('input').forEach(input => input.disabled = true);
                    alert('Time is up! You can no longer submit the form.');
                }
                timeLeft--;
            }

            const timerInterval = setInterval(updateTimer, 1000);
            updateTimer();
			
        });
</script>
	