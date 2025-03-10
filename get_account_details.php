<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json'); // Ensure JSON response

try {
    // Check if the user is logged in
    if (!isset($_SESSION['user_id'])) {
        throw new Exception("Unauthorized access. Please log in.");
    }

    // Database connection
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "bank_system";

    $conn = new mysqli($host, $username, $password, $database);
    if ($conn->connect_error) {
        throw new Exception("Database connection failed: " . $conn->connect_error);
    }

    // Get the user_id from the session
    $user_id = $_SESSION['user_id'];

    // Fetch account details
    $stmt = $conn->prepare("SELECT account_number, account_type, first_name FROM clients WHERE user_id = ?");
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Account exists, fetch details
        $stmt->bind_result($account_number, $account_type, $first_name);
        $stmt->fetch();

        // Return account details
        echo json_encode([
            "status" => "success",
            "account_number" => $account_number,
            "account_type" => $account_type,
            "first_name" => $first_name,
            // "balance" => $balance
        ]);
    } else {
        // No account found
        echo json_encode([
            "status" => "success",
            "message" => "No bank account found for this user."
        ]);
    }

    $stmt->close();
    $conn->close();
} catch (Exception $e) {
    http_response_code(500); // Internal Server Error
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>