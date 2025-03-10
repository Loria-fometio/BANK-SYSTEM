<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Transaction</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Add custom styles here */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .transaction-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: 500;
            color: #333;
        }
        .form-control {
            border-radius: 5px;
            border: 1px solid #ced4da;
            padding: 10px;
            font-size: 16px;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        .submit-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            font-weight: 500;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
        #loadingSpinner {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
        }
        #responseMessage {
            margin-top: 20px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="bi bi-bank"></i> New Transaction</h1>
        <div class="transaction-container">
            <form id="transactionForm">
                <!-- Hidden user_id field (replace with actual user ID) -->
                <input type="hidden" id="user_id" name="user_id" value="1">

                <!-- Form fields -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="accountNumber" class="form-label"><i class="bi bi-credit-card"></i> Account Number</label>
                        <input type="text" class="form-control" id="accountNumber" name="account_number" placeholder="Enter account number" required>
                    </div>
                    <div class="col-md-6">
                        <label for="amount" class="form-label"><i class="bi bi-cash"></i> Amount</label>
                        <input type="number" class="form-control" id="amount" placeholder="Enter amount" name="amount" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="transactionType" class="form-label"><i class="bi bi-arrow-left-right"></i> Transaction Type</label>
                        <select class="form-control" id="transactionType" name="transaction_type" required>
                            <option value="">Select transaction type</option>
                            <option value="deposit">Deposit</option>
                            <option value="withdrawal">Withdrawal</option>
                            <option value="transfer">Transfer</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="date" class="form-label"><i class="bi bi-calendar"></i> Date</label>
                        <input type="date" class="form-control" id="date" name="date" required>
                    </div>
                </div>
                <!-- Receiver Account Number (Will be added dynamically) -->
                <div class="row mb-3" id="receiverAccountContainer" style="display: none;">
                    <div class="col-md-6">
                        <label for="receiverAccountNumber" class="form-label"><i class="bi bi-credit-card"></i> Receiver's Account Number</label>
                        <input type="text" class="form-control" id="receiverAccountNumber" name="receiver_account_number" placeholder="Enter receiver's account number">
                        <small id="receiverName" class="text-success"></small>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="description" class="form-label"><i class="bi bi-card-text"></i> Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter transaction description"></textarea>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary submit-button">
                        <i class="bi bi-check-circle"></i> Submit Transaction
                    </button>
                </div>
            </form>
            <!-- Response message will be displayed here -->
            <div id="responseMessage"></div>
        </div>
    </div>
    <span id="loadingSpinner" class="spinner-border spinner-border-sm" style="display: none;"></span>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set the current date in the date input field
        function setCurrentDate() {
            const dateInput = document.getElementById('date');
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0'); // Months are zero-based
            const day = String(today.getDate()).padStart(2, '0');
            const formattedDate = `${year}-${month}-${day}`; // Format: YYYY-MM-DD
            dateInput.value = formattedDate;
        }

        window.onload = setCurrentDate;

        // Show/hide Receiver Account Number field based on transaction type
        document.getElementById('transactionType').addEventListener('change', function () {
            const receiverAccountContainer = document.getElementById('receiverAccountContainer');
            if (this.value === 'transfer') {
                receiverAccountContainer.style.display = 'flex'; // Show when Transfer is selected
            } else {
                receiverAccountContainer.style.display = 'none'; // Hide for other transaction types
            }
        });

        // Form submission with AJAX request
        document.getElementById('transactionForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const transactionType = document.getElementById('transactionType').value;
            const receiverAccountNumber = document.getElementById('receiverAccountNumber').value;

            // Validate receiver account number for transfer transactions
            if (transactionType === 'transfer' && !receiverAccountNumber) {
                alert('Receiver account number is required for transfer transactions.');
                return;
            }

            const formData = new FormData(this);
            const submitButton = document.querySelector('.submit-button');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const responseMessage = document.getElementById('responseMessage');

            submitButton.disabled = true;
            loadingSpinner.style.display = 'inline-block';

            fetch('process_transaction.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())  // Parse the response as JSON
            .then(data => {
                console.log('Response:', data);
                if (data.status === 'success') {
                    responseMessage.innerHTML = `<div class="alert alert-success">${data.message}</div>`;
                } else {
                    responseMessage.innerHTML = `<div class="alert alert-danger">${data.message}</div>`;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                responseMessage.innerHTML = `<div class="alert alert-danger">An error occurred. Please try again.</div>`;
            })
            .finally(() => {
                submitButton.disabled = false;
                loadingSpinner.style.display = 'none';
            });
        });
    </script>
</body>
</html>