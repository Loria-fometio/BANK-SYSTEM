<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
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
        .transaction-history {
            margin-top: 40px;
        }
        .transaction-history h2 {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .transaction-history table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .transaction-history th,
        .transaction-history td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .transaction-history th {
            background-color: #007bff;
            color: #fff;
            font-weight: 500;
        }
        .transaction-history tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="bi bi-clock-history"></i> Transaction History</h1>
        <div class="transaction-history">
            <form id="historyForm">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="accountNumber" class="form-label"><i class="bi bi-credit-card"></i> Account Number</label>
                        <input type="text" class="form-control" id="accountNumber" name="account_number" placeholder="Enter account number" required>
                    </div>
<input type="hidden" id="userId" value="<?php echo $user_id; ?>"> <!-- Hidden input with user_id -->

                    <div class="col-md-6 align-self-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-search"></i> Fetch History
                        </button>
                    </div>
                </div>
            </form>
            <table id="historyTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Receiver Account</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Rows will be populated dynamically -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
 


<script>
document.getElementById('historyForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const accountNumber = document.getElementById('accountNumber').value;
    const userId = document.getElementById('userId').value; // Retrieve user_id from the hidden input

    fetch('fetch_transaction_history.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            account_number: accountNumber,
            user_id: userId  // Include user_id in the request body
        })
    })
    .then(response => response.json())
    .then(data => {
        const tbody = document.querySelector('#historyTable tbody');
        tbody.innerHTML = ''; // Clear previous data

        if (data.status === 'success') {
            data.transactions.forEach(transaction => {
                const row = `
                    <tr>
                        <td>${transaction.id}</td>
                        <td>${transaction.transaction_type}</td>
                        <td>${transaction.amount}</td>
                        <td>${transaction.date}</td>
                        <td>${transaction.description}</td>
                        <td>${transaction.receiver_account_number || 'N/A'}</td>
                    </tr>
                `;
                tbody.insertAdjacentHTML('beforeend', row);
            });
        } else {
            tbody.innerHTML = `<tr><td colspan="6" class="text-center">${data.message}</td></tr>`;
        }
    })
    .catch(error => console.error('Error:', error));
});
</script>

</body>
</html>