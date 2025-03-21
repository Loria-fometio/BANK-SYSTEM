<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Client - BankPro</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007bff;
            margin-bottom: 30px;
            font-weight: 700;
            text-align: center;
            font-size: 28px;
        }
        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 12px;
            font-size: 14px;
            padding-left: 40px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #007bff;
            font-size: 18px;
            z-index: 2;
        }
        .btn-primary {
            width: 100%;
            background-color: #007bff;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-primary:active {
            transform: scale(0.98);
        }
        .btn-primary i {
            margin-right: 8px;
        }
        .alert {
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            margin-top: 20px;
        }
        .spinner-border {
            display: none;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><i class="bi bi-person-plus"></i> Add New Client</h2>
        <form id="newClientForm">
            <!-- Full Name -->
            <div class="mb-3">
                <label for="firstName" class="form-label">Full Name</label>
                <div class="input-group">
                    <i class="bi bi-person input-icon"></i>
                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="John Doe" required>
                </div>
            </div>
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <div class="input-group">
                    <i class="bi bi-envelope input-icon"></i>
                    <input type="email" class="form-control" id="email" name="email" placeholder="john.doe@example.com" required>
                </div>
            </div>
            <!-- Phone -->
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <div class="input-group">
                    <i class="bi bi-telephone input-icon"></i>
                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="123-456-7890" required>
                </div>
            </div>
            <!-- Account Number -->
            <div class="mb-3">
                <label for="account" class="form-label">Account Number</label>
                <div class="input-group">
                    <i class="bi bi-credit-card input-icon"></i>
                    <input type="text" class="form-control" id="account" name="account" placeholder="ACC123456" required>
                </div>
            </div>
            <!-- Pin Code -->
            <div class="mb-3">
                <label for="pincode" class="form-label">Pin Code</label>
                <div class="input-group">
                    <i class="bi bi-pin input-icon"></i>
                    <input type="text" class="form-control" id="pincode" name="pincode" placeholder="123456" required>
                </div>
            </div>
            <!-- Account Type -->
            <div class="mb-3">
                <label for="accountType" class="form-label">Account Type</label>
                <div class="input-group">
                    <i class="bi bi-wallet input-icon"></i>
                    <select class="form-control" id="accountType" name="accountType" required>
                        <option value="savings">Savings</option>
                        <option value="checking">Checking</option>
                        <option value="business">Business</option>
                    </select>
                </div>
            </div>
            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">
                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                <i class="bi bi-save"></i> Save Client
            </button>
        </form>
        <!-- Response Message -->
        <div id="responseMessage" class="mt-3"></div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script>
        document.getElementById("newClientForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form default action

            // Show loading spinner
            const submitButton = document.querySelector("#newClientForm button[type='submit']");
            const spinner = submitButton.querySelector(".spinner-border");
            spinner.style.display = "inline-block";
            submitButton.disabled = true;

            let formData = new FormData(this);

            fetch("db.php", {
                method: "POST",
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                document.getElementById("responseMessage").innerHTML = `<div class="alert alert-success">${data}</div>`;
                document.getElementById("newClientForm").reset(); // Clear form after success
            })
            .catch(error => {
                document.getElementById("responseMessage").innerHTML = `<div class="alert alert-danger">Error: ${error}</div>`;
            })
            .finally(() => {
                // Hide loading spinner
                spinner.style.display = "none";
                submitButton.disabled = false;
            });
        });
    </script>
</body>
</html>