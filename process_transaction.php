<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Set header to return JSON
header('Content-Type: application/json');

// Database connection (replace with your own connection details)
$servername = "localhost"; // Database server
$username = "root"; // Database username
$password = ""; // Database password
$dbname = "bank_system"; // Database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Connection failed: ' . $conn->connect_error]);
    exit;  // Stop further processing
}

// For debugging, log POST data
error_log(print_r($_POST, true));  // This will log the form data

// Get data from form submission
$user_id = $_POST['user_id'] ?? '';  // Using null coalescing operator for safety
$account_number = $_POST['account_number'] ?? '';
$amount = $_POST['amount'] ?? '';
$transaction_type = $_POST['transaction_type'] ?? '';  // 'deposit', 'withdrawal', 'transfer'
$date = $_POST['date'] ?? '';  // e.g., '2025-03-09'
$description = $_POST['description'] ?? '';
$receiver_account_number = $_POST['receiver_account_number'] ?? '';  // For 'transfer' transactions

// Validate required fields
if (empty($user_id) || empty($account_number) || empty($amount) || empty($transaction_type) || empty($date) || empty($description)) {
    echo json_encode(['status' => 'error', 'message' => 'Error: Missing required form data.']);
    exit;
}

// Validate amount (must be a positive number)
if (!is_numeric($amount) || $amount <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'Error: Amount must be a positive number.']);
    exit;
}

// Step 1: Verify if the user exists
$checkUserQuery = "SELECT id FROM clients WHERE id = ?";
$stmt = $conn->prepare($checkUserQuery);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    echo json_encode(['status' => 'error', 'message' => 'Error: User not found.']);
    exit;
}

// Step 2: Verify receiver account for transfer transactions
if ($transaction_type == 'transfer') {
    if (empty($receiver_account_number)) {
        echo json_encode(['status' => 'error', 'message' => 'Error: Receiver account number is required for transfer transactions.']);
        exit;
    }

    // Debug: Log the receiver account number
    error_log("Receiver Account Number: " . $receiver_account_number);

    // Check if receiver account exists in the clients table
    $checkReceiverQuery = "SELECT account_number FROM clients WHERE account_number = ?";
    $stmt = $conn->prepare($checkReceiverQuery);
    $stmt->bind_param("s", $receiver_account_number);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 0) {
        echo json_encode(['status' => 'error', 'message' => 'Error: Receiver account does not exist.']);
        exit;
    }
}

// Step 3: Insert transaction into the database
$sql = "INSERT INTO transactions (user_id, account_number, amount, transaction_type, date, description, receiver_account_number)
        VALUES (?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("issssss", $user_id, $account_number, $amount, $transaction_type, $date, $description, $receiver_account_number);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Transaction recorded successfully.']);
} else {
    error_log("Transaction failed: " . $stmt->error);  // Log the error
    echo json_encode(['status' => 'error', 'message' => 'Transaction failed: ' . $stmt->error]);
}

// Step 4: Close the connection
$stmt->close();
$conn->close();
?>