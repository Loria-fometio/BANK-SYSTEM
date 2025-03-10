<!-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - BankPro</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            padding: 20px;
        }
        .transaction-table {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Your Dashboard</h1>
        <h2>Transaction History</h2>
        <table class="table table-striped transaction-table">
            <thead>
                <tr>
                    <th>Account Number</th>
                    <th>Amount</th>
                    <th>Type</th>
                    <th>Date</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody id="transactionTableBody">
                <!-- Transactions will be populated here -->
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Fetch transactions when the page loads
        fetch("fetch_transactions.php")
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    const transactions = data.transactions;
                    const tableBody = document.getElementById("transactionTableBody");

                    transactions.forEach(transaction => {
                        const row = document.createElement("tr");
                        row.innerHTML = `
                            <td>${transaction.account_number}</td>
                            <td>${transaction.amount}</td>
                            <td>${transaction.transaction_type}</td>
                            <td>${transaction.date}</td>
                            <td>${transaction.description}</td>
                        `;
                        tableBody.appendChild(row);
                    });
                } else {
                    alert("Failed to fetch transactions.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Something went wrong. Please try again later.");
            });
    </script>
</body>
</html> -->