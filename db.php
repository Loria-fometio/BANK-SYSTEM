<?php
header("Content-Type: text/plain");

// Database connection
$host = "localhost";
$username = "root";
$password = "";
$database = "bank_system";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}

// Get form data
$firstName = $_POST['firstName'] ?? '';
$email = $_POST['email'] ?? '';
$phone = $_POST['phone'] ?? '';
$accountNumber = $_POST['account'] ?? '';
$pincode = $_POST['pincode'] ?? '';
$accountType = $_POST['accountType'] ?? '';

// Make sure that email exists in the users table to retrieve the user_id
$userCheckQuery = "SELECT user_id FROM users WHERE email = ?";
$stmt = $conn->prepare($userCheckQuery);
$stmt->bind_param("s", $email);  // Search by email to get user_id
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows == 0) {
    // User doesn't exist, handle the error
    die("Error: User with that email does not exist.");
}

// Fetch the user_id
$stmt->bind_result($user_id);
$stmt->fetch();

// Proceed with the client insertion
$sql = "INSERT INTO clients (account_number, first_name, email, phone, pincode, account_type, user_id, created_at) 
        VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssssssi", $accountNumber, $firstName, $email, $phone, $pincode, $accountType, $user_id);

if ($stmt->execute()) {
    echo "Client added successfully!";
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
