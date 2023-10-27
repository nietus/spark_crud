document.getElementById("registrationForm").addEventListener("submit", function(event) {
      event.preventDefault();

      const email = document.getElementById("email").value;
      const password = document.getElementById("senha").value;

      // Create a JSON object with user data
      const user = {
        email: email,
        password: password
      };

      // Send the user data to the server for registration
      fetch("/appuser/insert", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(user)
      })
        .then(response => {
          if (response.status === 201) {
            alert("Registration successful!");
            window.location.href = "login.html"; // Redirect to the login page
          } else {
            alert("Registration failed. Please try again.");
          }
        })
        .catch(error => {
          alert("An error occurred during registration: " + error);
        });
    });