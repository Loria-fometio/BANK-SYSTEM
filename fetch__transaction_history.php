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
    exit;
}

// Get the account number and user_id from the request
$data = json_decode(file_get_contents('php://input'), true);
$account_number = $data['account_number'] ?? '';
$user_id = $data['user_id'] ?? '';  // Make sure user_id is included

if (empty($account_number) || empty($user_id)) {
    echo json_encode(['status' => 'error', 'message' => 'Account number and user ID are required.']);
    exit;
}

// Fetch transaction history for the account number and user_id
$sql = "SELECT * FROM transactions 
        WHERE account_number = ? AND user_id = ? 
        ORDER BY date DESC";
$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $account_number, $user_id);  // Bind account_number and user_id
$stmt->execute();
$result = $stmt->get_result();

$transactions = [];
while ($row = $result->fetch_assoc()) {
    $transactions[] = $row;
}

if (empty($transactions)) {
    echo json_encode(['status' => 'error', 'message' => 'No transactions found.']);
} else {
    echo json_encode(['status' => 'success', 'transactions' => $transactions]);
}

// Close the connection
$stmt->close();
$conn->close();
?>
